# frozen_string_literal: true

a = application({
                  id: :arp,
                  margin: 3,
                  spacing: 6
                })

page1_code = lambda do |back|
  alert :kooly
end

verif = lambda do
  b = box({ id: :ty, left: 90, top: 90 })
  b.touch(true) do
    alert grab(:mod_1).touch
  end
end

page1 = {
  id: :page1,
  color: :cyan,
  name: :accueil,
  footer: { color: :green, height: 22 },
  header: { color: :yellow },
  left_side_bar: { color: :yellowgreen },
  right_side_bar: { color: :blue },
}

color({ id: :titi, red: 1 })
page2 = { id: :page2,
          color: :white,
          menu: false,
          run: verif,
          box: { id: :mod_1, left: 333, top: 123, touch: { down: true, code: page1_code } }
}

page0 = { id: :page0,
          color: :purple,
}

a.page(page0)
a.page(page1)
a.page({ id: :page3,
         color: :red,
         footer: { color: :green, height: 22 }
       })



menu_f=a.menu
menus_found= menu_f.fasten # replace fasten for entries
puts a.pages
puts   "pages => #{a.pages}"
puts   "menus_found => #{menus_found}"

bloc_to_add= {height: 156, color: :green}
bloc_to_add2= {height: 99, color: :blue}
bloc_to_add3= {height: 333, color: :orange, subs:{contact: {width: 1, color: :black}, project: {width: 1}, calendar: {width: 0.5, color: :green}}}

 a.insert({page3: {block1: bloc_to_add , block2: bloc_to_add2, block3: bloc_to_add3}})


wait 1 do
  # how to remove blocks
   a.extract({page3: :block1})
end

page_3=a.show(:page3)

wait 1 do
  page_3.color(:cyan)
  page_3.box({top: 900})
end


# how access blocks
# wait 3 do
#   grab(:block2).color(:black)
# end


puts(grab(:project).inspect)


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "5",
    "box",
    "color",
    "extract",
    "fasten",
    "insert",
    "menu",
    "page",
    "pages",
    "show",
    "touch"
  ],
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "extract": {
    "aim": "The `extract` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `extract`."
  },
  "fasten": {
    "aim": "The `fasten` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fasten`."
  },
  "insert": {
    "aim": "The `insert` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `insert`."
  },
  "menu": {
    "aim": "The `menu` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `menu`."
  },
  "page": {
    "aim": "The `page` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `page`."
  },
  "pages": {
    "aim": "The `pages` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `pages`."
  },
  "show": {
    "aim": "The `show` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `show`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
