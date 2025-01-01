#  frozen_string_literal: true

b = box({ left: 333, color: :blue, smooth: 6, id: :the_box2 })

t = text({ id: :the_text, data: 'touch the box and wait!' })

exec_code=lambda do

  wait 2 do
    t.data('it works!! ')
  end

end
b.code(:hello) do
  circle({ left: rand(333), color: :green })
end
b.run(:hello)
b.touch(:tap) do
  {
    color: :cyan,
    target: { the_text: { data: :super! } },
    run: exec_code
  }
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "code",
    "data",
    "run",
    "touch"
  ],
  "code": {
    "aim": "The `code` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `code`."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "run": {
    "aim": "The `run` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `run`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
