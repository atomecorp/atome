# frozen_string_literal: true

# Text in object
a=Atome.new(code: { type: :code, renderers: [:headless], parents: [], children: [] }) do  |params_found|
  puts "the param is #{params_found}"
end
a.run(:super)
c=element do |params_found|
  puts "you want me to print:  #{params_found}"
  text({ data: :hello })
end

c.run('it works')

######  SOLVED ##### : object in object

# a = box({ width: 333, height: 333, id: :the_boxy })
# a.color(:red)
# b = a.box({ width: 33, height: 33, id: :the_box, drag: true })
# b.color(:black)
#
# # color doesn't work
# circle({ id: :circle_123, color: :cyan, left: 233 })


######  SOLVED ##### : big performance problem plus params as left is not interpreted

# i = 0
# while i < 16
#   b = box({ width: 33, height: 33 })
#   b.color(:red)
#   b.left((33 + 10) * i)
#   i += 1
#   # b.drag(true)
# end


######  SOLVED ##### : .color (return the color itself instead of the box ) and .red return itself too so it's impossible to set green and blue
# another problem : when setting .red it reset the whole color object and remove green an blue components
# box({id: :mybox})
# grab(:my_box).smooth(6).color(:black).red(0.6).green(0.6).blue(0.6)


# color can't be changed easily

b=box
b.color.red(1)

# ######  SOLVED ##### : box in box doesn't work( incorrect node tree error)
# b=box({id: :mybox, width: 666, height: 555})
#
# b.box()

# ######  SOLVED ##### atome i, atome using preset doesn't work
#
# b=box
# c=b.box
# c.left(200)


# Children doesn't work
box({ id: :the_box })
circle({ top: 300, id: :circle098 })

t = text({ data: :hello })
t.children[:the_box, :circle098]


# if id change then we can't add color
b=box
b.id(:new_id)
b.color(:blue)
