# visual example

t = text({content: "type_some_text,_try_to_press_return_and_touch_the_red_circle", visual: :Impact, x: 150})
t.touch({option: :down}) do
  grab(:device).edit(false)
end

# fixme we must find a solution allow shortcut and auto sized text
grab(:device).touch({option: :down}) do
  # grab(:device).edit(true)
end
t.width(333)
t.visual({wrap: " "})
t.visual({ fit: :width})
t.edit( true)
t.border({color: :orange, thickness: 7, pattern: :solid})
c=circle({size: 33, x: 69})
c.touch do
  t.visual({fit: :width})
end

# viusal params : visual: {size: 33,path: :arial,alignment: :right,wrap: " " , fit: :height  }
# visual default : { path: :ruboto, size: 33, alignment: :center, wrap: " ", fit: :none }