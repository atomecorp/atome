#  frozen_string_literal: true

# require './examples/keyboard'
# require '../experimental/scroll'
# https://github.com/travist/jsencrypt

# TODO : debug code below:

# TODO: check that atome gem build correctly the solution
# TODO: change atomic repository so that it install atome gem correctly
# TODO : add onscroll event
# TODO : find a way to unbind a specific event



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
# new({atome: :poilu})
new({ atome: :matrix })
new({ particle: :cells })

# m=matrix({  id: :the_m, width: :auto, left: 130, top: 0, right: 100, height: 399, smooth: 8, color: :yellowgreen,
#             cells: {
#               particles: { margin: 9, color: :red, smooth: 9, shadow: { blur: 9, left: 3, top: 3,id: :cell_shadow } }
#             }
#          })
# m.structure()
matrix({ width: :auto, left: 130, top: 0, right: 100, height: 399, smooth: 8, color: :green })

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


