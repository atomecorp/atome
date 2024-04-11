
new({preset: :box }) do |params = {},&bloc|
    atome_preset = :box
    params = atome_common(atome_preset, params)
    preset_common(params, &bloc)
end


new({preset: :circle }) do |params = {},&bloc|
  atome_preset = :circle
  params = atome_common(atome_preset, params)
  preset_common(params, &bloc)
end

