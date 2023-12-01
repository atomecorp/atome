# frozen_string_literal: true

t = text({ data: 'touch me to select all', id: :the_text })
b = box({ left: 12, id: :the_box })
circle({ left: 230, id: :the_circle })
image({ path: 'medias/images/red_planet.png', id: :the__red_planet, top: 233 })

t.touch(true) do
  puts "1 current_user - #{grab(Universe.current_user).selection}"
  puts "1 - b selected : #{b.selected}"
  grab(:view).attached.each do |atome_found|
    grab(atome_found).selected(true)
  end
  puts "2 - current_user : #{grab(Universe.current_user).selection}"
  puts "2 - b selected : #{b.selected}"
  b.selected(false)
  puts "3 current_user- #{grab(Universe.current_user).selection}"
  puts "3 - b selected : #{b.selected}"
end


