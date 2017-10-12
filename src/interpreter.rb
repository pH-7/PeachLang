require "parser"
require "runtime"

class Interpreter
  def initialize
    @parser = Parser.new
  end

  def eval(code)
    @parser.parse(code).eval(RootContext)
  end
end

class Nodes
  def eval(context)
    return_value = nil
    nodes.each do |node|
      return_value = node.eval(context)
    end

    return_value || Constants["null"]
  end
end

class NumberNode
  def eval(context)
    Constants["Number"].new_with_value(value)
  end
end

class StringNode
    def eval(context)
        Constants["String"].new_with_value(value)
    end
end

class TrueNode
    def eval(context)
        Constants["true"]
    end
end

class FalseNode
    def eval(context)
        Constants["false"]
    end
end

class NullNode
    def eval(context)
        Constants["null"]
    end
end

class GetConstantNode
    def eval(context)
        Constants[name]
    end
end

class GetLocalNode
    def eval(context)
        context.locals[name]
    end
end

class SetConstantNode
    def eval(context)
        Constants[name] = value.eval(context)
    end
end

class SetLocalNode
    def eval(context)
        context.locals[name] = value.eval(context)
    end
end

class CallNode
  def eval(context)
    if receiver
      value = receiver.eval(context)
    else
      value = context.current_self
    end
    evaluated_arguments = arguments.map { |arg| arg.eval(context) }
    value.call(method, evaluated_arguments)
  end
end

class FunctionNode
    def eval(context)
        method = PeachMethod.new(params, body)
        context.current_class.runtime_methods[name] = method
    end
end

class ClassNode
  def eval(context)
    peach_class = Constants[name] #Check if the class is already defined or not
      unless peach_class #Class doesn't exist yet
      peach_class = peach_class.new
      Constants[name] = peach_class # Define the class in the runtime
    end

    peach_class = Context.new(peach_class, peach_class)
    body.eval(peach_class)
  end
end

class IfNode
  def eval(context)
    if condition.eval(context).ruby_value
      body.eval(context)
    else # If no body is evaluated, we return nil.
      Constants["null"]
    end
  end
end
