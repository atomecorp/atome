# frozen_string_literal: true

styles = {
  width: 199,
  height: 33,
  margin: 6,
  shadow: { blur: 9, left: 3, top: 3, id: :cell_shadow, red: 0, green: 0, blue: 0, alpha: 0.6 },
  left: 0,
  color: :yellowgreen
}

element = { width: 33,
            height: 33,
            component: { size: 11 },
            left: :center,
            top: :center,
            color: :black,
            type: :text }

listing = [
  { data: :'hello' },
  { data: :'salut', color: :red },
  { data: :hi },
  { data: :ho }
]
b = box({ drag: true })
list_1 = grab(:intuition).list({
                                 styles: styles,
                                 element: element,
                                 listing: listing,
                                 left: 33,
                                 attach: b.id,
                                 action: {touch: :down, method: :my_method }
                               })

# test2

styles = {
  width: 199,
  height: 33,
  margin: 6,
  shadow: { blur: 9, left: 3, top: 3, id: :cell_shadow, red: 0, green: 0, blue: 0, alpha: 0.6 },
  left: 0,
  color: :yellowgreen
}

element = { width: 25,
            height: 25,
            smooth: '100%',
            center: { x: 0, y: 0, dynamic: true },
            # left: 10,
            # top: :center,
            color: :orange,
            type: :shape
}

listing = [
  { smooth: '100%' },
  { color: :red, data: :poilu },
  {},
  {},

  { width: 33 },
  {},
]
def my_method(val=nil)
  alert "so_cool : #{val}"
end

list_2 = A.list({ left: 300,
                  styles: styles,
                  element: element,
                  listing: listing,
                  action: {touch: :down, method: :my_method }
                })
wait 1 do
  list_2.left(list_1.width)
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "6",
    "id",
    "left",
    "list",
    "width"
  ],
  "6": {
    "aim": "The `6` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `6`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "list": {
    "aim": "The `list` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `list`."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
