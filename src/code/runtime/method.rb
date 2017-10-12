class PeachMethod
    def initialize(params, body)
        @params = params
        @body = body
    end

    def call(receiver, arguments)
        context = context.new(receiver)

        @params.each_with_index do |param, index|
            context.locals[param] = arguments[index]
        end

        @body.eval(context)
    end
end
