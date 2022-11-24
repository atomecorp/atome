# frozen_string_literal: true

b = box()

b.instance_variable_set('@left', 300)

wait 1 do
  b.refresh
end