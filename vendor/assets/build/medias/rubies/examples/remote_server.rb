# remote server

def my_callback(val, opt)
  opt = eval(opt)
  t = text val
  opt.each do |prop, val|
    t.set({ prop => val })
  end
end


b = box({ x: 300 })
b.touch do
  # atome is the method target the atome_id if no method given notification is used by default
  # if no target then atome seek for a standard method
  # ATOME.message({type: :command, content: "pwd",target: b.atome_id, atome: :text , options:{color: :yellow, x: 333}})
  ATOME.message({ type: :read, file: "public/medias/rubies/test.rb", target: :my_callback, atome: :text, options: { color: :yellowgreen } })
  ATOME.message({ type: :code, content: "circle({x: 33,y: 33})" })

  # ATOME.message({type: :command, content: "cd public; ls; setxkbmap fr",target: b.atome_id, atome: :text , options:{color: :yellow, x: 333}})
  # ATOME.message({type: :atome,target: :my_callback,atome: :color,  content: "red"})
  # ATOME.message({type: :atome,target: b.atome_id,atome: :smooth,  content: 9})
end

# # c.touch do
# #   # todo: addpassword to write and delete methods
# #   # ATOME.message({type: :delete, file: "public/medias/datas/meteo_datas_new.txt", target: :toto, options:{color: :yellowgreen}})
# #   # ATOME.message({type: :write, file: "public/medias/datas/meteo_datas_new.txt",content: :hello, target: :toto, options:{color: :yellowgreen}})
# #   # ATOME.message({type: :list, path: "public/medias/datas/",target: :delete_images, options:{color: :yellowgreen}})
# #   # ATOME.message({type: :read, file: "public/medias/datas/meteo_datas.txt",target: :toto, options:{color: :yellowgreen}})
# # end