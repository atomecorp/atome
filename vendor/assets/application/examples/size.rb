# frozen_string_literal: true


c=circle
b=c.box({left: 155})
c.size(33)

wait 3 do
  c.size({value:  50, recursive: true, reference: :x })
  alert c.size
end

alert c.size