# frozen_string_literal: true

text({ data: :hello1, component: { size: 66 }, left: 0 })
box
circle(left: 333, top: 3)
puts "atomes : #{Universe.atomes}"
puts "user_atomes : #{Universe.user_atomes}"
puts "particle_list : #{Universe.particle_list}"
puts "users : #{Universe.users}"
puts "current_machine : #{Universe.current_machine}"
puts "connected : #{Universe.connected}"