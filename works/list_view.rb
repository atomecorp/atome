#display as list
a=image(:moto)
a.opacity(0)
i=0
a.inspect.sort.each do |property|
  t= text({ content: "#{property[0]} :", x: 9})
  t2= text({ content: "#{property[1]}", x: 96 })
  t.y=t2.y=((t.height+6)*i+9)
  i+=1
end