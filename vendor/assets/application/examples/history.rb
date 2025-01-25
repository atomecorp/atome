#  frozen_string_literal: true

# allow storage below
Universe.allow_localstorage = true

b = box({ id: :the_box })
b.data(:canyouwritethis)
b.rotate(33)
b.rotate(88)
b.rotate(99)
b.rotate(12)
b.rotate(6)
b.data
b.touch(true) do
  Universe.allow_localstorage = false
  b.left(99)
  puts  b.history # giv you the whole history not onlu hostory of
  # b.data(:super)
  # b.data
  # box_data_write_history=b.history({ operation: :write, id: :the_box, particle: :data })
  # puts "get data write operation :  #{box_data_write_history}"
  # box_data_read_history=b.history({ operation: :read, id: :the_box, particle: :data })
  # puts "get data read operation :  #{box_data_read_history}"
end



# box_rotate_history=b.history({ operation: :write, id: :the_box, particle: :rotate })
# puts "get all all rotate write operation :  #{box_rotate_history}"
#
# # we check if an operation synced (that means saved on atome's server)
# puts "first rotate operation state  :  #{box_rotate_history[0]}"
#
# box_data_history=b.history({ operation: :write, id: :the_box, particle: :data })
# puts "get data write operation :  #{box_data_history}"
#


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "data",
    "history",
    "rotate",
    "touch"
  ],
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "history": {
    "aim": "The `history` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `history`."
  },
  "rotate": {
    "aim": "The `rotate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `rotate`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
