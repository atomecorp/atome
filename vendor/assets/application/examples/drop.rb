#  frozen_string_literal: true



dragged = box({ left: 33,top: 333, width: 333,color: :orange, smooth: 6, id: :drop_zone })

dragged.drop(true) do |event|
  grab(event[:destination]).color(:white)
  grab(event[:source]).color(:black)
end

dragged.drop(:enter) do |event|
  grab(event[:destination]).color(:red)
end

dragged.drop(:leave) do |event|
  grab(event[:destination]).color(:gray)
end

dragged.drop(:activate) do |event|
  grab(event[:destination]).color(:yellow)
  grab(event[:source]).color(:cyan)
end


dragged.drop(:deactivate) do |event|
  grab(event[:destination]).color(:orange)
end
box({ left: 333, color: :blue,top: 222, smooth: 6, id: :the_box, drag: true })
box({ left: 333, color: :red,top: 180, smooth: 9, id: :the_box2, drag: true })

t=text({data: 'touch me to unbind drop enter'})
t.touch(true) do
  dragged.drop({ remove: :enter })
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "drop",
    "touch"
  ],
  "drop": {
    "aim": "The `drop` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `drop`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
