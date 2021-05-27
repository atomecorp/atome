# remote server

b=box({ x: 300 })
b.touch do
  # atome is the method target the atome_id if no method given notification is used by default
  # if no target then atome seek for a standard method
  # ATOME.message({type: :read, file: "public/medias/datas/meteo_datas.txt"})
  # ATOME.message({type: :read, file: "public/medias/datas/meteo_datas.txt", atome: :notification})
  ATOME.message({type: :read, file: "public/medias/datas/meteo_datas.txt",target: b.atome_id, atome: :text , options:{color: :yellowgreen}})
  ATOME.message({type: :code, content: "circle({x: 33,y: 33})"})
  ATOME.message({type: :command, content: "cd public; ls; setxkbmap fr",target: b.atome_id, atome: :text , options:{color: :yellow, x: 333}})
  ATOME.message({type: :atome,target: b.atome_id,atome: :color,  content: "red"})
  ATOME.message({type: :atome,target: b.atome_id,atome: :smooth,  content: 9})
end