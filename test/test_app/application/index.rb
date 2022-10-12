# `console.clear()`

# class Atome
#   def smooth_html(params, _atome, &proc)
#     formated_params = case params
#                       when Array
#                         properties = []
#                         params.each do |param|
#                           properties << "#{param}px"
#                         end
#                         properties.join(' ').to_s
#                       when Integer
#                         "#{params}px"
#                       else
#                         params
#                       end
#     @html_object.style['border-radius'] = formated_params unless @html_type == :style
#     # @html_object.style.apply {
#     #   background color: 'black'
#     #   color 'orange'
#     #   border radius: "120px"
#     # #   font family: 'Verdana'
#     # }
#   end
#
#   def touch_html(params, _atome, &proc)
#     @html_object.on :click do |e|
#       instance_exec(&proc) if proc.is_a?(Proc)
#     end
#   end
# end

# $document[:style] << ".#{id}{background-color: rgba(#{params * 255},#{green_found * 255},#{blue_found * 255},#{alpha_found})}"

# $document.ready do

# def box(params = {})
#   temp_default = { render: [:html], id: "box_#{Universe.atomes.length}", type: :shape, width: 99, height: 99, left: 9, top: 9,
#                    color: { render: [:html], id: "color_#{Universe.atomes.length}", type: :color,
#                             red: 0.69, green: 0.69, blue: 0.69, alpha: 1 } }
#   params = temp_default.merge(params)
#
#   Atome.new(params)
# end
#
# def circle(params = {})
#   temp_default = { render: [:html], id: "box_#{Universe.atomes.length}", type: :shape, width: 99, height: 99, left: 9, top: 9,
#                    color: { render: [:html], id: "color_#{Universe.atomes.length}", type: :color,
#                             red: 1, green: 0.69, blue: 1, alpha: 1 }, smooth: "100%" }
#   params = temp_default.merge(params)
#
#   Atome.new(params)
# end
#
# # alert


b = box({ width: 333 , left: 666,id: :poil})
b.height(33)
b.left(333)


b.smooth([33, 2, 90])
b.touch(true) do
  color({ render: :html, id: "color_#{Universe.atomes.length}", type: :color,
          red: 1, green: 0.69, blue: 1, alpha: 1 })
end
c=b.box({left: 333})
# c.parent(b.id)
# alert b.id
# b.left(99)
b.top(99)



# box(:ok)

# b=Atome.new

# puts b.box
# end

