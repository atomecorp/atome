# frozen_string_literal: true

b = box
c = circle
t = text('touch me')

b.copy([c.id, b.id, t.id])
b.copy(b.id)

wait 1 do
  c.paste([0, 2])
  wait 1 do
    t.paste(0)
  end

end

t.touch(true) do
  copies = t.paste(0)
  copies.each do |atome_paste|
    wait 1 do
      grab(atome_paste).color(:red)
    end
  end
end
