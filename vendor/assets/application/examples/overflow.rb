# frozen_string_literal: true

b = box({ id: :the_container, width: 300, height: 300 })
b.box({top: 500, color: :red})
cc=b.circle({ top: 160, id: :the_circle })

initial_height=cc.height
b.overflow(:scroll) do |event|
  new_height = initial_height + event[:top]
  cc.height(new_height)
end