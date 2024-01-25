# frozen_string_literal: true

t = text({ int8: { english: :hello, french: :salut, deutch: :halo }, language: :deutch })

wait 1 do
  t.language(:french)
  wait 1 do
    t.language(:english)
  end
end
