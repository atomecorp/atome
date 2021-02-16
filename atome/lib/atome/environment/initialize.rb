class Quark
  def objectize params=nil
    if params
      @objectize=params
    else
      @objectize= :surkool
    end

  end
end

Sparkle.new

class Atome < Nucleon::Core::Nucleon
  include Nucleon
end

class Device
  def initialize
    # do not change the order of object creation below as the atome_id of those system object is based on their respective order
    # todo : allow the system to assign atome_id using internal password system
    # alert Nucleon.methods
    # Atome.color
    # puts Atome.method_defined?(:tabalou)

    a=Atome.new({color: :red})
    a.color({value: :orange})
     a.color({value: :blue, add: true})
    # a.color({value: :pink})
    alert a.color
    # alert "initialize.rb line 28 properties : #{a.properties}"
    #  Atome.new({atome_id: :dark_matter, id: :dark_matter, width: 0, height: 0, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden, color: :transparent})
    # device = Atome.new({language: :english, type: :particle, atome_id: :device, id: :device, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 1, overflow: :hidden, color: :transparent})
    #  Atome.new({type: :particle, atome_id: :intuition, id: :intuition, x: 0, xx: 0, y: 0, yy: 0, z: 3, overflow: :hidden, color: :transparent})
    #  Atome.new({type: :particle, atome_id: :view, id: :view, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :auto, parent: :intuition, color: :transparent, tactile: JS_utils.mobile})
    # # # # The lines below create a special atome that holds all resize_actions stored in the @@resize_actions variable
    # actions = Atome.new({atome_id: :actions, id: :actions})
    # actions.viewer_actions
    # Atome.new({atome_id: :atomes, id: :atomes})
    # Atome.new({type: :particle, atome_id: :messenger, id: :messenger})
    ## blackhole=dark_matter??
    ## collector=""
    ## buffer=""
    ## rights=""
    ## preset=""??
    # Render.initialize
  end
end


Device.new
