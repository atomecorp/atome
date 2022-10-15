# Genesis.atome_creator_option(:color_pre_save_proc) do |params|
#   params={ render: [:html], id: "color_#{Universe.atomes.length}", type: :color,
#            red: 0, green: 0.3, blue: 0.2, alpha: 1 }
# end
#

# class Atome
#   def rotate_html(params, _atome)
#     alert "#the req params is : #{params}"
#   end
# end
#
#
# # TODO: auto generate html and headless methods to facilitate atome creation and test
# # TODO: generate all optionals particles and atomes method to pass the params send.
# Genesis.atome_creator_option(:rotate_pre_render_proc) do |params|
#   # params=params
#   alert "rotate params is : #{params[:method]}"
# end
##################################

# Genesis.generate_html_renderer(:type) do |params, atome, &proc|
#   instance_exec(&proc) if proc.is_a?(Proc)
#   send("#{params}_html", params, atome, &proc)
# end

# Genesis.generate_html_renderer(:shape) do |params, atome, &proc|
#   id_found = id
#   instance_exec(&proc) if proc.is_a?(Proc)
#   DOM do
#     div(id: id_found).atome
#   end.append_to($document[:user_view])
#   @html_object = $document[id_found]
#   @html_type = :div
# end

# Genesis.generate_html_renderer(:color) do |params, atome, &proc|
#   instance_exec(&proc) if proc.is_a?(Proc)
#   @html_type = :style
#   $document.head << DOM("<style id='#{id}'></style>")
# end

# Genesis.generate_html_renderer(:parent) do |params, atome, &proc|
#   instance_exec(&proc) if proc.is_a?(Proc)
#   if @html_type == :style
#     $document[params].add_class(id)
#   else
#     @html_object.append_to($document[params])
#   end
# end

##################################

# Genesis.particle_creator(:rotate)

# alert Utilities.renderer_list
b = box({ width: 333, left: 666, id: :poil })
b.height(33)
b.left(333)

b.smooth([33, 2, 90])
b.touch(true) do

  color({ render: [:html], id: "color_#{Universe.atomes.length}", type: :color,
          red: 1, green: 0.33, blue: 0.22, alpha: 1 })
end
c = b.box({ left: 333 })
# c.parent(b.id)
# alert b.id
# b.left(99)
b.top(99)
# Genesis.generate_html_renderer(:rotate) do
#   puts ' hello rotator : too,much cool'
# end

Genesis.particle_creator(:rotate) do |params, atome, &proc|
  # puts atome
  # instance_exec(method_name, params, atome, &proc) if proc.is_a?(Proc)
end

b.rotate(999) do
  puts :poilu
end

# drag example
Genesis.particle_creator(:drag)
Genesis.generate_headless_renderer(:drag) do |value, atome, user_proc|
  puts "msg from headless drag method: value is #{value} , atome class is #{atome.class}"
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end

Genesis.generate_html_renderer(:drag) do |value, atome, user_proc|
  puts "msg from html drag method: value is #{value} , atome class is #{atome.class}"
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end
# it work :
# a = Atome.new(
#   { render: [:headless], id: :poil, type: :shape, parent: :user_view, left: 0, right: 0, top: 0, bottom: 0,
#     color: { render: [:headless], id: :c31, type: :color,
#              red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } }
# )
# doesn't work :
a = Atome.new(
  shape: { render: [:html], id: :crasher, type: :shape, parent: :view, left: 99, right: 99, width: 99, height: 99,
           color: { render: [:html], id: :c315, type: :color,
                    red: 1, green: 0.15, blue: 0.15, alpha: 0.6 } }
)
# puts a.inspect
a.shape.drag(11199) do
  puts :poilu_du_drag
end
# Genesis.atome_creator_option(:color_pre_save_proc) do |params|
#   # puts "1- optional color_pre_save_proc: #{params[:params].class}\n"
#   # toto=params
#   # TODO we must be able use default render instead of an exmplicit value
#   # { render: [:html], id: :c315, type: :color,
#   #   red: 1, green: 0.15, blue: 0.15, alpha: 0.6 }
#   # params[:params]
#   # toto
#   # if params[:value].instance_of?(Symbol) || params[:value].instance_of?(String)
#   #   params[:value] = { render: [:html], id: :c319, type: :color,
#   #                     red: 1, green: 1, blue: 0.15, alpha: 0.6 }
#   # end
#   puts params[:value][:parent]
#   params[:value] = { render: [:html], id: :c333, parent: params[:value][:parent],type: :color,
#                     red: 0, green: 1, blue: 0.15, alpha: 0.6 }
#   # params[:value] = :green
#   params
# end

c = circle
Genesis.atome_creator_option(:color_pre_save_proc) do |params|
  # puts "1- optional color_pre_save_proc: #{params[:params].class}\n"
  # toto=params
  # TODO we must be able use default render instead of an exmplicit value
  # { render: [:html], id: :c315, type: :color,
  #   red: 1, green: 0.15, blue: 0.15, alpha: 0.6 }
  # params[:params]
  # toto
  # if params[:value].instance_of?(Symbol) || params[:value].instance_of?(String)
  #   params[:value] = { render: [:html], id: :c319, type: :color,
  #                     red: 1, green: 1, blue: 0.15, alpha: 0.6 }
  # end
  puts params[:value][:parent]
  params[:value] = { render: [:html], id: :c333, type: :color,
                     parent: params[:value][:parent], red: 0, green: 1, blue: 0.15, alpha: 1 }
  # params[:value] = :green
  params
end
# c.color(
#   { render: [:html], id: :c319, type: :color,
#     red: 1, green: 1, blue: 0.15, alpha: 0.6 }
# )
Genesis.atome_creator_option(:color_sanitizer_proc) do |params|
  unless params.instance_of? Hash
    if RUBY_ENGINE.downcase == 'opal'
      rgb_color = `d = document.createElement("div");
    d.style.color = #{params};
    document.body.appendChild(d)
   rgb_color=(window.getComputedStyle(d).color);
d.remove();
`
      color_converted = { red: 0, green: 0, blue: 0, alpha: 1 }
      rgb_color.gsub("rgb(", "").gsub(")", "").split(",").each_with_index do |component, index|
        color_converted[color_converted.keys[index]] = component.to_i/255
      end
      # alert color_converted
    else
      rgb_color = Color::CSS["red"].css_rgb
      color_converted = { red: 0, green: 0, blue: 0, alpha: 1 }
      rgb_color.gsub("rgb(", "").gsub(")", "").gsub("%", "").split(",").each_with_index do |component, index|
        component = component.to_i/100
        color_converted[color_converted.keys[index]] = component
      end
      puts color_converted
    end

    params = { render: [:html], id: :c319, type: :color}.merge(color_converted)

  end
  alert ("Pass the id of the parent to attach to it and generate the id correctly, color is : #{params}")
  params

end

# c.color(:green)
puts "------"
c.color(:orange)
# c.color(
#   { render: [:html], id: :c319, type: :color,
#     red: 1, green: 1, blue: 0.15, alpha: 0.6 }
# )

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


