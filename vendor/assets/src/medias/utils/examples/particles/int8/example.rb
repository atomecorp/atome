# frozen_string_literal: true

# t = text({ int8: { english: :hello, french: :salut, deutch: :halo } })

# wait 1 do
#   t.language(:french)
#   wait 1 do
#     t.language(:english)
#     # data is updated to the latest choice
#     puts t.data
#     wait 1 do
#       t.data(:hi)
#     end
#   end
# end

Universe.translation[:hello] = { english: :hello, french: :salut, deutch: :halo }

b = box({ left: 155,
          drag: true,
          id: :boxy })


b.text({ data: :hello, id: :t1, position: :absolute, color: :black })
t2 = b.text({ data: :hello, id: :t2, left: 9, top: 33, position: :absolute })



Universe.language = :french
wait 2 do
  t2.refresh
  Universe.language = :deutch
  wait 2 do
  grab(:boxy).refresh
  end
end
