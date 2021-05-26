# remote server

b=box(x: 369)
b.touch do
  ATOME.message({type: :read, message: "my_file"})
  ATOME.message({type: :code, message: "circle({x: 33,y: 33})"})
  ATOME.message({type: :command, message: "cd public; ls; setxkbmap fr"})
end