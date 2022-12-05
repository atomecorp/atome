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

# object in object

a = box({ width: 333, height: 333, id: :the_boxy })
a.color(:red)
b = a.box({ width: 33, height: 33, id: :the_box, drag: true })
b.color(:black)

# color doesn't work
circle({ id: :circle_123, color: :cyan, left: 233 })


# big performance problem plus params as left is not interpreted

i = 0
while i < 16
  b = box({ width: 33, height: 33 })
  b.parents([:the_grid])
  b.color(:red)
  b.left((33 + 10) * i)
  i += 1
  # b.drag(true)
end


# .color (return the color itself instead of the box ) and .red retrun itself too so it's impossible to set green and blue
# another problem : when steeing .red it reset the whole color object and remove green an blue components
box({id: :mybox})
grab(:my_box).smooth(6).color(:black).red(0.6).green(0.6).blue(0.6)

# color can't be changed easily

b=box
b.color.red(1)