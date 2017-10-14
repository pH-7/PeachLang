code=<<-CODE
  function method(a, b):
    true
CODE

nodes = Nodes.new([
  FunctionNode.new("method", ["a", "b"],
      Nodes.new([TrueNode.new])
  )
})

assert_equal nodes, Parser.new.parse(code)
