# frozen_string_literal: true
# holder is a particle that contain an atome so we use my_objet.holder.left(33)
# and it will move the atome contain in the holder particle to be manipulated
# it facilitate the access of some atome without being worried about their id
# this is mainly used int context of input , slider , etc...


# simple example
b=box({color: :black})

c=b.circle({width: 10, height: 10, color: :red})

b.holder(c)
wait 1 do
  b.holder.center(true)
end






# second example ( holder is build in the input molecule)
text({ left: 33, top: 33, data: 'data collected', id: :infos })

inp = A.input({ width: 166,
                trigger: :up,
                back: :orange,
                shadow: {
                  id: :s2,
                  left: 3, top: 3, blur: 3,
                  invert: true,
                  red: 0, green: 0, blue: 0, alpha: 0.9
                },
                text: :black,
                smooth: 3,
                left: 66,
                top: 33,
                default: 'type here'
              }) do |val|

  grab(:infos).data(val)
end

wait 2 do
  inp.top(12)
  wait 1 do
    inp.width(666)
    inp.holder.blur(6)
    wait 1 do
      inp.holder.blur(0)
      inp.holder.data('injected data')
    end
  end

end







def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "9",
    "circle",
    "holder",
    "input",
    "top",
    "width"
  ],
  "9": {
    "aim": "The `9` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
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
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
