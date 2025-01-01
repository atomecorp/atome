# frozen_string_literal: true

box({color: :gray, width: 666, height: 666})
box({ id: :the_box, drag: true, color: { alpha: 2 } })


but =buttons({
          id: "my_menu",
          depth: 9999,
          attach: :the_box,
          inactive: { text: { color: :gray }, width: 66, height: 12, spacing: 3, disposition: :horizontal,
                      color: :orange, margin: { left: 33, top: 12 } },
          active: { text: { color: :white, shadow: {} }, color: :blue, shadow: {} },
        })

c = text({ top: 99, left: 99, data: 'add buttons' })

c.touch(:down) do
  but.add_button(new_button: {
    text: :button1,
    code: lambda { puts :button1_touched }
  })
    but.add_button(new_button2: {
      text: :button2,
      code: lambda { puts :button1_touched }
    })
  but.add_button(new_button3: {
    text: :button3,
    code: lambda { puts :button1_touched }
  })

  wait 0.2 do
    grab(:my_menu).remove_menu_item(:new_button2)
  end

  end






# TODO: remove menu_item ,reset_menu, reorder, delete