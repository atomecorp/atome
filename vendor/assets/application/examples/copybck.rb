# frozen_string_literal: true

new({ particle: :copy }) do |items_id|
  # alert items_id
  unless items_id.instance_of? Array
    items_id = [items_id]
  end
  grab(:copy).collect << items_id
  # new_copy_group=group({ collect: items_id })
  # @copy << items_id
  # @copy
  # items_id
  grab(:copy).collect
end
Atome.new({ renderers: [:html], id: :copy, collect: [], type: :group, tag: { system: true } })

new({ read: :copy })

new({ particle: :paste }) do |params|
  all_copies = grab(:copy).collect
  if params == true
    copies_found = all_copies.last
  elsif params.instance_of? Integer
    copies_found = all_copies[params.to_i]
  elsif params.instance_of? Array
    copies_found = [all_copies[params[0]][params[1]]]
  end

  copies_found.each do |copy_found|
    if grab(copy_found)
      pasted_atome = grab(copy_found).duplicate({ left: 333 })
      pasted_atome.attach(@id)
    end
  end
  copies_found
end

b = box
c = circle
t = text(:hello)

# b.copy([c.id, b.id])
# b.copy(b.id)

# test below
# b.copy(b.id)
# b.copy(c.id)

# works below
b.copy([c.id, b.id, t.id])
b.copy(b.id)


# crash below
# b.copy([b.id, t.id])
# b.copy(c.id)

# ##########

# wait 1 do
  b.paste([0,0])
# end

b.touch(true) do
  t.paste([0,1])
end



def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "attach",
    "copy",
    "each",
    "id",
    "instance_of",
    "last",
    "new",
    "paste",
    "to_i",
    "touch"
  ],
  "attach": {
    "aim": "The `attach` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `attach`."
  },
  "copy": {
    "aim": "The `copy` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `copy`."
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
  "last": {
    "aim": "The `last` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `last`."
  },
  "new": {
    "aim": "The `new` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `new`."
  },
  "paste": {
    "aim": "The `paste` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `paste`."
  },
  "to_i": {
    "aim": "The `to_i` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_i`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
