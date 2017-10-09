code = <<-CODE
class pHSevenLang
    def does_it_work:
        "yeahhh!"

    phsevenlang_obj = pHSevenLang.new
    if phsevenlang_obj:
        print(phsevenlang_obj.does_it_work
CODE

assert_prints("yeahhh!\n") {
    Interpreter.new.eval(code)
}
