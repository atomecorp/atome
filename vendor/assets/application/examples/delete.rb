# frozen_string_literal: true

b = box({left: 99, top: 99})
b.text({ data: 'click me' })


b.touch(true) do

  c = grab(:view).circle({id: :circling, left: 222, color: :orange, blur: 1.9 })
  orange=c.box({id: :boxing,color: {id: :orange_col, red: 1, blue: 0.2 }, width: 33, height: 33, left: 123})
  orange.shadow({
             id: :s1,
             # affect: [:the_circle],
             left: 9, top: 3, blur: 9,
             invert: false,
             red: 0, green: 0, blue: 0, alpha: 1
           })
  c.box({id: :boxy,color: {id: :red_col, red: 1 }, width: 33, height: 33, left: 333})
  c.text('tap here')
  wait 0.5 do
    c.delete(:left)
    wait 0.5 do
      # orange.color(:pink)
       c.delete(:blur)
    end
  end

  c.touch(:down) do
    grab(:circling).delete({ recursive: true }) if grab(:circling)
  end
  # alert orange.apply
  # wait 4 do
  #   grab(:circling).delete({ recursive: true })if grab(:circling)
  # end
end




############
# b = box({left: 333, id: :the_box_1})
# b.color({id: :the_orange_col, red: 1, blue: 0.5})
# b.circle({top: 66, id: :the_circle_1, color: :yellow})
#
# b.shape({id: :the_shape})
# b.shape({id: :toto}) #######
# b.circle({id: :invisible}) ######
#
# wait 1 do
#   b.delete(:left)
# end
# #
# wait 3 do
#
#   b.shape.each do |fasten_atome_id|
#     fasten_atome_id.left(333)
#     wait 2 do
#       fasten_atome_id.delete(true)
#     end
#   end
#
# end
# #
# #
# wait 4 do
#   b.delete(:color)
# end

# ################## end tests ##################
#
# # recursive example
# bb=box({id: :the_parent_box})
# bb.text({id: :text_0, data: 'test'})
# bb.text({id: :text_1, data: 'poil'})
# bb.color({id: :the_colo, red: 1})
# col=color({ id: :col_1, red: 1, green: 0.5 })
#
# # alert "before creation : #{bb}"
# bb.touch(true) do
#   bb.box({fasten: col.id, id: :fasten_box})
#   c=bb.circle(({ id: :circle_1 }))
#   c.text({id: :text_1, data: :hello})
#   bb.text(:good)
#   # alert "after creation : #{bb}"
#   wait 1 do
#   bb.physical.each do |fasten_atome_id|
#         bb.delete({id: fasten_atome_id, recursive: true})
#     end
#
#     # wait 1 do
#     #   alert "1 sec after deletion : #{bb}"
#     # end
#   end
# end

# ########################
# puts  Universe.atomes
# puts  Universe.user_atomes
# puts  Universe.system_atomes

# physical_found=["text_0","fasten_box","circle_1","fasten_box","circle_1"]
# clean_physical=physical_found.uniq
# alert clean_physical

# b=box(drag: true)
# c=circle
# # c.attach(b.id)
# b.attach(c.id)
# alert b
# alert c


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "2",
    "5",
    "9",
    "apply",
    "atomes",
    "attach",
    "box",
    "circle",
    "color",
    "delete",
    "id",
    "left",
    "physical",
    "shadow",
    "shape",
    "system_atomes",
    "text",
    "touch",
    "uniq",
    "user_atomes"
  ],
  "2": {
    "aim": "The `2` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `2`."
  },
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
  "9": {
    "aim": "The `9` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9`."
  },
  "apply": {
    "aim": "The `apply` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `apply`."
  },
  "atomes": {
    "aim": "The `atomes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `atomes`."
  },
  "attach": {
    "aim": "The `attach` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `attach`."
  },
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "physical": {
    "aim": "The `physical` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `physical`."
  },
  "shadow": {
    "aim": "The `shadow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shadow`."
  },
  "shape": {
    "aim": "The `shape` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shape`."
  },
  "system_atomes": {
    "aim": "The `system_atomes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `system_atomes`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "uniq": {
    "aim": "The `uniq` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `uniq`."
  },
  "user_atomes": {
    "aim": "The `user_atomes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `user_atomes`."
  }
}
end
