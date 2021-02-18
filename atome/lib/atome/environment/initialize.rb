class Quark
  # this object will be used to return an atome object instead of string
  # / Int / Array / hash when getting an  atome's property
end

Sparkle.new

class Atome < Nucleon
end

class Device
  def initialize
    # the object below is used to store the basic presets for common type of atomes
    Atome.new({atome_id: :preset, id: :preset, content: presets})
    # the object below is used to hide some atomes rom the device view while still rendered
    Atome.new({atome_id: :dark_matter, id: :dark_matter, width: 0, height: 0, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden, color: :transparent})
    # the object below is used to store the preferences and settings for current device
    Atome.new({atome_id: :device, id: :device, language: :english, type: :particle, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 1, overflow: :hidden, color: :transparent})
    # the object below hold all the ttol that modify atomes
    Atome.new({atome_id: :intuition, id: :intuition, type: :particle, x: 0, xx: 0, y: 0, yy: 0, z: 3, overflow: :hidden, color: :transparent})
    # the object below is the main view for the current user on the current device
    Atome.new({atome_id: :view, id: :view, type: :particle, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :auto, parent: :intuition, color: :transparent, tactile: JS_utils.mobile})
    # the object below is used to message other atomes (could be a user, a device, or any atomes locally or on the network)
    Atome.new({atome_id: :messenger, id: :messenger, type: :particle})
    # the object below is used to store the right managment for current device
    Atome.new({atome_id: :right, id: :right})
    # this object hold temporary items (usefull for batch treatment) named collector could be rename ephemeral
    Atome.new({atome_id: :buffer, id: :buffer, render: false})
    # The lines below create a special atome that holds all internal actions such as resize_actions
    # accessible thru @@resize_actions variable
    actions = Atome.new({atome_id: :actions, id: :actions})
    actions.viewer_actions
    # now we init the renderer
    Render.initialize
  end

  def presets
    # here are the default preset for common objects
    visual = {color: :lightgray, center: {y: 43, x: 16, dynamic: false}, z: 0, overflow: :visible, parent: :view}
    shape = visual.merge({type: :shape, width: 70, height: 70, content: {points: 2}})
    box = visual.merge(shape).merge(content: {points: 4})
    circle = visual.merge(shape).merge({color: :red, content: {points: 4, tension: "100%"}})
    text = visual.merge({type: :text, color: [red: 124, green: 124, blue: 124], size: 25, content: lorem})
    image = visual.merge({type: :image, color: :transparent, content: :atome})
    video = visual.merge({type: :video, color: :transparent, content: :atome})
    audio = visual.merge({type: :audio, color: :transparent, content: :atome})
    particle = {type: :particle}
    collector = {type: :collector}
    tool = visual.merge({type: :tool, width: 52, height: 50, parent: :intuition, content: :dummy})
    web = visual.merge({type: :web, color: :transparent, content: :atome})
    user = visual.merge({type: :user, color: :transparent, name: :anonymous, pass: :none, content: :anonymous})
    color = {content: :black}
    history = {}
    authorisation = {creator: :atome, read: :all, write: :all} # only set only creator can change it unless specfic authoration set by creator()
    shadow = {x: 0, y: 0, blur: 7, thickness: 0, color: [alpha: 0.3], invert: false}
    border = {thickness: 1, pattern: :solid, color: :red}
    blur = {default: 5}
    {value: {shape: shape, box: box, circle: circle, text: text, image: image, video: video, audio: audio, particle: particle, collector: collector, tool: tool, web: web, user: user, color: color, history: history, authorisation: authorisation, shadow: shadow, border: border, blur: blur}}
  end
end
# we create the recipient that will store all created atomes instances (cant be read using Atome.atomes)
Atome.atomise
# now we create the basic universe for the device and it's forthcoming atomes
Device.new
