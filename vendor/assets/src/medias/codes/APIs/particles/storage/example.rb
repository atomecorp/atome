# frozen_string_literal: true
t=text("touch the box to erase localstorage, long touch on the box to stop historicize")
b=box({top: 66})
c=circle({top: 99})
c.touch(true) do
  c.left(c.left+99)
  # c.left=c.left+33
  # box
end
b.touch(true) do
  JS.eval('localStorage.clear()')
end

b.touch(:long) do
  b.color(:red)
  Universe.allow_localstorage = false

end

