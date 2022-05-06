require 'net/ping'
require '../lib/atome.rb'

# interpreter = RUBY_ENGINE.downcase
# # puts interpreter
# platform = RUBY_PLATFORM.downcase
# Atome.set_current_user(:jeezs)
# # box({ render: :headless })
#
# # a = Atome.new({ type: :shape, render: false, engine: :speech, preset: :box, id: :the_boxy,
# #                 atome: { type: :child, dynamic: true },
# #                 # atome: {type: :top, id: :a_09865653 } ,
# #                 color: :red })
# #
# # puts "a is #{a}"
# # puts "a is also #{a.inspect}"
# # puts "left is : #{a.left(33)}"
# # puts "atomes are : #{Universe.atomes}"
# #
# # atome_simplified_hash_struct = { a_001: { color: { value: :red, diffusion: :radial },
# #                                           a_656: { x: { value: 66 } } } }
# #
# # # box with simple gradient example
# # b = Atome.new({ shape: [value: "67,98,556,98"], color: [:red, :yellow] })
# #
# # Atome.new({ type: :shape, preset: :box, id: [:the_big_box, :the_circle],
# #             atome: { type: :child, id: :my_obj_id, dynamic: true },
# #             # atome: {type: :top, id: :a_09865653 } ,
# #             color: :red })
# #
# # b = { a_6576: { shape: { value: "67,98,556,98" } },
# #       a_9876: { color: { value: :red, diffusion: :radial } },
# #       a_9879: { color: { value: :yellow, diffusion: :radial } }
# # }
# #
# # atome_max_simplified_hash_struct = { a_001: { color: :red, x: 33 }, # problem : how to know where is the type in a Hash
# #                                      a_656: { x: 66, reference: 66 }
# # }
# #
# # atome_hash_struct = { a_001: { a_684: { type: :color, value: :red, diffusion: :radial },
# #                                a_656: { type: :x, value: 66 } } }
# #
# # # gradient ex :
# #
# # { a_7665: { color: { a_9876: { value: :red, x: 33, y: 66, diffusion: :radial },
# #                      a_9879: { atome: :a_9879, x: 99, y: 33, diffusion: :linear }
# # }
# # }
# # }
# #
# # # # ex of particle/style:
# # # particle={a_86545: {value: :red}}
# # # # usage as particle as style or content
# # # a.color(style)
# # # a.text(style)
# #
# # # # get val :
# # #  atome_struct_is[:id].each do |key, val|
# # #    puts val[:value]
# # #  end
# # #
# # # # get id :
# # #  atome_struct_is[:id].each do |key, val|
# # #    puts key
# # #  end
# #
# # # this structure is chosen because it avoid an a different structure for @atomes and @atome and oroperties
# # # The hash structure is also much faster when finding an atome in the Universe.atomes
# # #########
# #
# # # atome_array_struct ={id:[{value: :toto, x: 33}, {value: :titi, x: 456}]}
# #
# # # # get val :
# # #  atome_struct_is[:id].each  do |hash|
# # #    puts hash[:value]
# # # end
# #
# # # # get id :
# # #  atome_struct_is[:id].each  do |hash|
# # #    puts hash[:id]
# # # end
# #
# # # ################ test 2 #############
# #
# # a = Atome.new(
# #   { my_atome: {
# #     type: {
# #       a_0_id: { shape: [0, 56, 77, 0] } },
# #     color: {
# #       a_1_id: { red: 0.9, green: 0.3, blue: 0.6, alpha: 1, diffusion: :radial, x: 0, y: 0 },
# #       a_2_id: { red: 0.3, green: 0.9, blue: 0.9, alpha: 0.3, diffusion: :linear, x: 333, y: 333 }
# #     },
# #     position: {
# #       a_3_id: { x: 9, y: 9 } },
# #     size: {
# #       a4_id: { width: 333, height: 333 } }
# #   }
# #   }
# # )
# #
# # puts "********"
# # puts a.inspect
# # # b = box()
# # #
# # # b.color(:red)
# # puts "********"
# # puts Universe.atomes
#
#
# # ################ test 3 #############
# # At loading time eVe reserve 100 number for future user number : find a solution if the app is loaded from the app store how can we allocate numbers?
# # aui : atome uniq Identifier =>
# # creatorNumber_machineNumber_userNumber
# # creatorNumber = 000000000 if eVe
# # machineNumber= mac address if app or local server or online server address is create from web browser
#
# # aui is atome uniq identity
# # it is define as follow:
# # parentCreatorID_softwareinstanceID_objetID
#
#
# # Protected, read only and uniq atome is atome identity :  this not the aui !
# # the identity atome contain creator id, time of creation, location of creation and the machine or software onto the atome is created
#
# # 3 types of object :
# # pure atome, ex: {x:30}
# # complex structure, ex : {position:{x: 33, y: 33}}
# # liked atome (clone), ex : x: {clone: :aui}
#
# # puts "current user is : #{Atome.current_user}"
#
#
# puts "********"
# puts Universe.atomes
#
# # todo create the full init sequence with temporary input box and db save if needed to create an user iD
#
# # ********* solution validated 02 05 2022 : *********
#
# # Full Mode :
# a = Atome.new(
#   type: [{ value: :shape }],
#   shape: [{ value: [0, 56, 77, 0] }],
#   preset: [{ value: :box }],
#   color: [{ value: :orange },
#           { red: [{ value: 0.9 }], green: [{ value: 0.3 }], blue: [{ value: 0.6 }], alpha: [{ value: 1 }], diffusion: [{ value: :radial }], x: [{ value: 0 }], y: [{ value: 0 }] },
#           { clone: [{get: [{ value: :color }],id: [{ value: :aui }], dynamic: [{value: true}]}]}
#
#   ],
#   position: [{ x: [{ value: 9 }], y: [{ value: 9 }] }],
#   size: [{ width: [{ value: 333 }], height: [{ value: 333 }] }],
#   id: [{value: :my_box}],
#   x: [{ value: 666 }]
# )
#
# a.position( [{ x: [{ value: 99 }], y: [{ value: 3 }] }])
#
# # easy mode:
#
# a=box({color:[:orange,{red:0.9, green: 0.3, blue: 0.6}]}, x: 9, y: 9, width: 333, height: 333, id: :my_box)
# a.x(99).y(3)
#
# # 3 kind of atomes :
#
#
#
#
#

# def up?(host)
#   check = Net::Ping::External.new(host)
#   check.ping?
# end
#
# chost = 'google.com'
# puts up?(chost) # prints "true" if ping replies

require 'faye/websocket'
require 'json'

EM.run {
  websocket = Faye::WebSocket::Client.new('ws://127.0.0.1:9292/')
  websocket.on :open do |event|
    p [:websocket_opened]
    my_msg={ kool: "hyper" }
    my_msg=JSON.generate(my_msg)
    websocket.send(my_msg)
  end

  websocket.on :message do |event|
    p [event.data]
  end

  websocket.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}
