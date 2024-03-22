# frozen_string_literal: true
t = text({ left: 33, top: 33, data: 'data collected', id: :infos })

inp=A.input({ width: 166,
              trigger: :up,
              back: :orange,
              shadow: {
                id: :s2,
                left: 3, top: 3, blur: 3,
                invert: true,
                red: 0, green: 0, blue: 0, alpha: 0.9
              },
              attach: :intuition,
              text: :black,
              smooth: 3,
              left: 66,
              top: 33,
              default: 'type here'
            }) do |val|

  grab(:infos).data(val)
end

inp.top(12)

  wait 1 do
    inp.width(666)
    wait 1 do
      inp.holder.data('new data')
    end
end



