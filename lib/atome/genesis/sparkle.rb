# # frozen_string_literal: true
#
# # let's create the Universe
# def eval_protection
#   binding
# end
#
# # Let's set the default's parameters according to ruby interpreter
# if RUBY_ENGINE.downcase == 'opal'
#   Essentials.new_default_params({ render_engines: [:html] })
# else
#   Essentials.new_default_params({ render_engines: [:headless] })
#   eval "require 'atome/extensions/geolocation'", eval_protection, __FILE__, __LINE__
#   eval "require 'atome/extensions/ping'", eval_protection, __FILE__, __LINE__
#   eval "require 'atome/extensions/sha'", eval_protection, __FILE__, __LINE__
# end
#
# # now let's get the default render engine
# default_render = Essentials.default_params[:render_engines]
#
#
# def atome_infos
#   puts "atome version: #{Atome::VERSION}"
#   # puts "application identity: #{Universe.app_identity}"
#   puts "application identity:  #{Atome::aui}"
#   # puts "application mode:  #{Atome.mode}"
#   puts "host framework:  #{$host}"
#   puts "script mode: #{Universe.current_machine}"
#   puts "user: #{Universe.current_user}"
#   puts "server: #{Universe.current_server}"
# end
#
# Universe.current_user = :jeezs
#
#
# atome_infos
#
# Atome.new(
#   { element: { renderers: [], id: :eDen, type: :element , tag: { system: true } } }
# )
#
# Atome.new(
#   { element: { renderers: [], id: :user_view, type: :element, tag: { system: true },
# attach: [:eDen] } }
# )
#
# # color creation
# Atome.new(
#   { color: { renderers: default_render, id: :view_color, type: :color,tag: ({ system: true,persistent: true }),
#              red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } }
# )
#
# Atome.new(
#   { color: { renderers: default_render, id: :shape_color, type: :color,tag: ({ system: true,persistent: true }),
#              red: 0.4, green: 0.4, blue: 0.4, alpha: 1 } }
# )
#
# Atome.new(
#   { color: { renderers: default_render, id: :box_color, type: :color,tag: ({ system: true,persistent: true }),
#              red: 0.5, green: 0.5, blue: 0.5, alpha: 1 } }
# )
#
# Atome.new(
#   { color: { renderers: default_render, id: :invisible_color, type: :color,tag: ({ system: true,persistent: true }),
#              red: 0, green: 0, blue: 0, alpha: 1 } }
# )
#
# Atome.new(
#   { color: { renderers: default_render, id: :text_color, type: :color,tag: ({ system: true,persistent: true }),
#              red: 0.3, green: 0.3, blue: 0.3, alpha: 1 } }
# )
#
# Atome.new(
#   { color: { renderers: default_render, id: :circle_color, type: :color,tag: ({ system: true,persistent: true }),
#              red: 0.6, green: 0.6, blue: 0.6, alpha: 1 } }
# )
#
# Atome.new(
#
#   { color: { renderers: default_render, id: :matrix_color, type: :color,tag: ({ system: true,persistent: true }),
#              left: 0, top: 0, red: 0.7, green: 0.7, blue: 0.7, alpha: 1, diffusion: :linear } }
# )
#
# # system object creation
# # the black_matter is used to store un materialized atomes
# Atome.new(
#   { shape: { renderers: default_render, id: :black_matter, type: :shape, attach: [:user_view],
#              left: 0, right: 0, top: 0, bottom: 0, width: 0, height: 0, overflow: :hidden, tag: { system: true }
#   } })
#
# # view port
# Atome.new(
#   { shape: { renderers: default_render, id: :view, type: :shape, attach: [:user_view], tag: { system: true },
#              attached: :view_color, left: 0, right: 0, top: 0, bottom: 0, width: :auto, height: :auto, overflow: :auto,
#   }
#   }
# )
#
# #unreal port
# Atome.new(
#   { shape: { renderers: default_render, id: :intuition, type: :shape, attach: [:user_view], tag: { system: true },
#              left: 0,  top: 0, width: 0, height: 0, overflow: :visible,
#   }
#   }
# )
#
# # init basic object for atome environment
#
# # Atome.new is used to create a new atome using best performances but params must be formatted and ordered correctly
#
# # use atome.atome to create a new atome using a more permissive syntax less performances but params must be formatted
# # and ordered correctly
#
# # Atome.atome ids the easiest way to  create a new atome
# # Atome.atome({
# #                      shape: { left: 0, right: 0, top: 0, bottom: 0, id: :view, color: { id: :c1, render: [:headless],
# # red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } } })
#
# # WARNING: when using Atome.new syntax , you must get your object using the .atome
# # example  to get the atome above : use a.shape.left and not a.left it wont access the physical object
# # initialize Universe


# now let's get the default render engine

