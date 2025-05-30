# frozen_string_literal: true

# Here is the attach explanation and example
# the attach method in atome is both a getter and a setter
# attach and fasten particles serve the same purpose but just in the opposite direction
# please note that atome.attach([:atome_id]) means that atome will be the parent of the atome with the id :atome_id
# to sum up :  attach and fasten are both setter and getter :
# a.attach(b.ib) will attach the current object to the IDs passed in the params. The current atome will be the child of the the atomes width IDS passed in the the params,
# a.attach(b.ib) means (insert 'b' into 'a') or a is parent b is child

# while a.fasten(b.id) (insert 'a' into 'b')is the opposite to fasten it will attach IDs passed in the params to the current atome. The current atome will be the parent of of the the atomes width IDS passed in the the params
# a.fasten(b.ib) means (insert 'a' into 'b') or a is child b is parent

# atome.attach([:atome_id]) means that atome will be the child of the atome with the id :atome_id
# Here is how to use it as a setter :
b = box({ id: :b315, color: :red })
circle({ id: :c_12, top: 0, drag: true, color: :yellow })

c=circle({ id: :c_123, color: :cyan, left: 233, drag: true })
 box({ id: :b_1, left: 333, drag: true })
grab(:b_1).attach(:c_123)

bb = box({ top: 99, drag: true })
bb.attach(:b_1)

box({ id: :my_test_box })
wait 1 do
  b.attach(:c_12)
  # Here is how to use it as a getter :
  # to retrieve witch atomes b315 is fasten to  to the atome c_12 just type
  puts  b.attach # => [:c_12]
  # to retrieve atome fasten to the atome c_12 just type tha other method
  puts  c.fasten #=> [:b_1]
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "attach",
    "fasten",
    "ib",
    "id"
  ],
  "attach": {
    "aim": "The `attach` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `attach`."
  },
  "fasten": {
    "aim": "The `fasten` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fasten`."
  },
  "ib": {
    "aim": "The `ib` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `ib`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  }
}
end
