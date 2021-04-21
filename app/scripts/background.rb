module Background
  def self.theme(color)
    device = grab(:device)
    device.color(color)
    texture_tile = Atome.new(type: :image, atome_id: :background)
    texture_tile.content(:tile)
    texture_tile.opacity(0.05)
    texture_tile.fill({target: device, size: 7})
    texture_tile.z(0)
    texture_tile.width("100%")
    texture_tile.height("100%")
    device.insert(texture_tile.atome_id)
  end
end

# #examples
# blue_gradient=['#4160A9', '#2F3EC3']
# green_gradient=['#3F7070', '#0FB172']
# bluegreen_gradient=['#0FB172', '#2F3EC3']
# Background.theme(bluegreen_gradient)
