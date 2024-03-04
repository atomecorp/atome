# frozen_string_literal: true

c = circle({ id: :the_circle, left: 122, color: :orange, drag: { move: true, inertia: true, lock: :start } })
 c.color({ id: :col1, red: 1, blue: 1 })

 c.shadow({
              id: :s1,
              # affect: [:the_circle],
              left: 9, top: 3, blur: 9,
              invert: false,
              red: 0, green: 0, blue: 0, alpha: 1
            })

shadow({
           id: :s2,
           affect: [:the_circle],
           left: 3, top: 9, blur: 9,
           invert: true,
           red: 0, green: 0, blue: 0, alpha: 1
         })

c.shadow({
           id: :s4,
           left: 20, top: 0, blur: 9,
           option: :natural,
           red: 0, green: 1, blue: 0, alpha: 1
         })

wait 2 do
  c.remove(:s4)
  wait 2 do
    c.remove({ all: :shadow })
  end
end


the_text = text({ data: 'text with shadow!', center: true, top: 222, width: 777, component: { size: 66 }, id: :my_text })


the_text.shadow({
           id: :my_shadow,
           left: 6, top: 6, blur: 6,
           option: :natural,
           red: 0, green: 0, blue: 0, alpha: 1
         })

the_text.left(255)
the_text.top(66)
the_text.color(:red)

wait 1 do
  text_shadow= grab(:my_shadow)
  text_shadow.alpha(0.5)
  text_shadow.left(120)
  text_shadow.blur({ value: 1 })

  # grab(:my_text).refresh(true)

end

