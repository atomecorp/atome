#  frozen_string_literal: true

b = box({ left: 333, color: :blue, smooth: 6, id: :the_box2 })

t = text({ id: :the_text, data: 'touch the box and wait!' })

exec_code=lambda do

  wait 2 do
    t.data('it works!! ')
  end

end
b.code(:hello) do
  circle({ left: rand(333), color: :green })
end
b.run(:hello)
b.touch(:tap) do
  {
    color: :cyan,
    target: { the_text: { data: :super! } },
    run: exec_code
  }
end

