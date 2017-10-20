# PeachLang (Programming Language)

**PeachLang** is a simple interpreted language done with Ruby using Racc (the Ruby version of Yacc/Bison). The language has been made thanks to [MACournoyer's book](http://01script.com/comment-creer-son-langage-de-programmation/).

Although my favorite book (my bedside book :D) is by far the [Dragon Book](https://www.amazon.ca/Compilers-Principles-Techniques-Tools-2nd/dp/0321486811), Marc-André's book is really cool as well.


## Usage

From your terminal, you can execute the example peach file:

```bash
ruby code/PeachLang examples/PeachLang/say-hello.peach
```

Or... use the interactive shell, like

```bash
PeachLang Interpreter
CTRL+R to quit
>> say("Hi")
Hi
=> nil
```

## Modify "grammar.y"

If you change `grammar.y`, you will need to regenerate `parser.rb` file by using the following command:
```bash
racc -o parser.rb grammar.y
```

P.S. You will need to install Racc before doing it.

```bash
gem install racc
```


## Contact

Any questions, please ask me at *hi {{ AT }} ph7 {{ D0T }} me*
