# # Working

# ###### timer ######
# ATOME.program(Time.now)

# ###### container ######
# b=box({ x: 333,atome_id: :the_box , width: 333, height: 60, scale: true})
# c=container({ atome_id: :the_container, drag: true })
# c.attach(b.atome_id)

# ###### text size fit ######
# b = box({ x: 333, atome_id: :the_box, color: :pink, width: 333, height: 60, scale: true })
# t = b.text({ content: :the_text, y: 0, color: :yellow, atome_id: :the_text })
# # t.size({ fit: :width, dynamic: true })
#
# b.touch do
#     `
#   //jQuery("#the_box").fitText(1.2);
#   alert("good");
#   `
#   # alert :ok
# end

# ###### atome accumulation ######

###### groups ######

# b = box({ size: 66 , y: 33, color: :red})
# b.tag("my_tag")
# circle({ x: 200, y: 33 })
# circle({x: 200, y: 96, color: :green, tag: :other_tag})
# b.add({ tag: :new_tag })
#
# a= group({content: [:poil, :poilu], name: :my_group, dynamic: true, condition: { color: :red }})
# alert a.inspect


# ###### svg shape ######
# s=shape({content: :atome, path: :atome})
# alert (s.inspect)