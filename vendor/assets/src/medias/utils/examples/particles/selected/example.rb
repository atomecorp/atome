# frozen_string_literal: true

t = text({ data: 'touch me to select all', id: :the_text })
b = box({ left: 12, id: :the_box })
c = circle({ left: 230, id: :the_circle, color: { blue: 1, id: :c1 } })
c.color({ green: 1, id: :c2 })
# to change default selection style
Universe.default_selection_style = { border: { thickness: 3, red: 1, green: 0, blue: 1, alpha: 1, pattern: :dotted } }

c.touch(true) do
  if c.selected
    c.selected(false)
  else
    # c.selected(true)
    # example of custom selection style
    c.selected({ shadow: { id: :titi,
                           left: 9, top: 3, blur: 9,
                           invert: false,
                           red: 0, green: 0, blue: 0, alpha: 1
    }, border: { id: :toto, thickness: 5, red: 1, green: 1, blue: 1, alpha: 1,
                 pattern: :dotted, inside: true }
               })
  end
end

image({ path: 'medias/images/red_planet.png', id: :the__red_planet, top: 233 })

t.touch(true) do
  puts "1 current_user - #{grab(Universe.current_user).selection}"
  puts "1 - b selected : #{b.selected}"
  grab(:view).fasten.each do |atome_found|
    grab(atome_found).selected(true)
  end
  puts "2 - current_user : #{grab(Universe.current_user).selection}"
  puts "2 - b selected : #{b.selected}"
  selected_items = grab(Universe.current_user).selection # we create a group

  selected_items.each do |atome_id_selected|
    atome_selected = grab(atome_id_selected)
    atome_selected.width = rand(333)
    atome_selected.height = rand(333)

  end
  b.selected(false)
  puts "3 current_user- #{grab(Universe.current_user).selection}"
  puts "3 - b selected : #{b.selected}"

  grab(Universe.current_user).selection.color(:red)
  grab(Universe.current_user).selection.each do |el|
    puts el
  end
  puts grab(Universe.current_user).selection.collect
end

# image({ path: "./medias/images/logos/vie.svg", left: :auto, right: 3, top: 0 , size: 30})

