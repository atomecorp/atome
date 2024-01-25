# frozen_string_literal: true


box({ left: 50, id: :the_first_box,  color: :blue })
b1=box({ left: 25, id: :the_second_box ,top: 3, unit: {left: '%', width: '%'}, color: :red})
box({ left: 550, id: :the_third_box , unit: {left: :px}, color: :green})
wait 2 do
  b1.unit({left: 'cm'})
  b1.unit({top: 'cm'})
  # b1.unit[:top]='cm'
  puts b1.unit
end


