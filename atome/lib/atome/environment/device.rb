class Device
  include DefaultValues

  def initialize
    # the object below is used to store the basic presets for common type of atomes
    Atome.new({ atome_id: :preset, content: default_values, render: false })
    # the object below is used to hide some atomes rom the device view while still rendered
    Atome.new({ atome_id: :black_hole, content: {}, width: 0, height: 0, x: 0, y: 0, render: false })
    # the object below is used to store the preferences and settings for current device
    Atome.new({ atome_id: :device, language: :english, type: :particle, width: "100%", height: "100%", x: 0, y: 0, z: 1, overflow: :hidden, color: :transparent })
    # the object below hold all the tool that modify atomes
    Atome.new({ atome_id: :intuition, parent: :device, type: :particle, width: "100%", height: "100%", x: 0, y: 0, z: 3, overflow: :hidden, color: :transparent })
    # the object below is the main view for the current user on the current device
    Atome.new({ atome_id: :view, type: :particle, width: "100%", height: "100%", x: 0, y: 0, z: 0, overflow: :auto, parent: :intuition, color: { red: 0, green: 0, blue: 0, alpha: 0 }, tactile: ATOME.is_mobile })
    # the object below is used to message other atomes (could be a user, a device, or any atomes locally or on the network)
    Atome.new({ atome_id: :messenger, render: false })
    # the object below is used to store the right management for current device
    Atome.new({ atome_id: :right, render: false })
    # this object hold temporary items (useful for batch treatment) named collector could be rename ephemeral
    Atome.new({ atome_id: :buffer, render: false , content: {resize: []}})
  end
end