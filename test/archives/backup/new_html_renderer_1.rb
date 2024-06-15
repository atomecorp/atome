
######## tests
class HTML
  def initialize(id)
    @html_object = `document.getElementById(#{id})`
    @id = id
    self
  end

  def attr(attribute, value)
    `#{@html_object}.setAttribute(#{attribute}, #{value})`
  end

  def add_class(class_to_add)
    `#{@html_object}.classList.add(#{class_to_add})`
  end

  def id(id)
    attr('id', id)
  end

  def shape(id)
    @html_type = :div
    @html_object = `document.createElement("div")`
    `document.getElementById('user_view').appendChild(#{@html_object})`
    id(id)
  end

  def style(property, value)
    `#{@html_object}.style[#{property}] = #{value}` if property
    self
  end

  def filter= values
    property = values[0]
    value = values[1]
    `#{@html_object}.style.filter = #{property}+'('+#{value}+')'`
  end
end

class Atome
  # attr_accessor :html_object

  def html
    @html_object = HTML.new(id)
  end

  def to_px
    id_found = real_atome[:id]
    property_found = property
    value_get = ''
    `
      div = document.getElementById(#{id_found});
      var style = window.getComputedStyle(div);
      var original_value = style.getPropertyValue(#{property_found});
      #{value_get}= parseInt(original_value);
    `
    value_get
  end
end

class Atome
  particle_list_found = Universe.particle_list.keys
  particle_list_found.each do |the_particle|
    define_method("inspect_#{the_particle}") do |params, &bloc|
      puts "=> inspect element: #{the_particle}\nparams : #{params}\nbloc: #{bloc}\n"
    end
  end
end

def atome_js
  `atomeJS`
end

new({ html: :type, type: :string}) do |_value, _user_proc|
  # html.shape(@atome[:id])
end

new({ html: :type, type: :string, exclusive: :shape }) do |_value, _user_proc|
  html.shape(@atome[:id])
end

new({ html: :width, type: :string, exclusive: :shape }) do |value, _user_proc|
  html.style(:width, "#{value}px")
end

new({ html: :height, type: :string }) do |value, _user_proc|
  html.style(:height, "#{value}px")
end

new({ html: :smooth, type: :string }) do |value, _user_proc|
  # html.style(:height, "#{value}px")
  format_params = case value
                  when Array
                    properties = []
                    value.each do |param|
                      properties << "#{param}px"
                    end
                    properties.join(' ').to_s
                  when Integer
                    "#{value}px"
                  else
                    value
                  end
  html.style('border-radius', format_params)
  # @browser_object.style['border-radius'] = format_params
end
###################### those methods won't be called anymore #####################
# new({ html: :fasten, type: :string }) do |value, _user_proc| # affixed
#   # html.style(:height, "#{value}px")
#   # we have to use attach instead because we must know the type of the object fasten (color/shape => div/style )
#   alert "all fasten : #{value}"
#
#   # grab(value)
#   # html.appendChild(value)
#   # maDiv.appendChild(monSVG);
# end
#
# new({ html: :fasten, type: :string, exclusive: :color }) do |value, _user_proc| # affixed
#   # html.style(:height, "#{value}px")
#   alert "color fasten is : #{value}"
#   # html.appendChild(value)
#   # maDiv.appendChild(monSVG);
# end
###################### those methods won't be called anymore #####################

new({ html: :attach, type: :string }) do |value, _user_proc|
  puts "===+-> attach any type to parent : #{value} class: #{value.class} , child : #{id}"
  # html.appendTo(value)
  # appendTo
end

# new({ html: :attach, type: :string, exclusive: :color }) do |value, _user_proc|
#   # alert "attach color to: #{value}"
#   # html.appendTo(value)
#   # appendTo
# end

new({ html: :left, type: :string }) do |value, _user_proc|
  # html.style(:left, "#{value}px")
end

new({ html: :right, type: :string }) do |value, _user_proc|
  # html.style(:left, "#{value}px")
end

new({ html: :top, type: :string }) do |_value, _user_proc|

end

new({ html: :bottom, type: :string }) do |_value, _user_proc|

end

new({ html: :clones, type: :string }) do |_value, _user_proc|

end

new({ html: :overflow, type: :string })

new({ html: :preset, type: :string })

new({ html: :id, type: :string })

new({ html: :renderers, type: :string })

new({ html: :diffusion, type: :string })

# alert :pass_0



######### data tests
# frozen_string_literal: true

# let's create the Universe
def eval_protection
  binding
end

# Let's set the default's parameters according to ruby interpreter
if RUBY_ENGINE.downcase == 'opal'
  Essentials.new_default_params({ render_engines: [:html] })
