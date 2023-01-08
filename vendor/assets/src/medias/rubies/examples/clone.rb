# frozen_string_literal: true

# TODO : clones alteration must be bidirectional, to do so :
# 1 - we may create an atome type 'clone' then add a ' pre_render_clones option' when rendering clones property
# 2 - this pre_render_clones option, will catch alterations and throw it the the original atome
# 3 - we also add a new particle call mirror that holds the particle's list that will reverse intrication

b = box({ color: :red, smooth: 6, id: :the_box })

b.clones([{ left: 300, top: 300, color: :blue, intricate: [:width, :attached,:height ] },
          {left: 600, top: 366, color: :green , intricate: [:left, :height ]}])

wait 1 do
  b.width(190)
end

wait 2 do
  b.height(180)
end

wait 3 do
  b.left(180)
end

grab(:the_box_clone_0).smooth(33)
#
grab(:the_box_clone_1).rotate(33)


wait 5 do
  b.clones.value.each do |clone_found|
    grab(clone_found[:id]).delete(true)
  end
end

