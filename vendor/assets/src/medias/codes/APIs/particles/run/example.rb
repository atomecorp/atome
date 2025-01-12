#  frozen_string_literal: true

b = box({ left: 333, color: :blue, smooth: 6, id: :the_box2 })



exec_code=lambda do

  wait 1 do
    b.color(:violet)
  end

end

b.run(exec_code)


