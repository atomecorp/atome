module DefaultValues
  def default_values
    # here are the default preset for common objects
    visual = { color: :lightgray, y: 0, z: 0, overflow: :visible, parent: :view }
    shape = visual.merge({ type: :shape, width: 70, height: 70, content: { points: 2 } })
    box = visual.merge(shape).merge(content: { points: 4 })
    circle = visual.merge(shape).merge({ color: :red, content: { points: 4, tension: "100%" } })
    text = visual.merge({ type: :text, color: { red: 0.69, green: 0.69, blue: 0.69 }, content: lorem })
    image = visual.merge({ type: :image, color: :transparent, content: :atome })
    video = visual.merge({ type: :video, color: :transparent, content: :lion_king })
    audio = visual.merge({ type: :audio, color: :transparent, content: :riff })
    particle = { type: :particle }
    collector = { type: :collector }
    camera = visual.merge({ type: :camera, color: :transparent })
    microphone = visual.merge({ type: :microphone, color: :transparent })
    midi = visual.merge(shape).merge(type: :midi, content: { points: 4 })
    tool = visual.merge({ type: :tool, width: 52, height: 50, parent: :intuition, content: :dummy })
    web = visual.merge({ type: :web, color: :transparent })
    user = visual.merge({ type: :user, color: :transparent, name: :anonymous, pass: :none, content: :anonymous })
    color = { red: 0, green: 0, blue: 0, alpha: 1, angle: 180, diffusion: :linear }
    history = {}
    authorisation = { creator: :atome, read: :all, write: :all } # only set only creator can change it unless specific authorisation set by creator()
    shadow = { x: 0, y: 0, blur: 7, thickness: 0, color: [alpha: 0.3], invert: false }
    border = { thickness: 1, pattern: :solid, color: :red }
    blur = { default: 5 }
    { camera: camera, microphone: microphone,midi: midi, shape: shape, box: box, circle: circle, text: text, image: image, video: video, audio: audio, particle: particle, collector: collector, tool: tool, web: web, user: user, color: color, history: history, authorisation: authorisation, shadow: shadow, border: border, blur: blur }
  end
end