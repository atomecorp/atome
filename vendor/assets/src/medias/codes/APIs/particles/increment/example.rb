# frozen_string_literal: true

cc=color({red: 1, blue: 0.1,id: :the_col})
b=box({ left: 12, id: :the_first_box, apply: cc.id  })
c=circle({ left: 99, top: 99 })

wait 1 do
  c.increment({left: 33, top: 99})
  b.increment({left: 33, top: 99})
  wait 1 do
    c.increment({width: 33, top: -22})
    b.increment({width: 33, top: -9})
    cc.increment({red: -0.5})
    wait 1 do
      cc.increment({blue: 1})
    end
    # Atome.sync(:ok)
  end
end

# wait 3 do
#   color(:red)
# end
