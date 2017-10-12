require "../src/lexer"

code= <<-CODE
if 1:
  if 2:
    say("...")
    if false:
      pass
    say("done!")
  2

CODE

tokens = [
  [:IF, "if"], [:NUMBER, 1],
    [:INDENT, 2],
      [:IF, "if"], [:NUMBER, 2],
      [:INDENT, 4],
        [:IDENTIFIER, "say"], ["(", "("],
                                  [:STRING, "..."],
                                [")", ")"],
                                [:NEWLINE, "\n"],
        [:IF, "if"], [:FALSE, "false"],
        [:INDENT, 6],
          [:IDENTIFIER, "pass"],
        [:DEDENT, 4], [:NEWLINE, "\n"],
        [:IDENTIFIER, "say"], ["(", "("],
                                  [:STRING, "done!"],
                                [")", ")"],
    [:DEDENT, 2], [:NEWLINE, "\n"],
    [:NUMBER, 2],
  [:DEDENT, 0], [:NEWLINE, "\n"],
  [:NEWLINE, "\n"]
]

assert_equal tokens, Lexer.new.tokenize(code)
