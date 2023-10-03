######## tests

def attachment_common(children_ids, parents_ids, &user_proc)
  @atome[:attach].concat(parents_ids).uniq!

  if parents_ids.instance_of? Array
    parents_ids=[]
  end
  parents_ids.each do |parent_id|
    grab(parent_id).atome[:attached].concat(children_ids).uniq!
    children_ids.each do |child_id|
      child_found = grab(child_id)
      child_found.render(:attach, parent_id, &user_proc) if child_found
    end
  end

end

new({ particle: :attach, render: false }) do |parents_ids, &user_proc|
  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  children_ids = [id]
  attachment_common(children_ids, parents_ids, &user_proc)
end

new({ particle: :attached, render: false }) do |children_ids, &user_proc|
  # fastened
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  parents_ids = [id]
  # alert "#{children_ids}, #{parents_ids}"
  attachment_common(children_ids, parents_ids, &user_proc)

end
######
# alert :good
class HTML
  def initialize(id_found)

    @html_object ||=JS.global[:document].getElementById(id_found.to_s)

    @id = id_found
    self
  end

  def attr(attribute, value)
    @html_object.setAttribute(attribute.to_s, value.to_s)
    self
  end

  def add_class(class_to_add)

    @html_object[:classList].add(class_to_add)
     self
  end

  def id(id)
    attr('id', id)
    self
  end

  def shape(id)
    @html_type = :div
    @html_object = JS.global[:document].createElement("div")
    JS.global[:document][:body].appendChild(@html_object)
    add_class("atome")

    id(id)
    self
  end

  def style(property, value)
    element_found = JS.global[:document].getElementById(@id.to_s)
    element_found[:style][property] = value.to_s
    self
  end

  def filter= values
    property = values[0]
    value = values[1]
    `#{@html_object}.style.filter = #{property}+'('+#{value}+')'`
  end

  def append_to(parent_id_found)

    parent_found = JS.global[:document].getElementById(parent_id_found.to_s)
    parent_found.appendChild(@html_object)

    self
  end
end

class Atome
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

  def browser_color_renderers(val)
    puts "=> browser_color_renderers: #{val}"
  end
end



