# remote server

b=box(x: 369)
b.touch do
  ATOME.message({type: :code, message: "box({x: 33,y: 33})"})
  ATOME.shell "cd public; ls; setxkbmap fr"
end