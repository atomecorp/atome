#  frozen_string_literal: true

# deprecated:


# require "./examples/debug"

# make it works
# require "./examples/history"
# require "./examples/sync"
# require "./examples/generator_and_build"
# require "./examples/display"
# TODO : date picker U.I.
# TODO : progress bar U.I.
# TODO : Radio button U.I.
# TODO : Dropdowns U.I.
# TODO : Circular slider U.I.
# TODO : split allow_history in two methods : allow localstorage and allow sync
# TODO : in historicize only sync if online
# TODO : remove backtick in lib/platform_specific/opal/extensions/js.rb :  result = `eval(#{clean_str})`
# TODO : we may return an atome instead of a an arry in genesis/ew_atome group({ collect: collected_atomes })
# TODO :  finish  sync and history  apis
# TODO :  Make audio format mp4 like with tacks and effect references
# TODO :  Make video format mp4 like with tacks and effect references
# TODO :  message to server should not be a particle because the should'nt be store and sync
# TODO :  atome and methods that generate particle and atome should be store with the params but not the atomes gnarated
# to avoid bloated the localstorage and Db
# TODO :Websocket must be rewritten to avoid Opal.eval ans be coded in ruby not in js like the code below :
# class WebSocketManager
#   def initialize(type, server, user, pass, atomes, particles)
#     @type = type
#     @server = server
#     @user = user
#     @pass = pass
#     @atomes = atomes
#     @particles = particles
#     @websocket = nil
#   end
#
#   def connect
#     # Create a new WebSocket object
#     @websocket = JS.global.WebSocket.new("#{@type}://#{@server}")
#
#     # Define event handlers
#     @websocket.onopen = method(:on_open)
#     @websocket.onmessage = method(:on_message)
#     @websocket.onclose = method(:on_close)
#     @websocket.onerror = method(:on_error)
#   end
#
#   def on_open(event)
#     # Called when the connection is opened
#     JS.global.loadApplicationJs() # Assuming this is a global JS function you need to call
#     # You might need to call a Ruby method or perform some Ruby operations here
#     puts "WebSocket opened"
#   end
#
#   def on_message(event)
#     # Called when a message is received from the server
#     data = event.JS[:data]
#     JS.eval("Opal.Atome.$server_receiver(#{data})") # Send the data to a Ruby method, assuming server_receiver is defined in Ruby
#   end
#
#   def on_close(event)
#     # Called when the connection is closed
#     puts "WebSocket closed"
#   end
#
#   def on_error(event)
#     # Called when there is an error with the WebSocket
#     event.JS.preventDefault() # Prevent the default error handling
#     puts "WebSocket error"
#   end
#
#   def ws_sender(message)
#     # Send a message to the server
#     @websocket.JS.send(message)
#   end
# end

# require "./web2"
# alert Universe.eVe

# to debug

# regression to debug
# require "./examples/table"

# in progress
# require "./examples/interop_ruby_js"
# require "./examples/aXion"
# require "./examples/aXion_with_key"
# require "./examples/above_below_before_after"
# require "./examples/browser"
# require "./examples/audio"
# require "./examples/fit"
# require "./examples/table"
# require "./examples/matrix"
# require "./examples/atome_converter/atome_converted"
# require "./examples/atome_converter/file_converted"
# require "./examples/above_below_before_after"
# require "./examples/test"
# require "./examples/file"
# require "./examples/read"
# require "./examples/test"

# wait 2 do
#
# end

# require "./examples/site"

# require "./examples/find"
# require "./examples/tools"
# require "./examples/audio"
# require "./examples/recorder"
# require "./examples/above_below_before_after.rb"
# require "./examples/hypertext"
# require "./examples/rotate"
# require "./examples/remove"
# require "./examples/text_align"
# require "./examples/b64_to_image"
# require "./examples/svg_img_to_vector"
# require "./examples/svg_vectoriser"
# require "./examples/smooth"
# require "./examples/categories"
# require "./examples/atome_particle_validation"
# require "./examples/database_handling"
# require "./examples/read"
# require "./examples/unit"
# Définir temp_logs comme une variable globale dans l'environnement JavaScript
# Solution 1 : Mettre le push dans le wait

