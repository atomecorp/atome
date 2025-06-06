# frozen_string_literal: true

# new({ particle: :duplicate, store: false }) do |params|
#   if @duplicate
#     copy_number = @duplicate.length
#   else
#     copy_number = 0
#   end
#
#   new_atome_id = "#{@id}_copy_#{copy_number}"
#   new_atome = Atome.new({ type: @type, renderers: @renderers, id: new_atome_id })
#
#   fasten_atomes = []
#   fasten_found = fasten.dup
#   particles_found = instance_variables.dup
#
#   particles_found.delete(:@history)
#   particles_found.delete(:@callback)
#   particles_found.delete(:@duplicate)
#   particles_found.delete(:@touch_code)
#   # touch_code=instance_variable_get('@touch_code')
#   particles_found.delete(:@html)
#   particles_found.delete(:@fasten)
#   particles_found.delete(:@id)
#   params[:id] = new_atome_id
#   fasten_found.each do |child_id_found|
#     child_found = grab(child_id_found)
#     if child_found
#       new_child = child_found.duplicate({})
#       fasten_atomes << new_child.id
#     end
#   end
#   particles_found.each do |particle_found|
#     particle_name = particle_found.to_s.sub('@', '')
#     particle_content = self.send(particle_name)
#     new_atome.set(particle_name => particle_content)
#     # new_atome.instance_variable_set('@touch_code',touch_code)
#   end
#   params[:fasten] = fasten_atomes
#
#   if params.instance_of? Hash
#     params.each do |k, v|
#       new_atome.send(k, v)
#     end
#   end
#
#   @duplicate ||= {}
#   @duplicate[new_atome_id] = new_atome
#   new_atome
# end
#
# new({ after: :duplicate }) do |params|
#   @duplicate[@duplicate.keys[@duplicate.keys.length - 1]]
# end
# c=circle
# c.color({red: 1, id: :titi})
# # b=box({apply: [:titi], left: 123})


b = circle({ id: :the_circle })
b.text(:hello)
bb = b.duplicate({  width: 33, left: 234, top: 222 })
bb.color(:red)
wait 1 do
bb2 = b.duplicate({ width: 33, left: 12, top: 99 })
bb3 = b.duplicate({ width: 33, left: 444 })
bb3.color(:green)
bb2.color(:orange)
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "color",
    "delete",
    "dup",
    "duplicate",
    "each",
    "id",
    "instance_of",
    "instance_variable_set",
    "keys",
    "length",
    "new",
    "send",
    "set",
    "text",
    "to_s"
  ],
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "dup": {
    "aim": "The `dup` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `dup`."
  },
  "duplicate": {
    "aim": "The `duplicate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `duplicate`."
  },
  "each": {
    "aim": "The `each` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `each`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "instance_of": {
    "aim": "The `instance_of` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `instance_of`."
  },
  "instance_variable_set": {
    "aim": "The `instance_variable_set` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `instance_variable_set`."
  },
  "keys": {
    "aim": "The `keys` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `keys`."
  },
  "length": {
    "aim": "The `length` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `length`."
  },
  "new": {
    "aim": "The `new` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `new`."
  },
  "send": {
    "aim": "The `send` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `send`."
  },
  "set": {
    "aim": "The `set` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `set`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "to_s": {
    "aim": "The `to_s` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_s`."
  }
}
end
