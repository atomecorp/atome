# frozen_string_literal: true

a = application({
                  id: :arp,
                  margin: 3,
                  spacing: 6
                })

page1_code = lambda do |back|
  alert :kooly
end

verif = lambda do
  b = box({ id: :ty, left: 90, top: 90 })
  b.touch(true) do
    alert grab(:mod_1).touch
  end
end

page1 = {
  id: :page1,
  color: :cyan,
  name: :accueil,
  footer: { color: :green, height: 22 },
  header: { color: :yellow },
  left_side_bar: { color: :yellowgreen },
  right_side_bar: { color: :blue },
}

color({ id: :titi, red: 1 })
page2 = { id: :page2,
          color: :white,
          menu: false,
          run: verif,
          box: { id: :mod_1, left: 333, top: 123, touch: { down: true, code: page1_code } }
}

page0 = { id: :page0,
          color: :purple,
}

a.page(page0)
a.page(page1)
a.page(page2)
a.page({ id: :page3,
         color: :red,
       })



menu_f=a.menu
menus_found= menu_f.fasten # replace fasten for entries
puts a.pages
puts   " pages => #{a.pages}"
puts   " menus_found => #{menus_found}"

bloc_to_add= {height: 156, color: :green}
bloc_to_add2= {height: 99, color: :blue}
bloc_to_add3= {height: 333, color: :orange, subs:{contact: {width: 1, color: :black}, project: {width: 1}, calendar: {width: 0.5, color: :green}}}
 a.insert({page3: {block1: bloc_to_add , block2: bloc_to_add2, block3: bloc_to_add3}})


wait 1 do
  # how to remove blocks
   a.extract({page3: :block1})
end

a.show(:page3)
# how access blocks
# wait 3 do
#   grab(:block2).color(:black)
# end


