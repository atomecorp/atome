# your code here ...
tool=box({width: 30, height: 30, smooth: 6, xx: 6, y: 6, color: {red: 0.3, green:0.3, blue:0.3}, shadow:{x: 0, y:0, blur: 6, thickness: 1, color: {red: 0, green:0, blue:0, alpha: 0.6}, invert: false}})
tool.image({content: :code, width: 18, height: 18, x: 6, y:6}, opacity: 0.3)

tool.touch do
  ide=code({atome_id: "ide_atome_id", content: :box})
  ide.size(120) do
  end
  ide.x(300)
end