# ############### end  test 1
#
# # def box(params = {})
# #   params = { color: :pink, width: 190, height: 100,shadow: 'box-shadow: inset 0 0 30px' }.merge(params)
# #   DOM do
# #     div(id: "hook",
# #         class: :toto,
# #         style: "background-color: #{params[:color]};
# #                width: #{params[:width]}px;
# #                height: 222px;
# #                box-shadow:  inset 0 0 9px;
# #                ")
# #       .the_class
# #   end.append_to($document["user_view"])
# #
# #   @html_object =$document[:hook]
# #
# #
# # 		@html_object.style['width']  = '180px'
# # end
# #
# # box
#
# ######### test below
#
# # DOM {
# # div(id: :mydiv).info {
# #   span.red "I'm all cooked up."
# # }
# # }.append_to($document.body)
#
# #   DOM {
# #       div(id: "tutu").info {
# #
# #           span(id: "good").red "Opal cooked up, click me "
# #           div(id: "hook").red "lllll--"
# #       }
# #     }.append_to($document["user_view"])
# #
# #
# #
# #
# # # event test
# #
# # def toto(e)
# # 	# alert :good
# #   e.prevent
# #   e.on.inner_text = "Super Clicked!"
# # end
# #
# #
# #
# #
# # $document.on(:mousedown, "#good") do |e|
# #   toto(e)
# # end
# # $document.on(:touchstart, "#good") do |e|
# #   toto(e)
# # end
# #
# # verif = <<-STR
# # $document.ready do
# #     DOM {
# #     div.info {
# #       span.red "Opal eval cooked up!"
# #     }
# #     }.append_to($document.body)
# #   end
# # STR
# #
# # eval(verif)
# #
# #
# # $document.body.style.apply {
# #   background color: 'black'
# #   color 'orange'
# #   font family: 'Verdana'
# # }
# # $document.ready do
# #   DOM {
# #     div.info {
# #       i=0
# #       while i< 20
# #         i+=1
# #         span(id: "good").red "Opal cooked up, click me #{i}"
# #         div(id: "hook").red "lllll#{i} --"
# #       end
# #     }
# #   }.append_to($document["user_view"])
# #
# #   # alert($document.body.id)
# #   # $document.getElementById("hook").style.color("red")
# #   # bb=$document.find('header')
# #   bb=`document.getElementById('hook')`
# #   # a=	$document.get_element_by_id(:hook)
# #   a=	$document[:hook]
# #
# #   elem = $document.at_css(".red").style(color: :yellow)
# #
# #   $document.on :click do |e|
# #     elem.style(color: :yellowgreen)
# #     # elem.style.apply {
# #     # 	background color: 'blue'
# #     # 	color 'green'
# #     # 	font family: 'Verdana'
# #     # }
# #     # a.style.apply {
# #     # 		  background color: 'red'
# #     # 		  color 'black'
# #     # 		  font family: 'Verdana'
# #     # 		}
# #   end
# #
# #   # bb =$document.id='hook'
# #   # bb= $document["hook"]
# #   #  bb.on.inner_text"jsqhdgfjqhsdgfjqhsgdjhqsg Clicked!"
# #   # bb.style.apply {
# #   # 	background color: 'black'
# #   # 	color 'orange'
# #   # 	font family: 'Verdana'
# #   # }
# #
# # end
# #
# # $document.body.style.apply {
# #   background color: 'black'
# #   color 'orange'
# #   font family: 'Verdana'
# # }
# #
# #
# # def box(params={})
# #   DOM do
# #     el=div(id: "hook")
# #     el( ",jb,jb")
# #   end.append_to($document["user_view"])
# #
# # end
# #
# # box
# #
# # e=$document.at_css("#hook")
# # e.style { background color: 'lime' }
# # $document.at_css("#hook").style(color: :red)
# # # Example 2
# # DOM do
# #   div(id: "hook").red "lllll"
# #   div(id: "poil").red "kool"
# # end.append_to($document["user_view"])
# # elem = $document.css("#poil").style(color: :orange)
# #
# # # #Example 3
# # def box(params = {})
# #   params = { color: :pink, width: 100, height: 100 }.merge(params)
# #   DOM do
# #     div(id: "hook",
# #         class: :toto,
# #         style: "background-color: #{params[:color]};
# #                width: #{params[:width]}px;
# #                height: #{params[:height]}px;
# #                box-shadow: #{params[:shadow]};
# #                ")
# #       .the_class
# #   end.append_to($document["user_view"])
# # end
# #
# # window_height= $window.view.height/12
# # window_width= $window.view.width/12
# # box({ color: :green, shadow: "0px 0px 10px black;" })
# # $document.body['foo'] = 'bar'
# #
# #
# # $window.on :resize do |e|
# #   puts $window.view.height
# #   puts  $window.view.width
# #   puts "------"
# #   # alert  $document.body.width
# # end
# #
# # puts $document.search('div').size
# # # $document.search('div')['foo'] = 'bar'
# #
# #
#
# # # require 'browser/socket'
# # ################ socket test
# # ws =Browser::Socket.new 'ws://127.0.0.1:9292'
# # ws.on :open do
# # end
# #
# # ws.on :message do |e|
# #   puts "message received from websocket#{ e.data}"
# # end
# #
# #
# # def send_message(socket,msg)
# # if  socket.alive?
# #   socket.send(msg )
# # else
# #   after 0.1 do
# # 	send_message(socket,msg)
# #   end
# # end
# #
# # end
# #
# # my_msg={ foo: "bar" }
# # my_msg=JSON.generate(my_msg)
# # send_message(ws,my_msg)
# # ################ end socket test
#
# # aa=Digest::SHA1.hexdigest "foo"
# # alert aa
# # if RUBY_ENGINE.downcase == 'opal'
# #   puts "ok"
# #   # require 'atome/extensions/sha_opal.rb'
# # else
# #   require 'atome/extensions/sha_ruby.rb'
# #   puts "pas ok"
# #
# # end
#
# # if RUBY_ENGINE.downcase != 'opal'
# #   alert :no
# # else
# #   alert :good
# # end
#
# # alert calculate_sha("jeezs")
# # puts "hellodf=lkjsmlfkjmhljsmfglhkjmflghkjdmlfgkjhmslkfgjh".to_i(36)
# #
# # puts "foo".hash
#
# # require 'browser/database/sql'
# #
# # db = Browser::Database::SQL.new 'test'
# # db.transaction {|t|
# #   t.query('CREATE TABLE test(ID INTEGER PRIMARY KEY ASC, text TEXT)').then {
# #     t.query('INSERT INTO test (id, text) VALUES(?, ?)', 1, 'huehue')
# #   }.then {
# #     t.query('INSERT INTO test (id, text) VALUES(?, ?)', 2, 'jajaja')
# #   }.then {
# #     t.query('SELECT * FROM test')
# #   }.then {|r|
# #     r.each {|row|
# #       alert row.inspect
# #     }
# #   }
# # }
#
# # puts "¨¨¨¨¨¨#{params}"
# # @html_object.style.apply {
# #   # display: :bloc
# #   # position: :absolute
# #   # width: 888px
# #   #overflow: 'scroll'
# #   background color: 'black'
# #   color 'green'
# #   font size: '33.3px'
# #   # font family: 'Verdana'
# # }
#
# # `
# # var newContent = document.createTextNode('super');
# #  // ajoute le nœud texte au nouveau div créé
# #  newDiv=#{@html_object}
# #  newDiv.appendChild(newContent);
# #  newDiv.id='div1';
# #
# #  // ajoute le nouvel élément créé et son contenu dans le DOM
# #  var currentDiv = document.getElementById('div1');
# #  document.body.insertBefore(newDiv, currentDiv);
# # var selectedRow = document.querySelector('div#div1');
# # selectedRow.style.color = 'yellow';
# # newDiv.style.width = "666px"
# #    selectedRow.style.backgroundColor = 'red';
# #
# #
# #
# #
# # `

# $document.ready do
#   DOM {
#     div(id: :my_div).info {
#       span.red "Opal eval cooked up!"
#     }
#   }.append_to($document.body)
#   a = $document['#my_div']
#   a.style.apply {
#     background color: 'black'
#     color 'orange'
#     width '130px'
#     font family: 'Verdana'
#   }
# end

