#clear

b=box()
c=circle(x: 96)
t=text("click tme to clear the screen")
t.touch do
  clear(:view)
end