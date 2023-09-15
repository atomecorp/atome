######## tests

def attachment_common(children_ids, parents_ids, &user_proc)
  # alert "problem here ===>#{self.inspect}"
  # puts "id is : #{id}"
  # alert "After ===>#{self.inspect}"
  # FIXME : it seems we sometime iterate when for nothing
  parents_ids.each do |parent_id|
    # FIXME : find a more optimised way to prevent atome to attach to itself
    parent_found = grab(parent_id)
    parent_found.atome[:attached].concat(children_ids).uniq!
    # if parent_found.type == :color
    #   children_ids.each do |child_id|
    #     child_found = grab(child_id)
    #     child_found.render(:apply, parent_found, &user_proc) if child_found
    #   end
    # else
    children_ids.each do |child_id|
      child_found = grab(child_id)
      child_found.render(:attach, parent_id, &user_proc) if child_found
    end
    # end
  end
end

# new({html: :attach})
new({ particle: :attach, render: false }) do |parents_ids, &user_proc|
  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  children_ids = [id]
  attachment_common(children_ids, parents_ids, &user_proc)
  parents_ids
end

new({ particle: :apply, render: false }) do |parents_ids, &user_proc|
  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  children_ids = [id]
  parents_ids.each do |parent_id|
    parent_found = grab(parent_id)
    children_ids.each do |child_id|
      child_found = grab(child_id)
      child_found.render(:apply, parent_found, &user_proc) if child_found
    end
  end
  parents_ids
end

new({ particle: :affect, render: false }) do |children_ids, &user_proc|
  children_ids.each do |child_id|
    child_found = grab(child_id)
    child_found.render(:apply, self, &user_proc) if child_found
  end
  children_ids
end

# new({ particle: :affect, render: false }) do |children_ids, &user_proc|
#   # # fastened
#   # children_ids = [children_ids] unless children_ids.instance_of?(Array)
#   # parents_ids = [id]
#   # attachment_common(children_ids, parents_ids, &user_proc)
#   children_ids
# end

new({ particle: :attached, render: false }) do |children_ids, &user_proc|
  # fastened
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  parents_ids = [id]
  attachment_common(children_ids, parents_ids, &user_proc)
  children_ids
end

# new({ particle: :affect, render: false }) do |children_ids, &user_proc|
#   # fastened
#   children_ids = [children_ids] unless children_ids.instance_of?(Array)
#   parents_ids = [id]
#   # parents_ids.each do |parent_id|
#   #   parent_found = grab(parent_id)
#   #   parent_found.atome[:attached].concat(children_ids).uniq!
#   #   children_ids.each do |child_id|
#   #     child_found = grab(child_id)
#   #     child_found.render(:apply, parent_found, &user_proc) if child_found
#   #   end
#   # end
#   # children_ids
# end

new(particle: :web)

# new({ particle: :web, render: true }) do |params, &user_proc|
#
#   # alert 'tag creation here, cf : div, span , h1, h2, pre , etc...'
#   # fastened
#   # alert "#{self.id} : children_ids : #{children_ids}"
#   # children_ids = [children_ids] unless children_ids.instance_of?(Array)
#   # parents_ids = [id]
#   # # alert "#{children_ids}, #{parents_ids}"
#   # attachment_common(children_ids, parents_ids, &user_proc)
#   params
# end
#

def extract_rgb_alpha(color_string)
  match_data = color_string.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+(?:\.\d+)?))?\)/)
  # if match_data
  red = match_data[1].to_i
  green = match_data[2].to_i
  blue = match_data[3].to_i
  alpha = match_data[4] ? match_data[4].to_f : nil
  return { red: red, green: green, blue: blue, alpha: alpha }
  # else
  #   puts "Color format not valid"
  #   return nil
  # end
end

new({ particle: :red, render: true }) do |params, &user_proc|
  attached.each do |attached_atome_found|
    targeted_atome = grab(attached_atome_found)
    color_found = targeted_atome.html.style(:backgroundColor).to_s
    rgba_data = extract_rgb_alpha(color_found)
    html_params = params * 255
    unless rgba_data[:alpha]
      rgba_data[:alpha] = 1
    end
    targeted_atome.html.style(:backgroundColor, "rgba(#{html_params}, #{rgba_data[:green]}, #{rgba_data[:blue]}, #{rgba_data[:alpha]})")
  end
  self
end

new({ particle: :green, render: true }) do |params, &user_proc|
  attached.each do |attached_atome_found|
    targeted_atome = grab(attached_atome_found)
    color_found = targeted_atome.html.style(:backgroundColor).to_s
    rgba_data = extract_rgb_alpha(color_found)
    html_params = params * 255
    unless rgba_data[:alpha]
      rgba_data[:alpha] = 1
    end
    targeted_atome.html.style(:backgroundColor, "rgba(#{rgba_data[:red]}, #{html_params}, #{rgba_data[:blue]}, #{rgba_data[:alpha]})")
  end
  self
