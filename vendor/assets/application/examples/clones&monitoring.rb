# # frozen_string_literal: true

# TODO : clones alteration must be bidirectional, to do so :

c = circle({ id: :the_circle, left: 12, top: 0, color: :orange, drag: { move: true, inertia: true, lock: :start } })
b = box({ top: 123 })

t = text({ data: :hello, left: 300 })

t.touch(true) do
  puts "#{b.touch} , #{b.touch_code}"
  b.touch_code[:touch].call
end
col = color({ id: :col1, red: 1, blue: 1 })
# #######################
atomes_monitored = [c, b]
# particles_monitored=[:left, :width, :touch, :apply]
particles_monitored = [:left, :width, :apply]
# particles_monitored = [:touch]
Atome.monitoring(atomes_monitored, particles_monitored) do |monitor_infos|
  puts "1 ==> #{@id} : #{monitor_infos[:particle]},#{monitor_infos[:altered]}"

  atomes_monitored.each do |atome_to_update|
    # we exclude the current  changing atome to avoid infinite loop
    unless atome_to_update == self || (monitor_infos[:original] == monitor_infos[:altered]) || !monitor_infos[:altered]
      puts "2 ==> #{atome_to_update.id} : #{monitor_infos[:particle]},#{monitor_infos[:altered]}"
      atome_to_update.send(monitor_infos[:particle], monitor_infos[:altered])
    end

  end
end
# ####################
b.resize(true)
c.resize(true) do |l|

  puts c.instance_variable_get("@resize_code")
end
ccc = color(:red)
wait 1 do
  # b.left(133)
  b.touch(true) do
    puts "b width is #{b.width}"
  end

  c.left(133)
  wait 1 do
    # c.color(:red)
    # c.apply([ccc.id])
    b.width(155)
  end
end

# TODO : make multi parents works
# TODO : make it works for event like touch , also attach and attached
# wait 2 do
#   col = color({ id: :col1, red: 1, blue: 1 })
#   Atome.monitoring([col], [:red, :blue], [:variable1, :variable2])
#
#   c.apply([:col1])
#   wait 2 do
#     col.red(0)
#     col.red
#     c.apply([:col1])
#   end
# end

############## add class solution
the_b = box({ color: :green })

the_b.resize(true) do
  puts :j
end

class HTML

  def id(id)
    @element[:classList].add(id.to_s)
    attr('id', id)
    self
  end

  def add_class(val)
    @element[:classList].add(val.to_s)
    # @element.setAttribute('id', val)
  end

  # def force_top(id,value)
  #   element=JS.global[:document].getElementById(id.to_s)
  #   element[:style][:top] ='33px'
  # end
end

new({ particle: :add_class }) do |params|
  html.add_class(params)
end
#
# new({ particle: :force_top }) do |params|
#   html.force_top(params)
# end

b = box({ id: :toto })
bb = box({ id: :toto, left: 333 })
bb.add_class(:toto)
b.add_class(:toto)
# bb.force_top(:toto,3)
