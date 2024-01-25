# frozen_string_literal: true


b = box({ drag: true })

A.example(:left) do
  english = 'here is an example, touch me to get some help, or click the code to exec'
  french = "voici un example, click moi pour de l'aide, ou  clicker le code pour l'executer"
  code = <<STR
b=box
puts b.left
b.left(155)
puts b.left
STR
  example = text({ int8: { english: english, french: french }, language: :english, width: 666 })
  code_text = text({ int8: { english: code }, language: :english, width: 666, top: 33 })
  example.touch(true) do
    example.delete(true)
    help(:left)
  end
  code_text.touch(true) do
    eval(code)
  end
end


  b.example(:left)
