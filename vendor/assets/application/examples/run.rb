#  frozen_string_literal: true

b = box({ left: 333, color: :blue, smooth: 6, id: :the_box2 })



exec_code=lambda do

  wait 1 do
    b.color(:violet)
  end

end

b.run(exec_code)



def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "run"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "run": {
    "aim": "The `run` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `run`."
  }
}
end