def atome_infos
  puts "atome version: #{Atome::VERSION}"
  puts "device identity: #{Universe.app_identity}"
  # puts "application identity: #{Atome::aui}"
  # puts "application mode: #{Atome.mode}"
  puts "host framework: #{$host}"
  puts "script mode: #{Universe.current_machine}"
  puts "user: #{Universe.current_user}"
  puts "server: #{Universe.current_server}"
end

Universe.current_user = :jeezs

atome_infos



########################################################

############## Lets create the U.I.

default_render = Essentials.default_params[:render_engines]
Atome.new(
  { renderers: [], id: :eDen, type: :element, tag: { system: true }, attach: [], attached: [] }
)
Atome.new(
  { renderers: [], id: :user_view, type: :element, tag: { system: true },
    attach: [:eDen], attached: [] }
)

# color creation
Atome.new(
  { renderers: default_render, id: :view_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.15, green: 0.15, blue: 0.15, alpha: 1, top: 12, left: 12, diffusion: :linear, attach: [], attached: [] }
)

Atome.new(
  { renderers: default_render, id: :shape_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.4, green: 0.4, blue: 0.4, alpha: 1, attach: [], attached: [] }
)

Atome.new(
  { renderers: default_render, id: :box_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.5, green: 0.5, blue: 0.5, alpha: 1, attach: [], attached: [] }
)

Atome.new(
  { renderers: default_render, id: :invisible_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0, green: 0, blue: 0, alpha: 1, attach: [], attached: [] }
)

Atome.new(
  { renderers: default_render, id: :text_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.9, green: 0.9, blue: 0.9, alpha: 1, attach: [], attached: [] }
)

Atome.new(
  { renderers: default_render, id: :circle_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.6, green: 0.6, blue: 0.6, alpha: 1, attach: [], attached: [] }
)
# system object creation
# the black_matter is used to store un materialized atomes
Atome.new(
  { renderers: default_render, id: :black_matter, type: :shape, attach: [:user_view],
    left: 0, right: 0, top: 0, bottom: 0, width: 0, height: 0, overflow: :hidden, tag: { system: true }, attached: []
  })

# view port
Atome.new(
  { renderers: default_render, id: :view, type: :shape, attach: [:user_view], apply: [:view_color],
    tag: { system: true },
    attached: [], left: 0, right: 0, top: 0, bottom: 0, width: :auto, height: :auto, overflow: :auto,
  }

)

# unreal port
Atome.new(
  { renderers: default_render, id: :intuition, type: :shape, attach: [:user_view], tag: { system: true },
    left: 0, top: 0, width: 0, height: 0, overflow: :visible, attached: []

  }
)

############ user objects ######

# s_c = grab(:shape_color)
#
# # Atome.new(
# #   { renderers: default_render, id: :my_test_box, type: :shape, width: 100, height: 100, attach: [:view],
# #     left: 120, top: 0, apply: [:shape_color],attached: []
# #   }
# # )
# # a = Atome.new(
# #   { renderers: default_render, id: :my_test_box, type: :shape, attach: [:view], apply: [:shape_color],
# #     left: 120, top: 0, width: 100, height: 100, overflow: :visible, attached: []
# #   }
# #
# # )
# a = Atome.new(
#   { renderers: default_render, id: :my_shape, type: :shape, attach: [:view], apply: [:shape_color],
#     left: 120, top: 0, width: 100, height: 100, overflow: :visible, attached: []
#   }
#
# )
#

# s_c.red(0.2)
# s_c.blue(0)
# s_c.green(0)
# a.top(99)
# aa.unit[:width] = "%"
# aa.width(88)
# a.smooth(33)
# a.web({ tag: :span })
# aa.smooth(9)
# # FIXME:  add apply to targeted shape, ad affect to color applied
# # box
# # circle
# # text(:hello)
# # Atome.new({  :type => :shape, :width => 99, id: :my_id, :height => 99, :apply => [:box_color], :attach => [:view],
# # :left => 300, :top => 100, :clones => [], :preset => :box, :id => "box_12", :renderers => [:html] })
# aa.unit[:left] = :inch
# aa.unit({ top: :px })
# aa.unit({ bottom: '%' })
# aa.unit[:bottom] = :cm
# aa.unit[:right] = :inch
# aa.unit[:top] = :px
# puts " unit for aa is : #{aa.unit}"
#
# # new({ atome: :poil })
# # new({ atome: :poil })
# # poil(:data)
# # piol
#
# # new({ renderer: :html, method: :text, type: :hash }) do |value, _user_proc|
# #   alert value
# # end
# # ###################### uncomment below
# Atome.new(
#   { renderers: default_render, id: :my_txt, type: :text, width: 100, height: 100, attach: [:my_shape],
#     data: "too much cool for me", apply: [:text_color], attached: []
#   }
# )
#