# A.view_logs = []

# A.view_logs = []
#
# def add_to_view_logs(params)
#   A.view_logs.push params
# end
#
# def get_logs
#   alert A.view_logs
# end

# Redéfinition de console.log
# JS.eval("
#   const originalConsoleLog = console.log;
#   console.log = function(...args) {
#     Opal.A.$add_to_view_logs(args.join(' '));
#     originalConsoleLog.apply(console, args);
#   };
# ")
# alert(get_logs)

# print "jhgjhgjh"
# puts "hi the"

# Vérification des logs

# get_logs
# js_func(:get_logs, :super)

# Projects
# require "./examples/encrypt"
# require './works/vie'
# require './works/photos'
# require './works/photos6'
# require './test'
# require './examples/test'
# require './examples/read_write_terminal'
# require './examples/terminal'
#
# require '/src/medias/utils/examples/particles/align/example.rb'
#
#### works
# require "./examples/link"
# require "./examples/svg_vectoriser"
# require "./examples/holder"
# require "./examples/input"
# require "./examples/server"
# require "./examples/list"
# require "./examples/behavior"
# require "./examples/tick"
# require "./examples/localstorage"
# require "./examples/allow_system_right_click"
# require "./examples/sliders"
# require "./examples/alternate"
# require "./examples/executor"
# # require "./examples/allow_copy"
# require "./examples/tools"
# require "./examples/opacity"
# require "./examples/fill"
# require "./examples/sub_atome_manipulation"
# # require "./examples/increment"
# require "./examples/matrix"
# require "./examples/vector"
# require "./examples/fonts"
# require "./examples/aid"

# require "./examples/remove"
# require "./examples/delete"
# require "./examples/border"
# require "./examples/clones&monitoring"
# require "./examples/on_the_fly_ruby_code_loading"
# require './examples/css'
# require "./examples/help"
# require "./examples/example"
# require "./examples/unit"
# require "./examples/int8"
# require "./examples/retreive"
# require "./examples/center"
# require "./examples/atomizer"
# require "./examples/size"
# require "./examples/fit"
# require "./examples/infos"
# require "./examples/compute"
# require "./examples/dig"
# require "./examples/import"
# require "./examples/shortcut"
# require "./examples/server"
# require "./examples/console"
# require "./examples/layout"
# require "./examples/random"
# require "./examples/find"
# require "./examples/copy"
# require "./examples/selected"
# require "./examples/category"
# require "./examples/categories"
# require "./examples/duplicate"
# require "./examples/repeat"
# require "./examples/group"
# require "./examples/affect"
# require "./examples/apply"
# require "./examples/paint"
# require "./examples/gradient"
# require "./examples/shadow"
# require "./examples/blur"
# require "./examples/raw_html"
# require "./examples/vector"
# require "./examples/basic_understanding"
# require "./examples/preset"
# require "./examples/hierarchy"
# require "./examples/callback"
# require "./examples/convert"
# require "./examples/play"
# require "./examples/animation"
# require "./examples/file"
# require "./examples/select_text"
# require "./examples/edit"
# require "./examples/on_resize"
# require "./examples/keyboard"
# require "./examples/tagged"
# require "./examples/color"
# require "./examples/security"
# require "./examples/sync"
# require "./examples/refresh"
# require "./examples/type_mutation"
# require "./examples/smooth"
# require "./examples/history"
# require "./examples/image"
# require "./examples/preset"
# require "./examples/clear"
# require "./examples/fasten"
# require "./examples/attach"
# require "./examples/grab"
# require "./examples/match"
# require "./examples/video"
# require "./examples/login"
# require "./examples/scheduler"
# require "./examples/applications"
# require "./examples/drop_down_list"
# require "./examples/to_px"
# require "./examples/grip"
# require "./examples/blocks"
# require "./examples/flash"
# require "./examples/schedule"
# require "./examples/to_percent"
# require "./examples/account"
# require "./examples/tools"
# require "./examples/buttons"
# require "./examples/actor&role"
# require "./examples/delete"
# require "./examples/detach"
# require "./examples/unfasten"
# require "./examples/attach"
# require "./examples/alternate"
# TODO:  TO FINISH
# require "./examples/trigger_abstraction"
# require "./examples/editor"
# require "./examples/inspector"
# require "./examples/calendar"
# require "./examples/timeline"
# require "./examples/chronology"
# require "./examples/media_audio_thumbnail"
# require "./examples/media_video_thumbnail"
# require "./examples/midi"
# require "./examples/recorder"
# require "./examples/intuition"
# circle

