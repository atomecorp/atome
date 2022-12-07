# frozen_string_literal: true

b = box({ id: :the_box, left: 99, top: 99 })




s = b.shadow({ renderers: [:browser], id: :shadow2, type: :shadow, parents: [], children: [],
               left: 3, top: 9, blur: 3, direction: :inset,
               red: 0, green: 0, blue: 0, alpha: 1
             })


wait 1 do
  s.attach([:the_box])
  # or
  # b.children([:shadow2])
  wait 1 do
    s.blur(9)
    wait 1 do
      wait 2 do
        s.direction('')
        s.green(0)
        s.left(14)
        wait 1 do
          s.delete(true)
        end
      end
      s.left(44)
      s.green(0.7)
    end
  end
end

wait 3 do
  b.shadow({ blur: 33 })
end