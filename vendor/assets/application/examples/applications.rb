# frozen_string_literal: true

a = application({
                  id: :arp,
                  margin: 3,
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

a.show(:page2)
alert "2 ==> #{grab(:arp_menu).actor}"