def html_colorize_color(red, green, blue, alpha, atome)
  ########################### new code ###########################
  id_found = atome[:id]
  # color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  new_class_content = <<~STR
    .#{id_found} {
    --#{id_found}_r : #{red * 255};
    --#{id_found}_g : #{green * 255};
    --#{id_found}_b : #{blue * 255};
    --#{id_found}_a : #{alpha};
    --#{id_found}_col : rgba(var(--#{id_found}_r ),var(--#{id_found}_g ),var(--#{id_found}_b ),var(--#{id_found}_a ));
    background-color: var(--#{id_found}_col);
    fill: var(--#{id_found}_col);
    stroke: var(--#{id_found}_col);
    }
  STR

  puts "====> new_class_content #{new_class_content}"
  atomic_style = BrowserHelper.browser_document['#atomic_style']
  # atomic_style.text = atomic_style.text.gsub(/\.#{id_found}\s*{.*?}/m, new_class_content)

  regex = /(\.#{id_found}\s*{)([\s\S]*?)(})/m
  atomic_style.text = atomic_style.text.gsub(regex, new_class_content)
end

new({ html: :type, type: :string }) do |_value, _user_proc|
  # html.shape(@atome[:id])
end

new({ html: :type, type: :string, exclusive: :shape }) do |_value, _user_proc|
  html.shape(@atome[:id])
end

new({ html: :width, type: :integer, exclusive: :shape }) do |value, _user_proc|
  html.style(:width, "#{value}px")
end

# new({ html: :colorize_color, type: :integer, exclusive: :color }) do |red, green, blue, alpha, _user_proc|
# # puts "left only for color: #{value}"
# end

def html_colorize_color(red, green, blue, alpha)
  puts "--------- ok it works now!!! ----------"
end

#############
# def colorize_color(red, green, blue, alpha)
# puts "======> temp solution"
# end
new({ html: :left, type: :integer, exclusive: :color })
new({ html: :red, type: :integer, exclusive: :color }) do |value, _user_proc|
  puts "==> red only for color: #{value} - take a look at : browser/helper/color_helper : browser_colorize_color"
  red = (@atome[:red] = value)
  green = @atome[:green]
  blue = @atome[:blue]
  alpha = @atome[:alpha]

  Atome.send("html_colorize_#{@atome[:type]}", red, green, blue, alpha)

  # # color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  # Atome.send("html_colorize_#{@atome[:type]}", red, green, blue, alpha, @atome)
  # # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

new({ html: :green, type: :integer, exclusive: :color }) do |value, _user_proc|
  puts "==> green only for color: #{value}"
end

new({ html: :blue, type: :integer, exclusive: :color }) do |value, _user_proc|
  puts "==> blue only for color: #{value}"
end

new({ html: :alpha, type: :integer, exclusive: :color }) do |value, _user_proc|
  puts "==> alpha only for color: #{value}"
end

# new({ html: :color, type: :integer, exclusive: :color }) do |value, _user_proc|
# alert 'so kool'
# end

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
end

new({ html: :attach, type: :string }) do |parent_found, _user_proc|

  # JS.global[:document][:body].appendChild('user_view')
  html.append_to(parent_found)
end

new({ html: :left, type: :string, exclusive: :shape }) do |value, _user_proc|
  # html.style(:left, "#{value}px")
end

new({ html: :right, type: :string, exclusive: :shape }) do |value, _user_proc|
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

# new({ html: :color, type: :string }) do
# puts "====> yeah"
# end

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
  puts "------- **pas opal** ------"
  Essentials.new_default_params({ render_engines: [:html] })
  # alert "RUBY_ENGINE is : #{RUBY_ENGINE.downcase}"
  # Essentials.new_default_params({ render_engines: [:headless] })
  # eval "require 'atome/extensions/geolocation'", eval_protection, __FILE__, __LINE__
  # eval "require 'atome/extensions/ping'", eval_protection, __FILE__, __LINE__
  # eval "require 'atome/extensions/sha'", eval_protection, __FILE__, __LINE__
end

# now let's get the default render engine
default_render = Essentials.default_params[:render_engines]

def atome_infos
  puts "atome version: #{Atome::VERSION}"
  # puts "application identity: #{Universe.app_identity}"
  # puts "application identity: #{Atome::aui}"
  # puts "application mode: #{Atome.mode}"
  puts "host framework: #{$host}"
  puts "script mode: #{Universe.current_machine}"
  puts "user: #{Universe.current_user}"
  puts "server: #{Universe.current_server}"
end

Universe.current_user = :jeezs

atome_infos

############### Lets create the U.I.
Atome.new(
  { element: { renderers: [], id: :eDen, type: :element, tag: { system: true }, attach: [], attached: [] } }
)

Atome.new(
  { element: { renderers: [], id: :user_view, type: :element, tag: { system: true },
               attach: [:eDen], attached: [] } }
)

# color creation
Atome.new(
  { color: { renderers: default_render, id: [:view_color], type: :color, tag: ({ system: true, persistent: true }),
             red: 0.15, green: 0.15, blue: 0.15, alpha: 1 }, attach: [], attached: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :shape_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0.4, green: 0.4, blue: 0.4, alpha: 1 }, attach: [], attached: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :box_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0.5, green: 0.5, blue: 0.5, alpha: 1 }, attach: [], attached: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :invisible_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0, green: 0, blue: 0, alpha: 1 }, attach: [], attached: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :text_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0.3, green: 0.3, blue: 0.3, alpha: 1 }, attach: [], attached: [] }
)

Atome.new(
  { color: { renderers: default_render, id: :circle_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }, attach: [], attached: [] }
)

Atome.new(

  { color: { renderers: default_render, id: :matrix_color, type: :color, tag: ({ system: true, persistent: true }),
             left: 0, top: 0, red: 0.7, green: 0.7, blue: 0.7, alpha: 1, diffusion: :linear }, attach: [], attached: [] }
)

# # system object creation
# # the black_matter is used to store un materialized atomes
Atome.new(
  { shape: { renderers: default_render, id: :black_matter, type: :shape, attach: [:user_view],
             left: 0, right: 0, top: 0, bottom: 0, width: 0, height: 0, overflow: :hidden, tag: { system: true }, attached: []
  } })

# view port
# Atome.new(
# { shape: { renderers: default_render, id: :view, type: :shape, attach: [:user_view], tag: { system: true },
# attached: [:view_color], left: 0, right: 0, top: 0, bottom: 0, width: :auto, height: :auto, overflow: :auto,
# }
# }
# )

# #unreal port
# Atome.new(
# { shape: { renderers: default_render, id: :intuition, type: :shape, attach: [:user_view], tag: { system: true },
# left: 0, top: 0, width: 0, height: 0, overflow: :visible, attached: []
# }
# }
# )

############ user objects ######

# Atome.new(
# { color: { renderers: default_render, id: [:base_color], type: :color,tag: ({ system: true,persistent: true }),
# red: 1, green: 0.15, blue: 0.15, alpha: 1 }, attach: [], attached: [] }
# )
# a=Atome.new(
# { shape: { renderers: default_render, id: :my_shape, type: :shape, attach: [:view],
# left: 0, top: 0, width: 100, height: 100, overflow: :visible, attached: [:base_color]
# }
# }
# )

