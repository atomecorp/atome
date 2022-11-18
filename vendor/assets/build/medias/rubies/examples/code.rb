# frozen_string_literal: true

mycode = <<Struct
#circle({color: :red})
alert :it_works
Struct

Atome.new(code: { type: :code, data: mycode, render: [:html] })
cc = Atome.new
cc.code("alert 'it works too'")

code("alert :perfect")
