# frozen_string_literal: true

# Here is the fasten explanation and example :

# the fasten method in atome is both a getter and a setter
# attach and fasten particles serve the same purpose but just in the opposite direction
# please note that atome.attach([:atome_id]) means that atome will be the parent of the atome with the id :atome_id
# to sum up :  attach and fasten are both setter and getter :
# attach will attach the current object to the IDs passed in the params. The current atome will be the child of the the atomes width IDS passed in the the params,
# while fasten is the opposite to fasten it will attach IDs passed in the params to the current atome. The current atome will be the parent of of the the atomes width IDS passed in the the params

# Here is how to use it as a setter :
grab(:black_matter).color({ red: 1, green: 0.6, blue: 0.6, id: :active_color })
grab(:black_matter).color({ red: 0.3, green: 1, blue: 0.3, id: :inactive_color })

b = box({ left: 99, drag: true, id: :the_box })
wait 1 do
  b.apply([:active_color])
end
c = circle({ left: 333, id: :the_circle, drag: true })
wait 1 do

  puts "before: -------"
  puts "c.attach #{c.attach}"
  puts "b.fasten : #{b.fasten}"
  puts "b.color : #{b.color}"
  puts "c.color : #{c.color}"
  c.apply(:inactive_color)
  b.fasten([c.id])
  puts "After: -------"

  # Here is how to use it as a getter :
  # to retrieve witch atomes b315 is fasten to  to the atome c_12 just type
  puts "c.attach #{c.attach}" # => [:the_box]
  # to retrieve atome fasten to the atome c_12 just type tha other method
  puts "b.fasten : #{b.fasten}" #=> [:the_circle]
  puts "b.color : #{b.color}"
  puts "c.color : #{c.color}"
end





def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "3",
    "6",
    "apply",
    "attach",
    "color",
    "fasten",
    "id"
  ],
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "6": {
    "aim": "The `6` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `6`."
  },
  "apply": {
    "aim": "The `apply` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `apply`."
  },
  "attach": {
    "aim": "The `attach` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `attach`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "fasten": {
    "aim": "The `fasten` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fasten`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  }
}
end
