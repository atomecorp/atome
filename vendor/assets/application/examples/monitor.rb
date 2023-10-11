# frozen_string_literal: true

b = box({ id: :the_box })
c = circle({ top: 3, id: :the_cirle })
grab(:view).monitor({ atomes: [:the_box, :the_cirle], particles: [:left] }) do |atome, particle, value|
  puts "changes : #{atome.id}, #{particle}, #{value}"
end

wait 2 do
  b.left(3)
  wait 2 do
    c.left(444)
  end
end
