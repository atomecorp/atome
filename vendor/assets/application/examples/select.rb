# frozen_string_literal: true

new(particle: :select) do |params|
  if params == true
    grab(Universe.current_user).selection << @id
  elsif params == false
    grab(Universe.current_user).selection.delete(@id)
  else
    puts "write select code here..."
  end
  params
end
t = text({ data: 'touch me to select all', id: :the_text })
b = box({ left: 12, id: :the_box })
circle({ left: 230, id: :the_circle })
image({ path: 'medias/images/red_planet.png', id: :the__red_planet, top: 233 })

t.touch(true) do
  puts "1 current_user - #{grab(Universe.current_user).selection}"
  puts "1 - b select : #{b.select}"
  grab(:view).attached.each do |atome_found|
    grab(atome_found).select(true)
  end
  puts "2 - current_user : #{grab(Universe.current_user).selection}"
  puts "2 - b select : #{b.select}"
  b.select(false)
  puts "3 current_user- #{grab(Universe.current_user).selection}"
  puts "3 - b select : #{b.select}"
end


