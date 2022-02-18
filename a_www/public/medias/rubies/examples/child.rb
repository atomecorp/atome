# child

c = circle({atome_id: :c, x: 20})
c.drag do
end
img=image({content: :red_planet, atome_id: :red_planet})
c.box({atome_id: :e, x: 160})
c.text({content: 'some text', atome_id: :t, width: 100, height: 200, x: 69})
b2=box({x:200, atome_id: :the_box})
c.child.color(:green)

c.child([img.atome_id, b2.atome_id])
c.child do |child_found|
  child_found.set({width: 100, height: 33, rotate: 36, y: 66})
end

c.child[:red_planet].y(200)
b2.parent[1].color(:cyan)


# parent example

# # an atome can have multiple parents. (for now, please note that only the last setted parent is the real father, it ll be change i the future)
# c = circle({atome_id: :c, x: 20})
# e = box({atome_id: :e, x: 160})
# t = text({content: 'some texts', atome_id: :the_father_text, x: 96})
# t.parent([e.atome_id, c.atome_id])
#
# c.touch do
#   grab(:view).clear(true)
#   wait 1 do
#     grab(:view).box
#   end
# end
#
# # grab(:view).extract(t.atome_id)
# # t.parent do |father|
# #   father.set({ rotate: 36, y: 66})
# # end
# # t.parent.blur(2)
# # wait 1 do
# #   grab(:view).attach(:the_father_text)
# #   t.set(x: 33, y: 33, )
# #   t.width(:auto)
# # end
# #both parent are treated