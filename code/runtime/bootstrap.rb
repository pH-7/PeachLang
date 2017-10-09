Constants = {}

Constants["Class"] = pHSevenLangClass.new
Constants["Class"].runtime_class = Constants["Class"]
Constants["Object"] = pHSevenLangClass.new
Constants["Number"] = pHSevenLangClass.new
Constants["String"] = pHSevenLangClass.new

Constants["TrueClass"] = pHSevenLangClass.new
Constants["FalseClass"] = pHSevenLangClass.new
Constants["NilClass"] = pHSevenLangClass.new

Constants["true"] = Constants["TrueClass"].new_with_value(true)
Constants["false"] = Constants["FalseClass"].new_with_value(false)
Constants["nil"] = Constants["NilClass"].new_with_value(nil)

RootContext = Context.new(Constants["Object"].new)

Constants["Class"].def :new do |receiver, arguments|
    receiver.new
end

Constants["Object"].def :print do |receiver, arguments|
    puts arguments.first.ruby_value
    Constants["nil"]
end
