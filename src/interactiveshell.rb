class InteractiveShell
  def self.run(interpreter)
    puts "PeachLang Interpreter\n"
    puts "CTRL+R to quit"
    loop do
      line = Readline::readline(">> ")
      Readline::HISTORY.push(line)
      value = interpreter.eval(line)
      puts "=> #{value.ruby_value.inspect}"
    end
  end
end
