require "rubygems"
require "parser"
require "nodes"

require "llvm/core"
require "llvm/execution_engine"
require "llvm/transforms/scalar"

LLVM.init_x86

# LLVM Helper to generate the dynamically bytecode (IR code)
class LLVMCompiler

  # Class constants
  PCHAR = LLVM.Pointer(LLVM::Int8) # Similar to the ""*char" in C
  INT   = LLVM::Int # Similar to int type in C

  # Attributes
  attr_reader :locals

  def initialize(mod=nil, function=nil)
    @module = mod || LLVM::Module.new("PeachLang")

    @locals = {} # Store the local names during compilation

    @function = function || @module.functions.named("main") ||
      @module.functions.add("main", [], LLVM.Void)

    @builder = LLVM::Builder.new # Will build the code
    @builder.position_at_end(@function.basic_blocks.append)

    @engine = LLVM::JITCompiler.new(@module) # Compiles the code
  end


  def preamble
    fun = @module.functions.add("puts", [PCHAR], INT)
    fun.linkage = :external
  end

  def finish
    @builder.ret_void
  end

  def new_string(value)
    @builder.global_string_pointer(value)
  end

  def new_number(value)
    LLVM::Int(value)
  end

  def call(name, args=[])
    function = @module.functions.named(name)
    @builder.call(function, *args)
  end

  def assign(name, value)
    ptr = @builder.alloca(value.type) # Allocate memory
    @builder.store(value, ptr)
    @locals[name] = ptr # Track of where the local name is stored
  end

  def load(name)
    ptr = @locals[name]
    @builder.load(ptr, name)
  end

  # Compiles the methods from Peach's runtime to functions
  def function(name)
    func = @module.functions.add(name, [], LLVM.Void)
    compiler = LLVMCompiler.new(@module, func)
    yield compiler
    compiler.finish
  end

  def optimize
    @module.verify! # Check if the code is vallid
    pass_manager = LLVM::PassManager.new(@engine)
    pass_manager.mem2reg!
  end

  def run
    @engine.run_function(@function)
  end

  # Shows the generated IR code (similar to assembly)
  def inspectCompiledCode
    @module.dump
  end
end

class Nodes
  def llvm_compile(compiler)
    nodes.map { |node| node.llvm_compile(compiler) }.last
  end
end

class NumberNode
  def llvm_compile(compiler)
    compiler.new_number(value)
  end
end

class StringNode
  def llvm_compile(compiler)
    compiler.new_string(value)
  end
end

class CallNode
  def llvm_compile(compiler)
    raise "Receiver not supported for compilation" if receiver

    compiled_arguments = arguments.map { |arg| arg.llvm_compile(compiler) }
    compiler.call(method, compiled_arguments)
  end
end

class GetLocalNode
  def llvm_compile(compiler)
    compiler.load(name)
  end
end

class SetLocalNode
  def llvm_compile(compiler)
    compiler.assign(name, value.llvm_compile(compiler))
  end
end

class FunctionNode
  def llvm_compile(compiler)
    raise "Parameters not supported for compilation" if !params.empty?
    compiler.function(name) do |function|
      body.llvm_compile(function)
    end
  end
end
