# input text example

def input_text(default_text)
  t = text({ content: default_text, x: 333, y: 33, atome_id: :my_text_input })
  t.visual(33)
  t.key(:down) do |evt|
    `if($("#"+#{t.atome_id}).text().length === 15 && event.keyCode != 8) {
  	event.preventDefault();
 }`
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
    # we use .read to get the content according to the current language
    # content_found=t.content.read
    # content_length=content_found.values[0].length
    # # t.content.read.length
    # if content_length > 10
    #   t.content = content_found
    # else
    #
    # end
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

input_text("type here,15 char max!!")
