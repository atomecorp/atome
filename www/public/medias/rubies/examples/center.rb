# dynamic centering example

b = box({ width: 700, height: 120, drag: true, center: { dynamic: true } })
c = circle
t = text({ content: "ok", color: :black, center: :x })

ATOME.atomise(:batch, [b, c, t])
grab(:buffer).content[:resize] = [t, b]
ATOME.resize_html do |evt|
  t.content("#{evt[:width]}  #{evt[:height]}")
  grab(:buffer).content[:resize].each do |element|
    element.center=element.center
  end
end