

b=box()
# b.x(33)
def custom_code val
  `console.log(#{val})`
end

custom_code "good news for you"
# todo change server strategy and use index.html to test server and connect to it if no connection stay use opal
require 'application/view_example'
# def toto(e)
#   e.prevent
#   e.on.inner_text = "Super Clicked!"
# end
#
# $document.on(:mousedown, "#good") do |e|
#   toto(e)
# end
# $document.on(:touchstart, "#good") do |e|
#   toto(e)
# end
#
# verif = <<-STR
# $document.ready do
#     DOM {
#     div.info {
#       span.red "Opal eval cooked up!"
#     }
#     }.append_to($document.body)
#   end
# STR
#
# eval(verif)
#
#
# $document.body.style.apply {
#   background color: 'black'
#   color 'orange'
#   font family: 'Verdana'
# }
# $document.ready do
#   DOM {
#     div.info {
#       i=0
#       while i< 20
#         i+=1
#         span(id: "good").red "Opal cooked up, click me #{i}"
#         div(id: "hook").red "lllll#{i} --"
#       end
#     }
#   }.append_to($document["user_view"])
#
#   # alert($document.body.id)
#   # $document.getElementById("hook").style.color("red")
#   # bb=$document.find('header')
#   bb=`document.getElementById('hook')`
#   # a=	$document.get_element_by_id(:hook)
#   a=	$document[:hook]
#
#   elem = $document.at_css(".red").style(color: :yellow)
#
#   $document.on :click do |e|
#     elem.style(color: :yellowgreen)
#     # elem.style.apply {
#     # 	background color: 'blue'
#     # 	color 'green'
#     # 	font family: 'Verdana'
#     # }
#     # a.style.apply {
#     # 		  background color: 'red'
#     # 		  color 'black'
#     # 		  font family: 'Verdana'
#     # 		}
#   end
#
#   # bb =$document.id='hook'
#   # bb= $document["hook"]
#   #  bb.on.inner_text"jsqhdgfjqhsdgfjqhsgdjhqsg Clicked!"
#   # bb.style.apply {
#   # 	background color: 'black'
#   # 	color 'orange'
#   # 	font family: 'Verdana'
#   # }
#
# end
#
# $document.body.style.apply {
#   background color: 'black'
#   color 'orange'
#   font family: 'Verdana'
# }
#
#
# def box(params={})
#   DOM do
#     el=div(id: "hook")
#     el( ",jb,jb")
#   end.append_to($document["user_view"])
#
# end
#
# box
#
# e=$document.at_css("#hook")
# e.style { background color: 'lime' }
# $document.at_css("#hook").style(color: :red)
# # Example 2
# DOM do
#   div(id: "hook").red "lllll"
#   div(id: "poil").red "kool"
# end.append_to($document["user_view"])
# elem = $document.css("#poil").style(color: :orange)
#
# # #Example 3
# def box(params = {})
#   params = { color: :pink, width: 100, height: 100 }.merge(params)
#   DOM do
#     div(id: "hook",
#         class: :toto,
#         style: "background-color: #{params[:color]};
#                width: #{params[:width]}px;
#                height: #{params[:height]}px;
#                box-shadow: #{params[:shadow]};
#                ")
#       .the_class
#   end.append_to($document["user_view"])
# end
#
# window_height= $window.view.height/12
# window_width= $window.view.width/12
# box({ color: :green, shadow: "0px 0px 10px black;" })
# $document.body['foo'] = 'bar'
#
#
# $window.on :resize do |e|
#   puts $window.view.height
#   puts  $window.view.width
#   puts "------"
#   # alert  $document.body.width
# end
#
# puts $document.search('div').size
# # $document.search('div')['foo'] = 'bar'
#
#



# require 'browser/socket'

ws =Browser::Socket.new 'ws://127.0.0.1:9292'
ws.on :open do
end

ws.on :message do |e|
  puts "message received from websocket#{ e.data}"
end


def send_message(socket,msg)
if  socket.alive?
  socket.send(msg )
else
  after 0.1 do
    send_message(socket,msg)
  end
end

end

my_msg={ foo: "bar" }
my_msg=JSON.generate(my_msg)
send_message(ws,my_msg)
# aa=Digest::SHA1.hexdigest "foo"
# alert aa
# if RUBY_ENGINE.downcase == 'opal'
#   puts "ok"
#   # require 'atome/extensions/sha_opal.rb'
# else
#   require 'atome/extensions/sha_ruby.rb'
#   puts "pas ok"
#
# end


# if RUBY_ENGINE.downcase != 'opal'
#   alert :no
# else
#   alert :good
# end

# alert calculate_sha("jeezs")
puts "hellodf=lkjsmlfkjmhljsmfglhkjmflghkjdmlfgkjhmslkfgjh".to_i(36)

puts "foo".hash

######### Storage example #########
require 'browser/storage'

$storage = $window.storage
$storage[:hello] = { jeezs: { data: :kool } }

# alert($storage[:hello][:jeezs])
$storage[:hello][:jeezs][:toto]=:titi
puts  "storage content is : #{$storage[:hello]}"


# require 'browser/database/sql'
#
# db = Browser::Database::SQL.new 'test'
# db.transaction {|t|
#   t.query('CREATE TABLE test(ID INTEGER PRIMARY KEY ASC, text TEXT)').then {
#     t.query('INSERT INTO test (id, text) VALUES(?, ?)', 1, 'huehue')
#   }.then {
#     t.query('INSERT INTO test (id, text) VALUES(?, ?)', 2, 'jajaja')
#   }.then {
#     t.query('SELECT * FROM test')
#   }.then {|r|
#     r.each {|row|
#       alert row.inspect
#     }
#   }
# }

 ping('apple.com')
puts  "Universe  identity is : #{Universe.app_identity}"
alert Atome.aui