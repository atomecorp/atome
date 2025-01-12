#{BROWSER: {open: true, execute: true}}
# frozen_string_literal: true

b=box({left: 120, top: 120, color: :orange, id: :the_box})

b.touch(true) do
  puts 'touched'
  b.width(333)
  b.color(:yellow)
end


wait 1 do
  b.simulate(:touch)
end
