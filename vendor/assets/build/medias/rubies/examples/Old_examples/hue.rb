
# hue example
moto=image(:moto)
i=0
repeater= repeat 0.03, 80000 do |evt|
  moto.hue(i)
  # puts i
  i+=1
end

