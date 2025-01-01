# frozen_string_literal: true

c = circle({ id: :the_circle, left: 122, color: :orange, drag: { move: true, inertia: true, lock: :start } })
c.color({ id: :col1, red: 1, blue: 1 })

 c.shadow({
              id: :s1,
              # affect: [:the_circle],
              left: 9, top: 3, blur: 9,
              invert: false,
              red: 0, green: 0, blue: 0, alpha: 1
            })

shadow({
           id: :s2,
           affect: [:the_circle],
           left: 3, top: 9, blur: 9,
           invert: true,
           red: 0, green: 0, blue: 0, alpha: 1
         })

c.shadow({
           id: :s4,
           left: 20, top: 0, blur: 9,
           option: :natural,
           red: 0, green: 1, blue: 0, alpha: 1
         })

wait 2 do
  c.remove(:s4)
  wait 2 do
    c.remove({ all: :shadow })
  end
end


the_text = text({ data: 'text with shadow!', center: true, top: 222, width: 777, component: { size: 66 }, id: :my_text })


the_text.shadow({
           id: :my_shadow,
           left: 6, top: 6, blur: 6,
           option: :natural,
           red: 0, green: 0, blue: 0, alpha: 1
         })

the_text.left(255)
the_text.top(66)
the_text.color(:red)

wait 1 do
  text_shadow= grab(:my_shadow)
  text_shadow.alpha(0.5)
  text_shadow.left(120)
  text_shadow.blur({ value: 1 })

  # grab(:my_text).refresh(true)

end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "5",
    "alpha",
    "blur",
    "color",
    "left",
    "remove",
    "shadow",
    "top"
  ],
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
  "alpha": {
    "aim": "The `alpha` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `alpha`."
  },
  "blur": {
    "aim": "The `blur` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `blur`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "remove": {
    "aim": "The `remove` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `remove`."
  },
  "shadow": {
    "aim": "The `shadow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shadow`."
  },
  "top": {
    "aim": "Defines the vertical position of the object in its container.",
    "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
  }
}
end
