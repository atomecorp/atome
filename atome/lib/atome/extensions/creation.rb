def box(value = {})
  preset = grab(:preset).content
  preset = preset[:box]
  preset = preset.merge(value)
  Atome.new(preset)
end

def text(value = {})
  preset = grab(:preset).content
  preset = preset[:text]
  preset = preset.merge(value)
  Atome.new(preset)
end

def image(value = {})
  preset = grab(:preset).content
  preset = preset[:text]
  preset = preset.merge(value)
  Atome.new(preset)
end