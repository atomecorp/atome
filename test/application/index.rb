#  frozen_string_literal: true

# require "./examples/debug"

# make it works
# require "./examples/generator_and_build"
# require "./examples/display"

# TODO : remove backtick in lib/platform_specific/opal/extensions/js.rb :  result = `eval(#{clean_str})`

# require "./web2"
# alert Universe.eVe

# in progress
# require "./examples/find"
# require "./examples/test"
# require "./examples/categories"
# require "./examples/atome_particle_validation"
# require "./examples/database_handling"
# require "./examples/server"
# require "./examples/read"
# require "./examples/unit"


# Projects
# require "./examples/encrypt"
# require './works/vie'
# require './works/photos'
# require './works/photos6'
# require './test'
# require './examples/test'

#### works
# require "./examples/clones&monitoring"
# require './examples/css'
# require "./examples/help"
# require "./examples/example"
# require "./examples/unit"
# require "./examples/int8"
# require "./examples/center"
# require "./examples/atomizer"
# require "./examples/table"
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
# require "./examples/remove"
# require "./examples/shadow"
# require "./examples/raw_html"
# require "./examples/vector"
# require "./examples/basic_understanding"
# require "./examples/preset"
# require "./examples/hierarchy"
# require "./examples/callback"
# require "./examples/convert"
# require "./examples/touch"
# require "./examples/drag"
# require "./examples/over"
# require "./examples/play"
# require "./examples/animation"
# require "./examples/resize"
# require "./examples/drop"
# require "./examples/file"
# require "./examples/select_text"
# require "./examples/edit"
# require "./examples/on_resize"
# require "./examples/keyboard"
# require "./examples/hypertext"
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
# require "./examples/delete"
# require "./examples/clear"
# require "./examples/attached"
# require "./examples/attach"
# require "./examples/grab"
# require "./examples/match"
# require "./examples/scroll"
# require "./examples/video"

# Native tests #
# require "./examples/browse"
# require "./examples/read"
# require "./examples/terminal"

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
#   Atome.new(type: params[:type], id: :tutu,renderers: [:html])
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