else
  alert "RUBY_ENGINE is : #{RUBY_ENGINE.downcase}"
  # Essentials.new_default_params({ render_engines: [:headless] })
  # eval "require 'atome/extensions/geolocation'", eval_protection, __FILE__, __LINE__
  # eval "require 'atome/extensions/ping'", eval_protection, __FILE__, __LINE__
  # eval "require 'atome/extensions/sha'", eval_protection, __FILE__, __LINE__
end

# now let's get the default render engine
default_render = Essentials.default_params[:render_engines]
# default_render=[:browser]

def atome_infos
  puts "atome version: #{Atome::VERSION}"
  # puts "application identity: #{Universe.app_identity}"
  # puts "application identity:  #{Atome::aui}"
  # puts "application mode:  #{Atome.mode}"
  puts "host framework:  #{$host}"
  puts "script mode: #{Universe.current_machine}"
  puts "user: #{Universe.current_user}"
  puts "server: #{Universe.current_server}"
end

Universe.current_user = :jeezs


atome_infos

Atome.new(
  { element: { renderers: [], id: :eDen, type: :element , tag: { system: true }, attach: [], fasten: [] } }
)

Atome.new(
  { element: { renderers: [], id: :user_view, type: :element, tag: { system: true },
               attach: [:eDen], fasten: [] } }
)

# color creation
Atome.new(
  { color: { renderers: default_render, id: [:view_color], type: :color,tag: ({ system: true,persistent: true }),
             red: 0.15, green: 0.15, blue: 0.15, alpha: 1 }, attach: [], fasten: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :shape_color, type: :color,tag: ({ system: true,persistent: true }),
             red: 0.4, green: 0.4, blue: 0.4, alpha: 1 }, attach: [], fasten: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :box_color, type: :color,tag: ({ system: true,persistent: true }),
             red: 0.5, green: 0.5, blue: 0.5, alpha: 1 }, attach: [], fasten: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :invisible_color, type: :color,tag: ({ system: true,persistent: true }),
             red: 0, green: 0, blue: 0, alpha: 1 }, attach: [], fasten: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :text_color, type: :color,tag: ({ system: true,persistent: true }),
             red: 0.3, green: 0.3, blue: 0.3, alpha: 1 }, attach: [], fasten: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :circle_color, type: :color,tag: ({ system: true,persistent: true }),
             red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }, attach: [], fasten: [] }
)

Atome.new(

  { color: { renderers: default_render, id: :matrix_color, type: :color,tag: ({ system: true,persistent: true }),
             left: 0, top: 0, red: 0.7, green: 0.7, blue: 0.7, alpha: 1, diffusion: :linear }, attach: [], fasten: [] }
)

# system object creation
# the black_matter is used to store un materialized atomes
Atome.new(
  { shape: { renderers: default_render, id: :black_matter, type: :shape, attach: [:user_view],
             left: 0, right: 0, top: 0, bottom: 0, width: 0, height: 0, overflow: :hidden, tag: { system: true },  fasten: []
  } })

# view port
Atome.new(
  { shape: { renderers: default_render, id: :view, type: :shape, attach: [:user_view], tag: { system: true },
             fasten: [:view_color], left: 0, right: 0, top: 0, bottom: 0, width: :auto, height: :auto, overflow: :auto,
  }
  }
)

#unreal port
Atome.new(
  { shape: { renderers: default_render, id: :intuition, type: :shape, attach: [:user_view], tag: { system: true },
             left: 0,  top: 0, width: 0, height: 0, overflow: :visible,  fasten: []
  }
  }
)


# init basic object for atome environment

# Atome.new is used to create a new atome using best performances but params must be formatted and ordered correctly

# use atome.atome to create a new atome using a more permissive syntax less performances but params must be formatted
# and ordered correctly

# Atome.atome ids the easiest way to  create a new atome
# Atome.atome({
#                      shape: { left: 0, right: 0, top: 0, bottom: 0, id: :view, color: { id: :c1, render: [:headless],
# red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } } })

# WARNING: when using Atome.new syntax , you must get your object using the .atome
# example  to get the atome above : use a.shape.left and not a.left it wont access the physical object
# initialize Universe


# ####### now ######
# b=box({id: :big_box, renderers: [:headless, :inspect]})
# # alert "====> #{b.id}"
# # alert :pass_1
# c = circle({ id: :the_circle, left: 333, renderers: [:html] })
# # alert :pass_2
# wait 3 do
#   c.fasten(b.id)
# end

# alert c.respond_to?(:browser_shape_left)
# alert c.respond_to?(:html_shape_left)
# alert Universe.particle_list.keys.length+Universe.atome_list.length





