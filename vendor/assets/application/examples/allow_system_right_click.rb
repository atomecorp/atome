# frozen_string_literal: true
# class Atome

b=box({ left: 12, id: :the_first_box })
b.touch(true) do

  alt=b.alternate(true, false)
  if alt
    b.color(:green)
  else
    b.color(:red)
  end
  allow_right_touch(alt)

end

