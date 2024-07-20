# frozen_string_literal: true


t=text(:hello)
t.edit(true)
b=box({left: 99})

b.touch(true) do
  allow_copy(true)
  alow_right_touch(true)
end


