require "runtime/object"
require "runtime/class"
require "runtime/context"
require "runtime/method"

Constants = {}

Constants["Class"] = PeachClass.new
Constants["Class"].runtime_class = Constants["Class"]

Constants["Object"] = PeachClass.new
RootContext = Context.new(Constants["Object"].new)

Constants["Number"] = PeachClass.new

Constants["String"] = PeachClass.new

Constants["TrueClass"] = PeachClass.new
Constants["FalseClass"] = PeachClass.new
Constants["NullClass"] = PeachClass.new

Constants["true"] = Constants["TrueClass"].new_with_value(true)
Constants["false"] = Constants["FalseClass"].new_with_value(false)
Constants["null"] = Constants["NullClass"].new_with_value(nil)

Constants["Class"].def :new do |receiver, arguments|
    receiver.new
end

Constants["Object"].def :say do |receiver, arguments|
  puts arguments.first.ruby_value
  Constants["null"]
end
