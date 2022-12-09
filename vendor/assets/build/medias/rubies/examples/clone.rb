# frozen_string_literal: true

b = box({ color: :red, smooth: 6 })

b.clones([left: 600, top: 300])

wait 1 do
  b.width(500)
end

wait 2 do
  b.height(500)
end

wait 4 do
  b.clones.value.each do |clone_found|
    grab(clone_found[:id]).delete(true)
  end
end

