# frozen_string_literal: true

b = box({ top: 166 , id: :the_box})
b.color({id: :new_col, red: 1})
b.color({id: :other_col,  green: 1})
# b.paint({gradient: [:other_col, :new_col]})
color({id: :last_col,  green: 0.3, blue: 0.5})
color({id: :last_col2,  red: 1, blue: 0.5})
wait 1 do
  b.remove(:other_col)
  # alert :ok
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
  # puts "b.color : #{b.color}"
  # puts "b.apply : #{b.apply}"
end

text(' touch the box to remove all colors')
