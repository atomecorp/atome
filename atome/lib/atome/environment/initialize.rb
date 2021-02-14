Sparkle.new

class Atome < Nucleon::Core::Nucleon
  include Nucleon
end

class Device
  def initialize
    # do not change the order of object creation below as the atome_id of those system object is based on their respective order
    # todo : allow the system to assign atome_id using internal password system
     Atome.new({type: :particle, atome_id: :dark_matter, id: :dark_matter, width: 0, height: 0, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden, color: :transparent})
    device = Atome.new({type: :particle, atome_id: :device, id: :device, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 1, overflow: :hidden, color: :transparent})
     Atome.new({type: :particle, atome_id: :intuition, id: :intuition, x: 0, xx: 0, y: 0, yy: 0, z: 3, overflow: :hidden, color: :transparent})
     Atome.new({type: :particle, atome_id: :view, id: :view, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :auto, parent: :intuition, color: :transparent, tactile: JS_utils.mobile})
    # # # The lines below create a special atome that holds all resize_actions stored in the @@resize_actions variable
    device.language(:english)
    actions = Atome.new({atome_id: :actions, id: :actions})
    actions.viewer_actions

    Render.initialize
  end
end


Device.new
