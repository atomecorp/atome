#  frozen_string_literal: true
b = box({ drag: true, id: :the_b, top: 63, left: 63 })
c = b.circle({ left: 99, id: :the_c })
b.box({left: 99, top: 99, width: 33, height: 33, id: :second_one})
t = b.text({ data: 'touch the circle', left: 44, top: 44, id: :the_t })
c.touch(:down) do
  b.unfasten([c.id])
  b.color(:green)
  t.data('circle unfasten')
  grab(:infos).data("number of item(s) fasten to the box : #{b.fasten}")
  wait 2 do
    grab(:second_one).delete((true))
    grab(:infos).data("number of item(s) fasten to the box : #{b.fasten}")
    wait 2 do
      b.color(:red)
      t.data('unfasten all attached atomes')
      b.unfasten(:all)
      grab(:infos).data("number of  item fasten to the box : #{b.fasten}")
    end
  end
end

text({id: :infos,left: 155, data: "number of  item fasten to the box : #{b.fasten}"})

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "box",
    "circle",
    "color",
    "data",
    "fasten",
    "id",
    "text",
    "touch",
    "unfasten"
  ],
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "fasten": {
    "aim": "The `fasten` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fasten`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "unfasten": {
    "aim": "The `unfasten` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `unfasten`."
  }
}
end
