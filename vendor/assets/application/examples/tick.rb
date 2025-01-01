# frozen_string_literal: true

# tick allow you to automatise any action counting
# it can be added into any new created particle ex: here a dummy

new({ particle: :dummy }) do |_p|
  tick(:dummy )
end

new({ particle: :dummy2 }) do |_p|
  tick(:dummy2 )
end

a=box
a.dummy(:hi)

puts a.tick[:dummy]
a.dummy(:ho)
puts a.tick[:dummy]

a.dummy2(:ho)
puts a.tick[:dummy2]

c=circle({left: 99})

c.touch(true) do
  c.tick(:my_counter)
  puts  c.tick[:my_counter]
end

bb=box({left: 333})

bb.touch(true) do
  if   bb.tick(:my_counter)%2 == 0
    bb.color(:red)
  else
    bb.color(:blue)
  end
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "dummy",
    "dummy2",
    "tick",
    "touch"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "dummy": {
    "aim": "The `dummy` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `dummy`."
  },
  "dummy2": {
    "aim": "The `dummy2` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `dummy2`."
  },
  "tick": {
    "aim": "The `tick` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `tick`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