end

new({ particle: :blue, render: true }) do |params, &user_proc|
  attached.each do |attached_atome_found|
    targeted_atome = grab(attached_atome_found)
    color_found = targeted_atome.html.style(:backgroundColor).to_s
    rgba_data = extract_rgb_alpha(color_found)
    html_params = params * 255
    unless rgba_data[:alpha]
      rgba_data[:alpha] = 1
    end
    targeted_atome.html.style(:backgroundColor, "rgba(#{rgba_data[:red]}, #{rgba_data[:green]}, #{html_params}, #{rgba_data[:alpha]})")
  end
  self
end

new({ particle: :alpha, render: true }) do |params, &user_proc|
  attached.each do |attached_atome_found|
    targeted_atome = grab(attached_atome_found)
    color_found = targeted_atome.html.style(:backgroundColor).to_s
    rgba_data = extract_rgb_alpha(color_found)
    targeted_atome.html.style(:backgroundColor, "rgba(#{rgba_data[:red]}, #{rgba_data[:green]}, #{rgba_data[:blue]}, #{params})")
  end
  self
end

######
# alert :good
class HTML
  def initialize(id_found)
    @html_object ||= JS.global[:document].getElementById(id_found.to_s)
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

  def style(property, value = nil)
    element_found = JS.global[:document].getElementById(@id.to_s)
    if value
      element_found[:style][property] = value.to_s
    else
      element_found[:style][property]
    end
    # self
    element_found[:style][property]
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

  # def html_colorize_color(red, green, blue, alpha, atome)
  #   ########################### new code ###########################
  #   # puts "@id in html_colorize_color is :  #{@id}"
  #   id_found = @id
  #   color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  #   new_class_content = <<~STR
  #     .#{id_found} {
  #     --#{id_found}_r : #{red * 255};
  #     --#{id_found}_g : #{green * 255};
  #     --#{id_found}_b : #{blue * 255};
  #     --#{id_found}_a : #{alpha};
  #     --#{id_found}_col : rgba(var(--#{id_found}_r ),var(--#{id_found}_g ),var(--#{id_found}_b ),var(--#{id_found}_a ));
  #
  #     background-color: var(--#{id_found}_col);
  #     fill: var(--#{id_found}_col);
  #     stroke: var(--#{id_found}_col);
  #     }
  #   STR
  #   puts new_class_content
  #   alert atome.inspect
  #   # puts "====> new_class_content #{new_class_content}"
  #   # atomic_style = BrowserHelper.browser_document['#atomic_style']
  #   # # atomic_style.text = atomic_style.text.gsub(/\.#{id_found}\s*{.*?}/m, new_class_content)
  #   #
  #   # regex = /(\.#{id_found}\s*{)([\s\S]*?)(})/m
  #   # atomic_style.text = atomic_style.text.gsub(regex, new_class_content)
  # end

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

new({ renderer: :html, method: :web }) do |params, &user_proc|

  # puts 'tag creation here, cf : div, span , h1, h2, pre , etc...'
  # fastened
  # alert "#{self.id} : children_ids : #{children_ids}"
  # children_ids = [children_ids] unless children_ids.instance_of?(Array)
  # parents_ids = [id]
  # # alert "#{children_ids}, #{parents_ids}"
  # attachment_common(children_ids, parents_ids, &user_proc)
  params
end

new({ renderer: :html, method: :type, type: :string, specific: :shape }) do |_value, _user_proc|
  html.shape(@atome[:id])
end

new({ renderer: :html, method: :height, type: :string }) do |value, _user_proc|
  html.style(:height, "#{value}px")
end

new({ renderer: :html, method: :smooth, type: :string }) do |value, _user_proc|
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

new({ renderer: :html, method: :attach, type: :string }) do |parent_found, _user_proc|

  html.append_to(parent_found)
end

new({ renderer: :html, method: :apply, type: :string }) do |parent_found, _user_proc|
  red = parent_found.red * 255
  green = parent_found.green * 255
  blue = parent_found.blue * 255
  alpha = parent_found.alpha
  html.style(:backgroundColor, "rgba(#{red}, #{green}, #{blue}, #{alpha})")
end

new({ renderer: :html, method: :top, type: :string }) do |_value, _user_proc|

end

new({ renderer: :html, method: :bottom, type: :string }) do |_value, _user_proc|

end

new({ renderer: :html, method: :clones, type: :string }) do |_value, _user_proc|

end

new({ renderer: :html, method: :overflow, type: :string })

new({ renderer: :html, method: :preset, type: :string })

new({ renderer: :html, method: :id, type: :string })

new({ renderer: :html, method: :renderers, type: :string })

