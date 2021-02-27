def box(value = {})
  preset = grab(:preset).get(:content)
  preset = preset[:box]
  preset = preset.merge(value)
  Atome.new(preset)
end

def circle(value = {})
  preset = grab(:preset).get(:content)
  preset = preset[:circle]
  preset = preset.merge(value)
  Atome.new(preset)
end

def text(value = {})
  preset = grab(:preset).get(:content)
  preset = preset[:text]
  preset = preset.merge(value)
  Atome.new(preset)
end

def image(value = {})
  preset = grab(:preset).get(:content)
  preset = preset[:image]
  preset = preset.merge(value)
  Atome.new(preset)
end

def video(value = {})
  preset = grab(:preset).get(:content)
  preset = preset[:video]
  preset = preset.merge(value)
  Atome.new(preset)
end