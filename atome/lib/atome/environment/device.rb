class Device
  include DefaultValues

  def initialize
    # the object below is used to store the basic presets for common type of atomes
    Atome.new({atome_id: :preset, id: :preset, content: default_values, render: false})
    # the object below is used to hide some atomes rom the device view while still rendered
    Atome.new({atome_id: :black_hole, id: :black_hole, width: 0, height: 0, x: 0, xx: 0, y: 0, content: {}, render: false})
    # the object below is used to store the preferences and settings for current device
    Atome.new({atome_id: :device, id: :device, language: :english, type: :particle, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 1, overflow: :hidden, color: :transparent})
    # the object below hold all the tool that modify atomes
    Atome.new({atome_id: :intuition, id: :intuition, parent: :device, type: :particle, x: 0, xx: 0, y: 0, yy: 0, z: 3, overflow: :hidden, color: :transparent})
    # the object below is the main view for the current user on the current device
    Atome.new({atome_id: :view, id: :view, type: :particle, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :auto, parent: :intuition, color: :transparent, tactile: ATOME.is_mobile})
    # the object below is used to message other atomes (could be a user, a device, or any atomes locally or on the network)
    Atome.new({atome_id: :messenger, id: :messenger, content: {}, render: false})
    # the object below is used to store the right management for current device
    Atome.new({atome_id: :right, id: :right, render: false})
    # this object hold temporary items (useful for batch treatment) named collector could be rename ephemeral
    Atome.new({atome_id: :buffer, id: :buffer, render: false})
    # The lines below create a special atome that holds all internal actions such as resize_actions
    actions = Atome.new({atome_id: :actions, id: :actions, render: false})
    actions.viewer_actions
  end
end