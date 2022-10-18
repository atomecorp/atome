# dynamic centering example

b = box({ width: 700, height: 120, drag: true, center: { dynamic: true } })
c = circle({y:33})
c.text({content: "activate dynamic 'continuous' centering", color: :white})
t2=text({content: "remove dynamic centering on box", color: :white, y: 0})
t = text({ content: "ok", color: :white, center: :x , y: 69})

c.touch do
  grab(:buffer).content[:resize] = [t, b]
  ATOME.resize_html do |evt|
    t.content("#{evt[:width]}  #{evt[:height]}")
    grab(:buffer).content[:resize].each do |element|
      element.center=element.center
    end
  end
end

t2.touch do
  grab(:buffer).content[:resize] = [t]
end
