# frozen_string_literal: true
t = text({ left: 33, top: 33, data: 'data collected', id: :infos })
b=box({drag: true, id: :the_b})
# Important to trigger on 'return' add the parameter :  {trigger: :return}
inp=b.input({ width: 166,
              trigger: :up,
              back: :orange,
              shadow: {
                id: :s2,
                left: 3, top: 3, blur: 3,
                invert: true,
                red: 0, green: 0, blue: 0, alpha: 0.9
              },
              component: {size: 8},
              text: { color: :black , top: 5, left: 6},
              smooth: 3,
              left: 66,
              top: 33,
              # height: 8,
              default: 'type here'
            }) do |val|

  grab(:infos).data(val)
end

inp.top(12)

  wait 1 do
    inp.width(666)
    wait 1 do
      inp.holder.data('new data')
    end
end


c=circle({top: 99})
c.touch(true) do
  alert b.fasten
end



def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "9",
    "fasten",
    "holder",
    "input",
    "top",
    "touch",
    "width"
  ],
  "9": {
    "aim": "The `9` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9`."
  },
  "fasten": {
    "aim": "The `fasten` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fasten`."
  },
  "holder": {
    "aim": "The `holder` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `holder`."
  },
  "input": {
    "aim": "The `input` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `input`."
  },
  "top": {
    "aim": "Defines the vertical position of the object in its container.",
    "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
