# atome as property :

p=particle({ color: :red, smooth: 30, content: "anything can be passed" })
t =text({x: 99, content: p})
t.color(p)
b=box
b.smooth(p)
b.color(p)

wait 2 do
  t.content(p.color)
end

# the code below is in atome propery generator:
# # below the condition if the value is an atome it  get the corresponding property in the atome passed
# if value.class==Atome
#   value= value.content
# end

# todo : some property not automayically generated  may not work we have to patch them
