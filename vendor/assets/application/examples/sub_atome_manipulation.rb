# frozen_string_literal: true


b=box({id: :the_box})
b.text({id: :the_text, left: 90, top: 30, data: :ok})
b.text({id: :the_text2, left: 190, top: 30, data: :hello})

wait 1 do
  b.text.each_with_index do |el, _index|
    grab(el).left(30)
  end
  # b.text.left(30)
  wait 1 do
    b.text.color(:white)
    b.text.each_with_index do |el, index|
      grab(el).left(30+30*index)
    end
    b.color(:black)
  end
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "text"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  }
}
end