# ###################  broken tests below
#
#
#
# # init basic object for atome environment
#
# # Atome.new is used to create a new atome using best performances but params must be formatted and ordered correctly
#
# # use atome.atome to create a new atome using a more permissive syntax less performances but params must be formatted
# # and ordered correctly
#
# # Atome.atome ids the easiest way to create a new atome
# Atome.new({
# shape: { left: 0, right: 0, top: 0, bottom: 0, id: :view, color: { id: :c1, render: [:headless],
# red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } } })
#
# # WARNING: when using Atome.new syntax , you must get your object using the .atome
# # example to get the atome above : use a.shape.left and not a.left it wont access the physical object
# initialize Universe
#
#
# # ####### code below oesn't work !!!  ######
# b=box({id: :big_box, renderers: [:headless, :inspect]})
# # alert "====> #{b.id}"
# # alert :pass_1
# c = circle({ id: :the_circle, left: 333, renderers: [:html] })
# # alert :pass_2
# wait 3 do
# c.attached(b.id)
# end
#
# alert c.respond_to?(:browser_shape_left)
# alert c.respond_to?(:html_shape_left)
# alert Universe.particle_list.keys.length+Universe.atome_list.length
#
#
# ################################################# examples for wasm and opal compatibility #################################################
# #
# JS.eval("console.log('kool')")
# puts JS.eval("return 1 + 2;") # => 3
# # JS.global[:document].write("Hello, world!")
# div = JS.global[:document].createElement("div")
# div[:innerText] = "clické2 me"
# JS.global[:document][:body].appendChild(div)
# element = JS.global[:document].createElement("div")
# element.setAttribute("id", "my-div")
# element[:style][:color] = "red"
# element[:innerText] = "cheked"
# JS.global[:document][:body].appendChild(element)
#
# div[:style][:backgroundColor] = "orange"
# div[:style][:color] = "white"
# div.addEventListener("click") do |e|
# alert e
# puts "hello"
# div[:style][:backgroundColor] = "blue"
# div[:innerText] = "clicked!"
# end
# element_to_move = JS.global[:document].getElementById("my-div")
# element_to_move[:style][:left] = "333px"
# element_to_move[:style][:position] = "absolute"
# # ############################
# #
# def hello_ruby(val)
# puts val
# end
# JS.global[:rubyVM].eval("puts 'eval ruby from JS works!'")
# JS.global[:rubyVM].eval("hello_ruby 'method call from js inside ruby works!!!'")
#
#
# div = JS.global[:document].createElement("div")
# JS.global[:document][:body].appendChild(div)
# div.setAttribute("id", "the_box")
# # // let's add the style
#
# the_boxStyle = "width: 120px;height: 320px;top: 120px;position: absolute,left: 90px;background-color: yellow";
# # JS : var obj = { width: "120px", height: "320px",position: "absolute", top: "120px",left: "90px", backgroundColor: "yellow" };
# children_found = ["the_box"];
# children_found.each do |child|
# el_found = JS.global[:document].getElementById(child)
# el_found[:style][:cssText]=the_boxStyle
# end
#
#
# # # //let's create the color now
# my_colorStyle = "red";
# parents_found = ["the_box"];
# parents_found.each do |parent_found|
# el_found = JS.global[:document].getElementById(parent_found)
# el_found[:style][:backgroundColor]=my_colorStyle
# end
#
#
#
# # ############## resize example ##############
# window = JS.global
#
# # # Fonction appelée lorsque la fenêtre est redimensionnée
# def on_window_resize
#  width = JS.global[:window][:innerWidth]
#  height = JS.global[:window][:innerHeight]
#
#  # Afficher la taille dans la console Ruby-Wasm
#  puts "Taille de la fenêtre: #{width} x #{height}"
# end
# #
# # # Attacher la fonction au gestionnaire d'événements de redimensionnement
# window.addEventListener("resize") do |_|
#  on_window_resize
# end
# # #############
#
# # # demo below uncomemnt corresponding code in wasm/index.html
# def my_rb_method(val)
#  puts "val is #{val}"
# end
#
#
# def my_rb_method2(val, val2)
#  my_proc= instance_variable_get(val2)
#  my_proc.call(val) if my_proc.is_a? Proc
# end
#
# def  my_fct(val, &proc)
#  puts "----- > ok for all #{val}"
#  proc.call("Hello from proc!") if proc.is_a? Proc
# end
#
# def  my_test_fct
#  puts "----- > ok for my_test_fct"
# end
# JS.global[:rubyVM].eval('my_test_fct') # => works
#
# @my_proc = Proc.new { |x| puts x } # => works
# JS.global[:rubyVM].send(:my_fct, 'js can call ruby method!!',&@my_proc) # => works
# JS.global[:document][:js_method_that_call_ruby_method]
# JS.global.call('js_method_that_call_ruby_method','I am the great params for the proc', "@my_proc")
# JS.global.send('my_test_fct')


