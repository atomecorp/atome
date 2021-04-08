# ide

t=text(content: "touch me to open the code editor", xx: 50)
t.touch do
  code({atome_id: :code_editor, content: :box})
end