# require "./examples/tools"

# require "./examples/map"
# require "./examples/meteo"
# require "./examples/vr"

# require "./examples/audio"
#

# require "./examples/test"
# require "./examples/exchange"

# require "./examples/touch" # passed
# require "./examples/over" # passed
# require "./examples/resize" # passed
# require "./examples/drag" # passed
# require "./examples/drop" # passed
# require "./examples/overflow" # passed

# require "./examples/test"
# require "./examples/repeat"
# require "./examples/touch"
# require "./examples/delete"
# require "./examples/target"
# require "./examples/run"
# require "./examples/sliders"
# wait 2 do

# end
# Native tests #
# require "./examples/browse"
# require "./examples/read"
#
############# problem solved below
# require "./examples/browse"
# require "./examples/terminal"
# require "./examples/read"

# require "./examples/server"
############# problem above

# #server tests

# end test
# puts('Connected to WebSocket.')
# require './web2'
# require File.expand_path('../examples/shadow.rb', __FILE__)
# require File.expand_path('../web2.rb', __FILE__)
# alert "==> #{Atome.aui}"
# require '../experimental/scroll'
# # https://github.com/travist/jsencrypt
# def generator(params)
#   default_styles={type: :shape,  renderers: [:html],width: 66, height: 66}
#   style=default_styles.merge(params[:style])
#   Atome.new(type: params[:type], id: :params_id,renderers: [:html])
#
# end

############################
# alert grab(:view).atome[:id]
###########################
# TODO: check that atome gem build correctly the solution
# TODO: change atomic repository so that it install atome gem correctly
# TODO : find a way to unbind a specific event
# TODO : animation
# done : shadow
# done : drop
# TODO : matrix/grid
# TODO : gradient
# TODO : multiple shadows
# TODO : automatise shadows api add auto id and make 'affect' optional
# done : implement scroll / on overflow
# TODO : markup to allow after creation changes
# TODO : Drag and Drop file import
# TODO : change particle_code for {code:{particle: :data_code}}
# TODO : rename HTML class and html objetc to Browser
# new(particle: :language)
# new(particle: :international)
# new(particle: :state)
# new(particle: :role)
# new(particle: :symbol)
# new(particle: :row)
# new(particle: :column)
# new(particle: :ratio)
# new(particle: :margin)
# require './web2'
#
# # Layout
# grab(:view).language(:french)
# default_color = grab(:view).default_values[:back_color]
# default_color
# delices = new({ site: { id: :les_delices_de_vezelin, separator: { height: -30 } } })
# delices.new({ page: { id: :home } })
#
# article_1 = <<STR
# A Chamaliéres, un espace de travail de 450M2, sur deux étages, mis à votre disposition pour créer developper et rayonner!
# STR
#
# delices.new({ article: {
#   background:{path: "medias/images/deco.png"},
#   my_article: { location: 0, type: :video, path: "medias/videos/Equinoxe_ext.mp4", automatic: { play: true } },
#   pix_info: { location: 1, type: :content, data: article_1, color: :black,width: '96%',height: '100%' , visual: { size: 18 }, center: true },
#   pix_inf: { location: 1, type: :color, red: 1, green: 1, blue: 1 },
#   # pix_style: { location: 1, type: :style,shadow: { blur: 9, alpha: 0.25 }, smooth: [18, 2, 69]},
#   pix_style: { location: 1, type: :style, smooth: [18, 2, 69] },
#   color: { location: 1, type: :color }.merge(default_color),
#   pages: [:home],
#   template: { row: 1, column: 2, ratio: 0.5, margin: 12 },
# } })
#

# frozen_string_literal: true

# m=matrix({  id: :my_table, left: 330, top: 0, width: 500, height: 399, smooth: 8, color: :yellowgreen,
#             cells: {
#               particles: { margin: 9, color: :red, smooth: 9, shadow: { blur: 9, left: 3, top: 3,id: :cell_shadow } }
#             }
#          })

