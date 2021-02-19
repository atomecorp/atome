module Background
  def self.theme(color)
    device = get(:device)
    device.color(color)
    texture_tile = Atome.new(type: :image)
    texture_tile.content(:tile)
    texture_tile.opacity(0.05)
    texture_tile.fill({target: device, size: 7})
    texture_tile.z(0)
    texture_tile.width("100%")
    texture_tile.height("100%")
    device.insert(texture_tile)
  end
end