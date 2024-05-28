# frozen_string_literal: true

b=box
margin = 12
b2=box({top: below(b, margin)})
b3=box({top: below(b2, margin)})
b4=box({top: below(b3, margin)})
box({top: below(b4, margin)})
i=0
while i< 10 do
  b2=box({top: below(b, margin)})
  i+=1
end

b = circle(left: 66)
margin = 12
i = 0

while i < 10 do
  b = circle({top: below(b, margin), left: 66})
  i += 1
end