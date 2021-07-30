########################### meteo ####################################

def input_text(default_text)
  t = text({ content: default_text, x: 333, y: 3, atome_id: :my_text_input })
  t.visual(33)

  t.key(:up) do |evt|

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

text({ content: "temperature", y: 66, atome_id: :meteo_result })

def meteo_of(town)
  meteo(town) do |data|
    grab(:meteo_result).content("la temperature a #{town} est de : " + data.to_s)
  end
end

meteo_of("clermont-ferrand")

b = box({ x: 300, y: 3, size: 33, color: :red })

b.touch do
  content_found = grab(:my_text_input).content.read
  content_toe_send = content_found[grab(:view).language] || content_found[:default]
  meteo_of content_toe_send
end