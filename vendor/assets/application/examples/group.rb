# frozen_string_literal: true

text({ id: :the_text,data: 'Touch me to group and colorize', center: true, top: 120, width: 77, component: { size: 11 } })
box({ left: 12, id: :the_first_box })
the_circle = circle({ id: :cc, color: :yellowgreen, top: 222 })
the_circle.image({path:  'medias/images/red_planet.png', id: :the__red_planet })
the_circle.color('red')
the_circle.box({ left: 333, id: :the_c })

element({ id: :the_element })

the_view = grab(:view)

color({ id: :the_orange, red: 1, green: 0.4 })
color({ id: :the_lemon, red: 1, green: 1 })
the_group = group({ collect: the_view.shape })

wait 0.5 do
  the_group.left(633)
  wait 0.5 do
    the_group.rotate(23)
    wait 0.5 do
      the_group.apply([:the_orange])
      the_group.blur(6)
    end
  end
end
puts the_group.collect
grab(:the_first_box).smooth(9)
grab(:the_text).touch(true) do
bibi=box({left: 555})
the_group2= group({ collect: [:the_c,:the_first_box, :the_text, :cc , bibi.id] })
the_group2.top(55)
# puts we remove the circle(:cc) so it' wont be affected by the color :the_lemon
the_group2.collect.delete( :cc )
the_group2.apply([:the_lemon])

end



# # # FIXME : on touch code above crash but works with wait



def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "4",
    "5",
    "apply",
    "blur",
    "box",
    "collect",
    "color",
    "id",
    "image",
    "left",
    "png",
    "rotate",
    "shape",
    "top"
  ],
  "4": {
    "aim": "The `4` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `4`."
  },
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
  "apply": {
    "aim": "The `apply` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `apply`."
  },
  "blur": {
    "aim": "The `blur` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `blur`."
  },
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "collect": {
    "aim": "The `collect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `collect`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "image": {
    "aim": "The `image` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `image`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "png": {
    "aim": "The `png` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `png`."
  },
  "rotate": {
    "aim": "The `rotate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `rotate`."
  },
  "shape": {
    "aim": "The `shape` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shape`."
  },
  "top": {
    "aim": "Defines the vertical position of the object in its container.",
    "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
  }
}
end
