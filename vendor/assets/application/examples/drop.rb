#  frozen_string_literal: true



dragged = box({ left: 33,top: 33, width: 333,color: :orange, smooth: 6, id: :drop_zone, drop: true }) do |event|
  alert "you drop : <<#{event}>>"
end

dragged = box({ left: 333, color: :blue,top: 222, smooth: 6, id: :the_box, drag: true })


