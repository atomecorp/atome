# frozen_string_literal: true

b = box({ left: 155, drag: true, id: :boxy })

t=b.text({ data: :hello, id: :t1, position: :absolute, color: :black })
t2 = b.text({ data: :hello, id: :t2, left: 9, top: 33, position: :absolute })


wait 1 do
  grab(:view).retrieve do |child|
    child.left(33)
  end
  wait 1 do
    grab(:boxy).retrieve do |child|
      child.color(:green)
    end
    wait 1 do
      grab(:view).retrieve({ ascending: false, self: false }) do |child|
        child.delete(true)
      end
    end
  end
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "delete",
    "left",
    "text"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  }
}
end
