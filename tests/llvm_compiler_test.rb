code = <<-CODE
    def say_it:
        text = "This is compiled!"
        puts(text)
    say_it()
CODE

# First, parse the code
node = Parser.new.parse(code)

# Now, Compile the code
compiler = LLVMCompiler.new
compiler.preamble
node.llvm_compile(compiler)
compiler.finish

compiler.optimize

# Compile and execute JIT
compiler.run
