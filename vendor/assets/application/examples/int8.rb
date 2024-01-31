# frozen_string_literal: true

t = text({ int8: { english: :hello, french: :salut, deutch: :halo } })

wait 1 do
  t.language(:french)
  wait 1 do
    t.language(:english)
    # data is updated to the latest choice
    puts t.data
  end
end

puts t.data



