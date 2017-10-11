# rex tokens.rex -o lexer.rb

class Lexer 

macro
  BLANK      [\ \t]+

rule
 {BLANK}      # Whitespace is nothing 
 \#.*$        # Comment is nothing
 
 #Literals
 \d+          { [:NUMBER, text.to_i] }
 \"[^"]*\"    { [:STRING, text[1..-2]] }
 \n+          { [:NEWLINE, text] }

 # Keywords
 end           { [:END, text] }
 function      { [:FUNCTION, text] }
 # No classes
 if                                    { [:IF, text] }
 else                                  { [:ELSE, text] }
 true                                  { [:TRUE, text] }
 false                                 { [:FALSE, text] }
 null                                  { [:NULL, text] }

 # No constants
 [a-z]\w*                              { [:IDENTIFIER, text] }
  
 # Special operators
  or                                    { [text, text] }
  and                                   { [text, text] }
  equals                                { [text, text] }
  not                                   { [text, text] }
  greaterthan                           { [text, text] }
  lessthan                              { [text, text] }
  greq                                  { [text, text] }
  lesseq                                { [text, text] }
  #catch all
  .                                     { [text, text] } # + => ["+", "+"]

inner
  def run(code)
    scan_setup(code)
    tokens = []
    while token = next_token
      tokens << token
    end
    tokens
  end
end

