# dynamic centering example

b = box({ width: 700, height: 120, drag: true, center: { dynamic: true } })
c = circle
c.text({content: "activate dynamic 'continuous' centering", color: :white})
t = text({ content: "ok", color: :black, center: :x , y: 333})

c.touch do
  grab(:buffer).content[:resize] = [t, b]
  ATOME.resize_html do |evt|
    t.content("#{evt[:width]}  #{evt[:height]}")
    grab(:buffer).content[:resize].each do |element|
      element.center=element.center
    end
  end
end
