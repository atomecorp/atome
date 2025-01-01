# frozen_string_literal: true

# here is how to clear the content of an atome
b=box
c=circle
b.left(0)
c.left(222)
wait 2 do
  # Important : please note that the view is also an atome, this this a system atome that can't be deleted,
  # There are a few system atomes created at init time
  # Here are the list of the system atomes created at system startup:
  #  we can clear it's content using .clear(true) its the same action as if I have done : b.delete(true) and c.delete(true)
  grab(:view).clear(true)
end


# here are the list of system atomes created at system startup :


#Atome.new(
#   { renderers: [], id: :eDen, type: :element, tag: { system: true }, attach: [], fasten: [] }
# )
# Atome.new(
#   { renderers: [], id: :user_view, type: :element, tag: { system: true },
# 	attach: [:eDen], fasten: [] }
# )
#
# # color creation
# Atome.new(
#   { renderers: default_render, id: :view_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.15, green: 0.15, blue: 0.15, alpha: 1, top: 12, left: 12, diffusion: :linear, attach: [], fasten: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :shape_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.4, green: 0.4, blue: 0.4, alpha: 1, attach: [], fasten: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :box_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.5, green: 0.5, blue: 0.5, alpha: 1, attach: [], fasten: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :invisible_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0, green: 0, blue: 0, alpha: 1, attach: [], fasten: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :text_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.9, green: 0.9, blue: 0.9, alpha: 1, attach: [], fasten: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :circle_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.6, green: 0.6, blue: 0.6, alpha: 1, attach: [], fasten: [] }
# )
#
# # system object creation
# # the black_matter is used to store un materialized atomes
# Atome.new(
#   { renderers: default_render, id: :black_matter, type: :shape, attach: [:user_view],apply: [],
# 	left: 0, right: 0, top: 0, bottom: 0, width: 0, height: 0, overflow: :hidden, tag: { system: true }, fasten: []
#   })
#
# # view port
# Atome.new(
#   { renderers: default_render, id: :view, type: :shape, attach: [:user_view], apply: [:view_color],
# 	tag: { system: true },
# 	fasten: [], left: 0, right: 0, top: 0, bottom: 0, width: :auto, height: :auto, overflow: :auto,
#   }
#
# )
#
# # unreal port, hold system object and tools
# Atome.new(
#   { renderers: default_render, id: :intuition, type: :shape, attach: [:user_view], tag: { system: true },
# 	left: 0, top: 0, width: 0, height: 0, overflow: :visible, fasten: [],apply: []
#   }
# )
#
# machine_id = :dummy_machine
# # attention we must used two separate pass to avoid the password to be encode twice
# machine_password = { read: {atome: :star_wars},write: {atome: :star_wars} }
# user_password = { read: {atome: :star_wars},write: {atome: :star_wars} }
#
# machine({ id: machine_id, password: machine_password, name: :macAir, data: { date: '10090717' }, tag: { system: true } })
#
# human({ id: :anonymous, login: true, password: user_password, data: { birthday: '10/05/1996' }, tag: { system: true } })
#
# # default_user.set_current_user(:anonymous)
# Universe.current_machine = machine_id
# # the constant A is used to access alla atomes methods
# A = Atome.new(
#   { renderers: default_render, id: :atome, type: :element, tag: { system: true }, attach: [], fasten: [] }
# )
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "15",
    "4",
    "5",
    "6",
    "9",
    "current_machine",
    "delete",
    "left",
    "new",
    "set_current_user"
  ],
  "15": {
    "aim": "The `15` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `15`."
  },
  "4": {
    "aim": "The `4` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `4`."
  },
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
  "6": {
    "aim": "The `6` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `6`."
  },
  "9": {
    "aim": "The `9` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9`."
  },
  "current_machine": {
    "aim": "The `current_machine` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `current_machine`."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "new": {
    "aim": "The `new` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `new`."
  },
  "set_current_user": {
    "aim": "The `set_current_user` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `set_current_user`."
  }
}
end
