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
        return_value || Constants["nill"]
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

class NilNode
    def eval(context)
        Constants["nil"]
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


class DefNode
    def eval(context)
        method = pHSevenLangMethod.new(params, body)
        context.current_class.runtime_methods[name] = method
    end
end

class ClassNode
    def eval(context)
        pHClass = Constants[name] #Check if the class is already defined or not
        unless pHClass #Class doesn't exist yet
            pHClass = pHSevenLangClass.new
            Constants[name] = pHClass # Define the class in the runtime
        end

        pHClass = Context.new(pHClass, pHClass)
        body.eval(pHClass)
    end
end


class IfNode
    def eval(context)
        if condition.eval(context).ruby_value
            body.eval(context)
        else # If nobody evaluated it, returns nill
            Constants["nil"]
        end
    end
end
