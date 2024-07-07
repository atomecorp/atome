# frozen_string_literal: true
c=circle({left: 129, color: :red})
c.touch(true) do
  JS.eval('console.clear()')
  c.tick[:down]=0
  # grab(:boxy).touch(false)
  grab(:boxy).delete(true)
  wait 0.3 do
    box({id: :boxy})
    grab(:boxy).touch(:up) do
      c.tick(:down)
      puts "Hitted too!! #{c.tick[:down]}"
    end
  end
end
box({id: :boxy})

grab(:boxy).touch(:up) do
  puts "Hitted!!"
end
