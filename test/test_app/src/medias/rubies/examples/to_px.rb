# frozen_string_literal: true

b = box()
c=b.circle({width: '25%'})
# wait 3 do
b.width('35%')
puts grab(:view).width.to_px
puts b.width.to_px
puts c.width.to_px
c.parents
