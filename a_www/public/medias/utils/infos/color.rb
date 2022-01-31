descriptions <<~STRDELIM
  change object color
  it accept either a RGB value or a string
STRDELIM
params = [:red, :green, :blue, :alpha, :x, :y, :diffusion]
tips = "just send two color to create a gradient"
examples = { basic: "b=box\nb.color(:red)", transparency: "b=box\nb.color({alpha: 0.2})" }
todos = ["add :z property"]
tests = ["write tests here"]
bugs = ["bug found here"]
visuals = ["medias/images/atome_quark/color.png"]
tutorials = ["draw a box , make it red", { video: "medias/videos/tutorials/color.mp4" }]
links = ["https://www.pinterest.fr/pin/452189618834509903/"]
documentations = [""]

{
  descriptions: descriptions,
  params: params,
  tips: tips,
  examples: examples,
  todos: todos,
  tests: tests,
  bugs: bugs,
  visuals: visuals,
  tutorials: tutorials,
  links: links,
  documentations: documentations }


