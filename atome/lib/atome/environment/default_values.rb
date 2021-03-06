module DefaultValues
  def default_values
    # here are the default preset for common objects

    visual = { color: :transparent, y: 0, z: 0, overflow: :visible, parent: :view }
    shape = visual.merge({ type: :shape, width: 70, height: 70, content: { points: 2 } })
    container = { width: 70, height: 70, type: :shape, parent: :view, y: 0, z: 0, color: :transparent }
    box = visual.merge(shape).merge({ color: :lightgray, preset: :box })
    star = visual.merge(shape).merge({ color: :red, preset: :star })
    circle = visual.merge(shape).merge({ color: :red, content: { points: 4, tension: "100%" }, preset: :circle })
    text = visual.merge({x: 0, width: 333, height: 33,type: :text, color: { red: 0.69, green: 0.69, blue: 0.69 }, content: lorem, edit: false, visual: {alignment: :left} })
    image = visual.merge({ type: :image, content: :atome })
    video = visual.merge({ type: :video, content: :lion_king })
    audio = visual.merge({ type: :audio, content: :riff })
    particle = { type: :particle, render: false }
    collector = { type: :collector }
    camera = visual.merge({ type: :camera })
    microphone = visual.merge({ type: :microphone })
    midi = visual.merge(shape).merge(type: :midi)
    tool = visual.merge({ type: :tool, width: 33, height: 33, color: {red: 1, green: 1, blue: 1, alpha: 0.3},smooth: 3,  parent: :intuition, content: [], overflow: :visible })
    web = visual.merge({ type: :web, width: 66, height: 66 })
    user = visual.merge({ type: :user, name: :anonymous, pass: :none, content: :anonymous })
    color = { red: 0, green: 0, blue: 0, alpha: 1, angle: 180, diffusion: :linear }
    history = {}
    authorisation = { creator: :atome, read: :all, write: :all } # only set only creator can change it unless specific authorisation set by creator()
    shadow = { x: 0, y: 0, blur: 7, thickness: 0, color: [alpha: 0.3], invert: false }
    border = { thickness: 1, pattern: :solid, color: :red }
    blur = { default: 5 }
    { camera: camera, microphone: microphone, midi: midi, container: container, shape: shape, box: box,star: star, circle: circle, text: text, image: image, video: video, audio: audio, particle: particle, collector: collector, tool: tool, web: web, user: user, color: color, history: history, authorisation: authorisation, shadow: shadow, border: border, blur: blur }
  end
end