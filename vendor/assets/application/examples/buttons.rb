# frozen_string_literal: true

box({ id: :the_box, drag: false })

menu1_code = lambda do
  puts :menu1_code
end
menu2_code = lambda do
  puts :menu2
end
b=buttons({
            id: :menu1,
            attach: :the_box,
            item_1: {
              text: :acceuil,
              code: menu1_code
            },
            item_2: {
              text: :page_2,
              code: menu2_code

            },
            item_3: {
              text: :page_3,
            },
            inactive: { text: { color: :gray }, width: 66, height: 12, spacing: 133, disposition: :horizontal,
                        color: :orange, margin: { left: 33, top: 12 } },
            active: { text: { color: :white, shadow: {} }, color: :blue, shadow: {} },
          })




wait 2 do
  b.update({ item_4: {
    text: :page_4_added,
  } })
end
