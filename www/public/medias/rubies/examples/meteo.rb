########################### meteo ####################################


def input_text(default_text)
  t = text({ content: default_text, x: 333, y: 3, atome_id: :my_text_input })
  t.visual(33)
  # t.key(:down) do |evt|
    # w_get = JSUtils.client_width(t.atome_id)
    # t.width = :auto
    # t.width = if w_get > 300
    #             300
    #           else
    #             :auto
    #           end
  # end

  t.key(:up) do |evt|
#     # todo: get and limit number of char
#     `
#      var myDiv = $('#my_tex_input');
#     myDiv.text(myDiv.text().substring(0,15))
# //alert(myDiv.text().length);
# `
#     w_get = JSUtils.client_width(t.atome_id)
#     t.width = if w_get < 99
#                 99
#               elsif w_get > 300
#                 300
#               else
#                 :auto
#               end
#     JSUtils.client_height(t.atome_id)

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

input_text("clermont-ferrand")



def meteo_of(town)
  meteo(town) do |data|
    text({content: "la temperature a #{town} est de : "+ data.to_s, y:66})
  end
end


meteo_of("clermont-ferrand")

b=box({x:300, y:3, size:33, color: :red})

b.touch do
  meteo_of grab(:my_text_input).content
end