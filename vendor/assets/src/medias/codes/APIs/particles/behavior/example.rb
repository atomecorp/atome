# frozen_string_literal: true

# Behaviors allow you to add specific code to any particle, enabling the particle to behave differently.
# Here, when the first box receives a value, it behaves differently from the second box even if they received
# the same params .

text({ data: :hello, id: :the_txt, left: 120 })

b=box

my_lambda= lambda do |new_value|
  grab(:the_txt).color(:red)
end

b.behavior({value: my_lambda})

my_second_lambda= lambda do |new_value|
  grab(:the_txt).data('from cirle')
end
c=box({top: 69})
c.behavior({value: my_second_lambda})

wait 1 do
  c.value(:ok)
end
wait 2 do
  b.value(:ok)
end




