# frozen_string_literal: true

b = box({ id: :the_container, width: 300, height: 300, overflow: :scroll })
b.circle({ top: 280, id: :the_circle })

container = JS.global[:document].getElementById('the_container')
circle = JS.global[:document].getElementById('the_circle')

initialHeight = circle[:clientHeight].to_i

container.addEventListener('scroll', lambda do |event|
  scroll_position = container[:scrollTop].to_i

  new_height = initialHeight + scroll_position
  circle[:style][:height] = "#{new_height}px"
end)
