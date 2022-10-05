# new_format

other_test = { shape:
                 { id: :my_shape, width: 333, color: { id: :c0, red: 0.3, green: 1, blue: 1, alpha: 1,
                                                       additional:
                                                         [{ id: :col1, red: 1, green: 0, blue: 0.1, alpha: 1 },
                                                          { id: :col2, red: 0, green: 1, blue: 0.6, alpha: 1 }] } } }
x = Atome.new(other_test)
# puts x.shape.width(333)

# i=Utilities.grab(:my_shape).width(666)
# puts ''
# puts i
puts x.shape.width(333)

# puts "--#{Utilities.grab(:my_shape)}"
b=Utilities.grab(:my_shape)

puts b.width
# puts x.shape.width
# puts x.shape.color
# puts x.shape.set_width(933)
# puts x.shape.width=963
# puts x.shape.width
# puts x.shape.color.additional

# puts x.shape.set_color({red: 99})

# puts x.shape.colors[0].red(0)
# x.shape.colors([{ id: :c3, red: 0.3, green: 1 }])
# puts x.shape.id
# puts x.shape.colors[0].red
# x.shape.colors[0].red(0.999)
# puts x.shape.colors[0].red
