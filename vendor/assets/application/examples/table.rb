# frozen_string_literal: true


c = circle({ id: :my_cirle, color: :red, drag: true })
c.box({ left: 0, width: 22, height: 22, top: 65 })
c.touch(true) do
  alert :okk
end
m = table({ renderers: [:html], attach: :view, id: :my_test_box, type: :table, apply: [:shape_color],
             left: 333, top: 0, width: 900, smooth: 15, height: 900, overflow: :scroll, option: { header: true },
             component: {
               border: { thickness: 5, color: :blue, pattern: :dotted },
               overflow: :auto,
               color: "white",
               shadow: {
                 id: :s4,
                 left: 20, top: 0, blur: 9,
                 option: :natural,
                 red: 0, green: 1, blue: 0, alpha: 1
               },
               height: 50,
               width: 50,
               # component: { size: 12, color: :black }
             },
             data: [
               { titi: :toto },
               { dfgdf: 1, name: 'Alice', age: 30, no: 'oko', t: 123, r: 654, f: 123, g: 654, w: 123, x: 654, c: 123, v: 654 },
               { id: 2, name: 'Bob', age: 22 },
               { dfg: 4, name: 'Vincent', age: 33, no: grab(:my_cirle) },
             # { dfgd: 3, name: 'Roger', age: 18,  now: :nothing }
             { dfgd: 3, name: 'Roger', age: 18, nog: image({path: 'medias/images/red_planet.png', id: :red_planet }), now: :nothing }
             ]
           })

# tests
m.color(:orange)
m.border({ thickness: 5, color: :blue, pattern: :dotted })

puts m.get({ cell: [1, 2] })
wait 2 do
  m.insert({ cell: [2, 2], content: 999 })
  m.insert({ row: 1 })
  wait 1 do
    m.remove({ row: 2 })
  end
  wait 2 do
    m.remove({ column: 1 })
  end
  wait 3 do
    m.insert({ column: 3 })
  end

  wait 4 do
    m.sort({ column: 1, method: :alphabetic })
    puts 1
    wait 1 do
      puts 2
      m.sort({ column: 2, method: :numeric })
      wait 1 do
        puts 3
        m.sort({ column: 3, method: :numeric })
        wait 1 do
          puts 4
          m.sort({ column: 1, method: :numeric })
        end
      end
    end
  end

end

#  cell.fusion() # to be implemented later





def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "border",
    "box",
    "color",
    "fusion",
    "get",
    "insert",
    "remove",
    "sort",
    "touch"
  ],
  "border": {
    "aim": "The `border` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `border`."
  },
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "fusion": {
    "aim": "The `fusion` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fusion`."
  },
  "get": {
    "aim": "The `get` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `get`."
  },
  "insert": {
    "aim": "The `insert` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `insert`."
  },
  "remove": {
    "aim": "The `remove` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `remove`."
  },
  "sort": {
    "aim": "The `sort` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `sort`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
