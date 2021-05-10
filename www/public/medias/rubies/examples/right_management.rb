# right management example

b=box
b.touch do
  b.right({ users: :all, write: false, password: :my_secret})
  b.color(:red,"hgfdg")
  b.color(:yellowgreen,b.right[:password])
end