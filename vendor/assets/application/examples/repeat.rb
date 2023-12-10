#  frozen_string_literal: true


c=circle({width: 66, height: 66})
t1=c.text({id: :first, data: 0, left: 28})
cc=circle({width: 66, height: 66, left: 0 })
t2=cc.text({id: :second, data: 0, left: 28})
first_repeater=repeat(1, repeat = 99) do |counter|
  t1.data(counter)
end

my_repeater=repeat(3, repeat = 9) do |counter|
  t2.data(counter)
end

c.touch(true) do
  stop({ repeat: first_repeater })
  t1.data(:stopped)
end

cc.touch(true) do
  stop({ repeat: my_repeater })
  t2.data(:stopped)
end

# use Float::INFINITY to infinite repeat