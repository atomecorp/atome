# frozen_string_literal: true

new({particle: :width })
new({particle: :height })
new({particle: :size }) do |params|
  atome_width = atome[:width]
  atome_height = atome[:height]
  aspect_ratio = atome_width / atome_height
  if atome_width > atome_height
    width(params)
    height(params / aspect_ratio)
  else
    width(params * aspect_ratio)
    height(params)
  end
end
