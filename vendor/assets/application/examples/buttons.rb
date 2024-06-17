# frozen_string_literal: true


box({ id: :the_box, drag: true, color: { alpha: 2 } })

menu1_code = lambda do
  puts :menu1_code
end
menu2_code = lambda do
  puts :menu2
end

but = buttons({
                id: :menu1,
                attach: :the_box,
                inactive: { text: { color: :gray }, width: 66, height: 12, spacing: 3, disposition: :horizontal,
                            color: :orange, margin: { left: 33, top: 12 } },
                active: { text: { color: :white, shadow: {} }, color: :blue, shadow: {} },
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
                  code: lambda { puts :item_3_touched }
                },
              })

c = text({ top: 99, left: 99, data: 'add a button' })

c.touch(:down) do
  but.add_button(new_button: {
    text: :button1,
    code: lambda { puts :button1_touched }
  })
end


# TODO: remove menu_item ,reset_menu, reorder, delete