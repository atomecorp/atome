# frozen_string_literal: true

# document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor = 'red'
# alert(document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor)

generator = Genesis.generator

generator.build_atome(:code)
mycode = <<Struct
#circle({color: :red})
alert :ok
Struct

# TODO : add a global sanitizer
Atome.new(code: { id: :code1, code: mycode, parents: [], children:[], render: [] })