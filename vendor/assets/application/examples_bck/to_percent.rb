# frozen_string_literal: true

b=box
t=text({width: 66, left: 99,top: 66, data: "touch the bow and resize the window"})

b.touch(true) do
  b.width(t.to_percent(:width))
  b.left(t.to_percent(:left))
end