new({ renderer: :html, method: :diffusion, type: :string })

# alert :pass_0

# new({ renderer: :html, method: :color, type: :string }) do
# puts "====> yeah"
# end

######### data tests
# frozen_string_literal: true

# let's create the Universe
# def eval_protection
#   binding
# end

# Let's set the default's parameters according to ruby interpreter
# Essentials.new_default_params({ render_engines: [:html] })
# if RUBY_ENGINE.downcase == 'opal'
#
# else
#   puts "------- **pas opal** ------"
#   Essentials.new_default_params({ render_engines: [:html] })
#   # alert "RUBY_ENGINE is : #{RUBY_ENGINE.downcase}"
#   # Essentials.new_default_params({ render_engines: [:headless] })
#   # eval "require 'atome/extensions/geolocation'", eval_protection, __FILE__, __LINE__
#   # eval "require 'atome/extensions/ping'", eval_protection, __FILE__, __LINE__
#   # eval "require 'atome/extensions/sha'", eval_protection, __FILE__, __LINE__
# end

# now let's get the default render engine
default_render = Essentials.default_params[:render_engines]

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

# new({ specific: :color, method: :poil }) do |_value, _user_proc|
#   # html.shape(@atome[:id])
#   alert "i am here"
# end
#
# new({ specific: :color, method: :poilu, renderer: :html }) do |_value, _user_proc|
#   # html.shape(@atome[:id])
#   alert "i am here too!!"
# end

new({ method: :type, type: :string, specific: :shape, renderer: :html }) do |_value, _user_proc|
  html.shape(@atome[:id])
end

# new({ renderer: :html, method: :type, type: :string, exclusive: :shape }) do |_value, _user_proc|
#   html.shape(@atome[:id])
# end

new({ method: :width, type: :integer, renderer: :html }) do |value, _user_proc|

  html.style(:width, "#{value}px")
end

new({ method: :right, type: :string, specific: :shape, renderer: :html }) do |value, _user_proc|
  html.style(:right, "#{value}px")
end

new({ method: :top, type: :integer, specific: :shape, renderer: :html }) do |params, &bloc|
  html.style(:top, "#{params}px")
end

new({ method: :bottom, type: :integer, specific: :shape, renderer: :html }) do |params, &bloc|
  html.style(:bottom, "#{params}px")
end

new({ method: :right, type: :integer, specific: :shape }) do |params, &bloc|
  html.style(:right, "#{params}px")
end

new({ method: :left, type: :integer, specific: :shape, renderer: :html }) do |params, &bloc|

  html.style(:left, "#{params}px")
end

new({ method: :left, type: :integer, specific: :color, renderer: :html })

#
new({ method: :red, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
  # puts "#{id} is becoming red with html"

  # alert value
  # puts "==> red only for color: #{value} - take a look at : browser/helper/color_helper : browser_colorize_color"
  red = (@atome[:red] = value)
  green = @atome[:green]
  blue = @atome[:blue]
  alpha = @atome[:alpha]
  top = @atome[:top]
  left = @atome[:left]
  diffusion = @atome[:diffusion]

  # html.send("html_colorize_#{@atome[:type]}", red, green, blue, alpha, self)

  # # color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  # Atome.send("html_colorize_#{@atome[:type]}", red, green, blue, alpha, @atome)
  # # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

new({ method: :green, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
  # puts "==> green only for color: #{value}"
end

new({ method: :blue, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
  # puts "==> blue only for color: #{value}"
end

new({ method: :alpha, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
  # puts "==> alpha only for color: #{value}"
end

############### Lets create the U.I.
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
    red: 0.3, green: 0.3, blue: 0.3, alpha: 1, attach: [], attached: [] }
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
  { renderers: default_render, id: :view, type: :shape, attach: [:user_view], apply: [:view_color], tag: { system: true },
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

s_c = grab(:shape_color)

a = Atome.new(
  { renderers: default_render, id: :my_shape, type: :shape, attach: [:view], apply: [:shape_color],
    left: 120, top: 0, width: 100, height: 100, overflow: :visible, attached: []
  }

)

aa = Atome.new(
  { renderers: default_render, id: :my_shape2, type: :shape, attach: [:view], apply: [:box_color],
    left: 120, top: 30, width: 100, height: 100, overflow: :visible, attached: [:my_shape]

  }
)

s_c.red(0.2)
s_c.blue(0)
s_c.green(0)
a.top(99)
a.smooth(33)
a.web({ tag: :span })
aa.smooth(9)
# FIXME:  add apply to targeted shape, ad affect to color applied
box
circle
# text(:hello)
# Atome.new({  :type => :shape, :width => 99, id: :my_id, :height => 99, :apply => [:box_color], :attach => [:view], :left => 300, :top => 100, :clones => [], :preset => :box, :id => "box_12", :renderers => [:html] })

