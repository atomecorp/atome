# frozen_string_literal: true

# frozen_string_literal: true

# puts 'type you problematic code here!'
col=color({green: 1, id: :the_col})

b=box({top: 3})
t=text(data: :red, left: 0, top: 123)
t1=text(data: :green, left: 100, top: 123)
t2=text(data: :blue, left: 200, top: 123)
t3=text(data: :yellow, left: 300, top: 123)
t4=text(data: :orange, left: 400, top: 123)
t5=text(data: :cyan, left: 500, top: 123)

item_to_batch=[t.id,t1.id,t2.id, t3.id, t4.id, t5.id]
the_group= group({ collect: item_to_batch })
the_group.apply([:the_col])
t.touch(true) do
  b.color({id: :red, red: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t1.touch(true) do
  b.color({id: :green, green: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t2.touch(true) do
  b.color({id: :blue, blue: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t3.touch(true) do
  b.color({id: :yellow,  red: 1, green: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t4.touch(true) do
  b.color({id: :orange,  red: 1, green: 0.5 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t5.touch(true) do
  b.color({id: :cyan,  blue: 1, green: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end

t=text({data: "dynamic color propagation, touch me to propagate"})
t.apply(:the_col)
c=circle({id: :the_circle, top: 260})
c.apply([:the_col])
b.apply([:the_col])

t.touch(true) do
  col.red(1)
end



def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "5",
    "apply",
    "atomes",
    "color",
    "id",
    "red",
    "touch"
  ],
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
  "apply": {
    "aim": "The `apply` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `apply`."
  },
  "atomes": {
    "aim": "The `atomes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `atomes`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "red": {
    "aim": "The `red` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `red`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
