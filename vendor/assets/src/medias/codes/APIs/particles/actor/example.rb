# frozen_string_literal: true

bbb = box({left: 66})
ccc = bbb.circle(id: :the_circle)

bbb.role(:first)
bbb.role(:second)
bbb.delete(:left)
bbb.delete(:role)

bbb.role(:fourth)
bbb.role(:five)
bbb.role({ remove: :last })

bbb.actor({ the_circle: :buttons })
bbb.actor({ the_circle: :dummy })
bbb.actor({ the_circle: :menu })

bbb.actor({ remove: { the_circle: :dummy } })

puts "1 ===> #{bbb.role}"
puts "2 ===> #{bbb.actor}"
puts "3 ===> #{ccc.role}"