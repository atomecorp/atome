# # # `three_test()`
# # wait 1 do
# #   #   `third_d.universe()`
# # end
# # # `third_d_test("poilu")`
# # `third_d.universe()`
# #
# # def cube(params)
# #   grab(:view).cube(params)
# # end
# #
# # def light(params)
# #   grab(:view).light(params)
# # end
# #
# # class Atome
# #
# #   def cube(params)
# #     cube_html(params)
# #   end
# #
# #   def light(params)
# #     light_html(params)
# #   end
# #
# #   def light_html(params)
# #     opal_light(params)
# #   end
# #
# #   def cube_html(params)
# #     opal_cube(params)
# #   end
# #
# #   def opal_cube(params)
# #     # atome_3d_id = { atome_id: (0...8).map { (65 + rand(26)).chr }.join }
# #     atome_3d_id = params
# #     `third_d.addCube(#{atome_3d_id}, #{params})`
# #   end
# #
# #   def opal_light(params)
# #     # atome_3d_id = { atome_id: (0...8).map { (65 + rand(26)).chr }.join }
# #     atome_3d_id = "theCube"
# #     `third_d.addLight(#{atome_3d_id}, #{params})`
# #   end
# #
# # end
# #
# # c = circle
# # c2 = circle({ x: 300, color: :yellow })
# # c3 = circle({ x: 600, color: :yellowgreen })
# # c.touch do
# #   cube("toto")
# #   # cube({ color: :red })
# # end
# #
# # c2.touch do
# #   # alert :kool
# #   light({ color: :red })
# # end
# #
# # c3.touch do
# #   # alert :kool
# #   # `third_d.move("toto")`
# #   `third_d.touch("toto")`
# #   `third_d.anim("toto")`
# # end
# #
# # # star({ y: 330, x: 333, atome_id: :titi })
# # sphere({ atome_id: :the_sphere, y: 220 })
# #
# # title = box({atome_id: :the_box})
# # wait 1 do
# #   title.animation({
# #                   start: { smooth: 0, blur: 0, rotate: 0, color: { red: 1, green: 1, blue: 1 } },
# #                   end: { smooth: 25, rotate: 180, blur: 3, color: { red: 1, green: 0, blue: 0 } },
# #                   duration: 1000,
# #                   loop: 100,
# #                   curve: :easing,
# #                   # target: title.atome_id
# #                 })
# #   # alert title.inspect
# # end
# # require "opal-parser"
# # reader("./medias/rubies/test.rb") do |data|
# #   compile data
# # end
#
# require "opal-parser"
# # reader("http://192.168.0.47:9292/medias/rubies/test.rb") do |data|
# #   eval data
# # end
#
# # ATOME.websocket("ws.atome.one", true)
#
# # ATOME.websocket("192.168.0.47:9292")
# # ATOME.websocket("192.168.1.56:9292")
# ATOME.websocket("localhost:9292")
#
#
# text ({ content: "test content is ", atome_id: :test_content })
# def my_callback(val, opt)
#   opt = eval(opt)
#   grab(:test_content).content(val)
#   # opt.each do |prop, val|
#   #   t.set({ prop => val })
#   # end
# end
#
# def tryout val
#   alert "value is : #{val.inspect}"
# end
#
#
# b = box({ x: 300, atome_id: :the_box })
# b.y(300)
# # b.connect("192.168.0.47:9292")
# # b.connect("192.168.1.56:9292")
# # wait 1 do
# #   every 1,0 do
# #     # ATOME.message({ address: "localhost:9292",ssl: false,type: :monitor, file: ["public/medias/rubies/test.rb","public/medias/rubies/text_read.rb"], target: :tryout, atome: :text, options: { color: :yellowgreen } })
# #     ATOME.message({ address: "localhost:9292",ssl: false,type: :monitor, file: "public/medias/e_projects/chambon/code.rb", target: :tryout, atome: :text, options: { color: :yellowgreen } })
# #     # ATOME.message({ address: "localhost:9292",ssl: false,type: :monitor, file: , target: :my_callback, atome: :text, options: { color: :yellowgreen } })
# #   end
# # end
# wait 1 do
#   ATOME.message({ address: "localhost:9292",ssl: false,type: :monitor, file: ["public/medias/rubies/test.rb","public/medias/rubies/users/code.rb"], target: :tryout, atome: :text, options: { color: :yellowgreen } })
#   # ATOME.message({ address: "localhost:9292",ssl: false,type: :monitor, file: ["public/medias/rubies/test.rb","public/medias/rubies/text_read.rb"], target: :tryout, atome: :text, options: { color: :yellowgreen } })
# end
#
# b.touch do
#   # ATOME.websocket("localhost:9292")
#   # ATOME.message({ address: "localhost:9292",ssl: false,type: :monitor, file: "public/medias/rubies/text_read.rb", target: :my_callback, atome: :text, options: { color: :yellowgreen } })
#   # alert :kool
#   # atome is the method target the atome_id if no method given notification is used by default
#   # if no target then atome seek for a standard method
#   # ATOME.message({type: :command, content: "pwd",target: b.atome_id, atome: :text , options:{color: :yellow, x: 333}})
#   ATOME.message({ address: "localhost:9292",ssl: false,type: :monitor, file: ["public/medias/rubies/test.rb","public/medias/e_projects/chambon/code.rb"], target: :tryout, atome: :text, options: { color: :yellowgreen } })
#   ATOME.message({ address: "localhost:9292",ssl: false,type: :read, file: "public/medias/rubies/test.rb", target: :my_callback, atome: :text, options: { color: :yellowgreen } })
#   ATOME.message({ type: :code, content: "circle({x: 33,y: 33})" })
#   # ATOME.message({type: :command, content: "cd public; ls; setxkbmap fr",target: :tryout, atome: :text , options:{color: :yellow, x: 333}})
#   ATOME.message({type: :command, content: "cd public; ls",target: :tryout, atome: :text , options:{color: :yellow, x: 333}})
#
#
#   # ATOME.message({type: :atome,target: :my_callback,atome: :color,  content: "red"})
#   # ATOME.message({type: :atome,target: b.atome_id,atome: :smooth,  content: 9})
# end
#
#
#
#
#
#
#
i=image("Icon_Help")
i.size(30)