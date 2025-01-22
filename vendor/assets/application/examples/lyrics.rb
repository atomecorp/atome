#  frozen_string_literal: true
new({ particle: :storage, category: :utility, type: :string })

b=box({width: 33, height: 33, color: :red})
t=text({data:  :counter, left: 120 })
t.touch(true) do
  t.storage
  t.data(t.storage)
end
# a = element({ id: :timer_1 })
b.touch(true) do
  t.timer({ start: 0, end: 3000 }) do |val|

    # puts val
    t.storage(val)
    # if val== 333
    #   t.data(val)
    # end

  end
end




