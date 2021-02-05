Sparkle.new

class Atome < Nucleon::Core::Nucleon
  include Nucleon
end

class Device
  def initialize

    # do not change the order of object creation below as the atome_id of those system object is based on their respective order
    # todo : allow the system to assign atome_id using internal password system
    blackhole = Atome.new({type: :particle, id: :blackhole, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden, color: :transparent})
    dark_matter = Atome.new({type: :particle, id: :dark_matter, width: 0, height: 0, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden, color: :transparent})
    device = Atome.new({type: :particle, id: :device, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 1, overflow: :hidden, color: :transparent})
    intuition = Atome.new({type: :particle,  id: :intuition, x: 0, xx: 0, y: 0, yy: 0, z: 3, overflow: :hidden, color: :transparent})
    view = Atome.new({type: :particle, id: :view, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :auto, parent: :intuition, color: :transparent, tactile: JS_utils.mobile})
    # The lines below creat a special atome that holds all resize_actions stored in the @@resize_actions variable
    actions = Atome.new
    actions.id(:actions)
    actions.viewer_actions
    device.language(:english)
    Render.initialize
  end
end


Device.new
