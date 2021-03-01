def box(value = {})
  if value.instance_of?(String)
    value={content: value}
  end
  preset = grab(:preset).get(:content)
  preset = preset[:box]
  preset = preset.merge(value)
  Atome.new(preset)
end

def circle(value = {})
  if value.instance_of?(String)
    value={content: value}
  end
  preset = grab(:preset).get(:content)
  preset = preset[:circle]
  preset = preset.merge(value)
  Atome.new(preset)
end

def text(value = {})
  if value.instance_of?(String)
    value={content: value}
  end
  preset = grab(:preset).get(:content)
  preset = preset[:text]
  preset = preset.merge(value)
  Atome.new(preset)
end

def image(value = {})
  if value.instance_of?(String)
    value={content: value}
  end
  preset = grab(:preset).get(:content)
  preset = preset[:image]
  preset = preset.merge(value)
  Atome.new(preset)
end

def video(value = {})
  if value.instance_of?(String)
    value={content: value}
  end
  preset = grab(:preset).get(:content)
  preset = preset[:video]
  preset = preset.merge(value)
  Atome.new(preset)
end

def audio(value = {})
  if value.instance_of?(String)
    value={content: value}
  end
  preset = grab(:preset).get(:content)
  preset = preset[:audio]
  preset = preset.merge(value)
  Atome.new(preset)
end