# m.cells do |el|
#   group(el)
#   group.color(:white).rotate(22).text(:hello)
# end
#
# m.cells(["my_table_2", 9, "my_table_5"]) do |el|
#   group(el)
#   group.color(:red).rotate(33)
# end
#

# new({ atome: :matrix })
# new({ particle: :cells })
#
#
# m=matrix({  id: :the_m, width: :auto, left: 130, top: 0, right: 100, height: 399, smooth: 8, color: :yellowgreen,
#             cells: {
#               particles: { margin: 9, color: :red, smooth: 9, shadow: { blur: 9, left: 3, top: 3,id: :cell_shadow } }
#             }
#          })

#

# m=text({data: :hello, edit: true})
# m.drag(true)
# m.on(:resize) do |event|
#   puts event[:dx]
# end
# m.resize(true) do |event|
#   puts event
# end

# s=shape({})
# m=matrix({})
# alert s.inspect
# alert m.inspect
# m.structure()
# m = matrix({ width: :auto, left: 130, top: 0, right: 100, height: 399, smooth: 8, color: :green })
# wait 2 do
#   m.width(123)
#   # puts "final width is : #{m.width}"
# end

# mm.cells do |el|
#   group(el)
#   group.color(:yellowgreen).rotate(33)
# end
#
#
#
# mm.cells.each do |el|
#   el_found=grab(el)
#   el_found.rotate(22).text(:hello).color(:red)
# end

# wait 1 do
#   A.message({action: :insert, data: {table: :atome, particle: :width, data: 888}}) do |msg|
#
#     puts msg
#   end
# end

########################
# text({ id: :the_text,data: 'Touch me to group and colorize', center: true, top: 120, width: 77, component: { size: 11 } })
# box({ left: 12, id: :the_first_box })
# the_circle = circle({ id: :cc, color: :yellowgreen, top: 222 })
# the_circle.image({path:  'medias/images/red_planet.png', id: :the__red_planet })
# the_circle.color('red')
# the_circle.box({ left: 333, id: :the_c })
#
# element({ id: :the_element })
#
# the_view = grab(:view)
#
# color({ id: :the_orange, red: 1, green: 0.4 })
# color({ id: :the_lemon, red: 1, green: 1 })
# the_group = group({ collect: the_view.shape })
#
# wait 0.5 do
#   the_group.left(633)
#   wait 0.5 do
#     the_group.rotate(23)
#     wait 0.5 do
#       the_group.apply([:the_orange])
#       the_group.blur(6)
#     end
#   end
# end
# puts the_group.collect
# grab(:the_first_box).smooth(9)
# grab(:the_text).touch(true) do
#   bibi=box({left: 555})
#   the_group2= group({ collect: [:the_c,:the_first_box, :the_text, :cc , bibi.id] })
#   the_group2.top(55)
#   # puts we remove the circle(:cc) so it' wont be affected by the color :the_lemon
#   the_group2.collect.delete( :cc )
#   the_group2.apply([:the_lemon])
#
# end

#######################

# page1_code = lambda do |back|
#   alert :kool
# end
# # b=box
# # b.touch(:true) do
# #   alert :lll
# # end
# c=circle
# c.touch(true) do
#   b=box({ id: :mod_1,left: 333, touch: {tap: true, code: page1_code} })
#   alert b.touch
#   wait 3 do
#     grab(:mod_1).delete({recursive: true})
#   end
# end
################

# action=lambda do |_var|
#   grab(:testing).color(:red)
#   puts '=====+>'
#     grab(:testing).delete({recursive: true})
# end
#
#
# c=circle({id: :th_c})
# c.touch(true) do
#   b=box({id: :testing, left: 99})
#   b.circle({left: 33, id: :sec_circle})
#   b.touch({ tap: true , code: action})
#   # action=nil
# end
# ##################@
# b=box
# b.drag(true) do
#   puts "kjhj"
# end
# b.touch(:long) do
#   b.drag(false)
# end

# c=circle({id: :titi})
# c.touch(true) do
#   box({left: 33, id: :toto})
# end
# if  grab(:titi)
#   alert :no
# end





