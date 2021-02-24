def box(value = {})
  preset = grab(:preset).content
  preset = preset[:box]
  preset = preset.merge(value)
  alert preset
  Atome.new(preset)
end