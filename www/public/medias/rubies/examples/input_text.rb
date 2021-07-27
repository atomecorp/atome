# input text example

def input_text(default_text)
  t = text({ content: default_text, x: 333, y: 33, atome_id: :my_tex_input })
  t.visual(33)
  t.key(:down) do |evt|
    w_get = JSUtils.client_width(t.atome_id)
    t.width = :auto
    t.width = if w_get > 300
                300
              else
                :auto
              end
  end

  t.key(:up) do |evt|
    # todo: get and limit number of char
    `
     var myDiv = $('#my_tex_input');
    myDiv.text(myDiv.text().substring(0,15))
alert(myDiv.text().length);
`
    w_get = JSUtils.client_width(t.atome_id)
    t.width = if w_get < 99
                99
              elsif w_get > 300
                300
              else
                :auto
              end
    JSUtils.client_height(t.atome_id)
    # infos.content = w_get
  end

  t.border(({ color: :red, thickness: 3, pattern: :dashed }))

  t.over do
    t.visual({ select: :all })
  end

  t.touch do
    t.visual({ select: :all })
  end
  return t
end

input_text("type your text here,I will disapear!!")
