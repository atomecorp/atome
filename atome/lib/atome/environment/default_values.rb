module DefaultValues
  def default_values
    # here are the default preset for common objects
    visual = {color: :lightgray, center: {y: 43, x: 16, dynamic: false}, z: 0, overflow: :visible, parent: :view}
    shape = visual.merge({type: :shape, width: 70, height: 70, value: {points: 2}})
    box = visual.merge(shape).merge(value: {points: 4})
    circle = visual.merge(shape).merge({color: :red, value: {points: 4, tension: "100%"}})
    text = visual.merge({type: :text, color: [red: 124, green: 124, blue: 124], size: 25, value: lorem})
    image = visual.merge({type: :image, color: :transparent, value: :atome})
    video = visual.merge({type: :video, color: :transparent, value: :atome})
    audio = visual.merge({type: :audio, color: :transparent, value: :atome})
    particle = {type: :particle}
    collector = {type: :collector}
    tool = visual.merge({type: :tool, width: 52, height: 50, parent: :intuition, value: :dummy})
    web = visual.merge({type: :web, color: :transparent, value: :atome})
    user = visual.merge({type: :user, color: :transparent, name: :anonymous, pass: :none, value: :anonymous})
    color = {value: {red: 0, green: 0, blue: 0, alpha: 1}, angle: 180, diffusion: :linear}
    history = {}
    authorisation = {creator: :atome, read: :all, write: :all} # only set only creator can change it unless specific authorisation set by creator()
    shadow = {x: 0, y: 0, blur: 7, thickness: 0, color: [alpha: 0.3], invert: false}
    border = {thickness: 1, pattern: :solid, color: :red}
    blur = {default: 5}
    {value: {shape: shape, box: box, circle: circle, text: text, image: image, video: video, audio: audio, particle: particle, collector: collector, tool: tool, web: web, user: user, color: color, history: history, authorisation: authorisation, shadow: shadow, border: border, blur: blur}}
  end
end