# right management example

b=box
b.touch do
  b.authorization({ users: :all, write: false, password: :my_secret})
  b.color(:red,"rong password")
  b.color(:yellowgreen,b.authorization[:password])
  b.x(99,:my_secret)
end

b2=b.box({x: 333})
b2.drag(true)
c=circle({y: 96})
c.touch do
  clear(:view)
end