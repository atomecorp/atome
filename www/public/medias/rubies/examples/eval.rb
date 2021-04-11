# eval example

require "opal-parser"
eval("box(x: 96,y: 96, smooth: 6, color: :orange)")
begin
  eval 'x = {id: 1'
rescue SyntaxError
  t=text("eval catch the error : 'x = {id: 1'")
  t.color(:red)
end