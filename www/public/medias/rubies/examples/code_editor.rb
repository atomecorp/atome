# ide

t=text(content: "touch me to open the code editor", xx: 50)
t.touch do
  code({atome_id: :code_editor, content: :box})
end

code_editor_font_size=12
c=circle({size: 33})
c2=circle({size: 33, x: 69})
t=c.text({content: "-", center: true, color: :black})
t2=c2.text({content: "+", center: true, color: :black, x: 69})
t.center(true)
t2.center(true)


c.touch do
  code_editor_font_size=code_editor_font_size-10
  ATOME.set_codemirror_font_size("ide_atome_id", code_editor_font_size)

end

c2.touch do
  code_editor_font_size=code_editor_font_size+10
  ATOME.set_codemirror_font_size("ide_atome_id", code_editor_font_size)
end
