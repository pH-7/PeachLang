code=<<-CODE
  def method(a, b):
    true
CODE

nodes = Nodes.new([
  DefNode.new("method", ["a", "b"],
      Nodes.new([TrueNode.new])
  )
})

assert_equal nodes, Parser.new.parse(code)
