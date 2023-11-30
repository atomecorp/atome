# frozen_string_literal: true

b = box({ top: 166 , id: :the_box, left: 333})
b.color({id: :new_col, red: 1})
b.color({id: :other_col,  green: 1})
# b.paint({gradient: [:other_col, :new_col]})
color({id: :last_col,  green: 0.3, blue: 0.5})
color({id: :last_col2,  red: 1, blue: 0.5})

b.shadow({
           id: :s1,
           # affect: [:the_circle],
           left: 9, top: 3, blur: 9,
           invert: false,
           red: 0, green: 0, blue: 0, alpha: 1
         })
wait 1 do
  b.remove(:other_col)
  wait 1 do
    b.remove(:new_col)
    wait 1 do
      b.remove(:box_color)
      wait 1 do
        b.apply(:last_col)
        wait 1 do
          b.apply(:last_col2)
        end
      end
    end
  end
end
b.touch(true) do
  puts "before => #{b.apply}"
  b.remove({all: :color})
  puts "after => #{b.apply}"
  wait 1 do
    b.paint({id: :the_gradient_1,gradient: [:box_color, :circle_color]})
    b.paint({id: :the_gradient,gradient: [:other_col, :new_col]})
    wait 1 do
      b.remove(:the_gradient)
      wait 1 do
        b.remove(all: :shadow)
      end
    end
  end
end

