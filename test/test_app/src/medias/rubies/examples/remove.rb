# frozen_string_literal: true

# TODO : some atomes and  particles may need have extra code to be removed (eg: color)

b = box({ left: 666, smooth: 12, blur: 3, color: :red})

wait 1 do
  b.remove(:blur)
  b.remove(:left)
  wait 1 do
    b.remove(:color)
    wait 1 do
      b.remove(:smooth)
    end
  end
end