class Quark
  # this object will be used to return an atome object instead of string
  # / Int / Array / hash when getting an  atome's property
end

Sparkle.new

class Atome < Nucleon
end

class Device
  def initialize
    # do not change the order of object creation below as the atome_id of those system object is based on their respective order
    # todo : allow the system to assign atome_id using internal password system
    Atome.new({atome_id: :preset, id: :preset})
    Atome.new({atome_id: :dark_matter, id: :dark_matter, width: 0, height: 0, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden, color: :transparent})
    Atome.new({language: :english, type: :particle, atome_id: :device, id: :device, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 1, overflow: :hidden, color: :transparent})
    Atome.new({type: :particle, atome_id: :intuition, id: :intuition, x: 0, xx: 0, y: 0, yy: 0, z: 3, overflow: :hidden, color: :transparent})
    Atome.new({type: :particle, atome_id: :view, id: :view, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :auto, parent: :intuition, color: :transparent, tactile: JS_utils.mobile})
    Atome.new({atome_id: :atomes, id: :atomes})
    Atome.new({type: :particle, atome_id: :messenger, id: :messenger})
    Atome.new({atome_id: :right, id: :right})
    Atome.new({atome_id: :collector, id: :collector})
    Atome.new({atome_id: :buffer, id: :buffer})
    # The lines below create a special atome that holds all resize_actions stored in the @@resize_actions variable
    #actions = Atome.new({atome_id: :actions, id: :actions})
    #actions.viewer_actions
    # now we init the renderer
    #Render.initialize
  end
end

Device.new
