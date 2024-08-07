######## tests
alert :good
def attachment_common(children_ids, parents_ids, &user_proc)
  # alert "problem here ===>#{self.inspect}"
  # puts "id is : #{id}"
  # alert "After ===>#{self.inspect}"
  # FIXME: found why we have to use '.each_with_index' when using wasm '.each' crash for some reasons
  # FIXME : it seems we sometime iterate when for nothing
  parents_ids.each do |parent_id|

    # puts "parent_id : #{parent_id}"
    #   #FIXME : find a more optimised way to prevent atome to attach to itself
    #  puts "infernal loop here below: now fasten or attach may not be saved"
    #   puts "=> #{@atome[:attach]}"
    #   @atome[:attach] << parent_id if parent_id != id
    #   puts "infernal loop here above"
    parent_found = grab(parent_id)
    parent_found.atome[:fasten].concat(children_ids).uniq!
    if parent_found.type == :color

      children_ids.each do |child_id|
        # puts "color child is #{child_id}"
        child_found = grab(child_id)
        child_found.render(:apply, parent_found, &user_proc) if child_found
      end
    else

      children_ids.each do |child_id|
        #       # puts "shape child is #{child_id}"
        child_found = grab(child_id)
        child_found.render(:attach, parent_id, &user_proc) if child_found
      end
    end
  end
end
# new({html: :attach})
new({ particle: :attach, render: false }) do |parents_ids, &user_proc|
  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  children_ids = [id]
  attachment_common(children_ids, parents_ids, &user_proc)
  # parents_ids
end

new({ particle: :fasten, render: false }) do |children_ids, &user_proc|
  # fastened
  # alert "#{self.id} : children_ids : #{children_ids}"
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  parents_ids = [id]
  attachment_common(children_ids, parents_ids, &user_proc)
  # children_ids
end
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
  fasten.each do |fasten_atome_found|
    targeted_atome = grab(fasten_atome_found)
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
  fasten.each do |fasten_atome_found|
    targeted_atome = grab(fasten_atome_found)
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
  fasten.each do |fasten_atome_found|
    targeted_atome = grab(fasten_atome_found)
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
  fasten.each do |fasten_atome_found|
    targeted_atome = grab(fasten_atome_found)
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

# class Atome
#   particle_list_found = Universe.particle_list.keys
#   particle_list_found.each do |the_particle|
#     define_method("inspect_#{the_particle}") do |params, &bloc|
#       puts "=> inspect element: #{the_particle}\nparams : #{params}\nbloc: #{bloc}\n"
#     end
#   end
#
#   # def browser_color_renderers(val)
#   #   puts "=> browser_color_renderers: #{val}"
#   # end
# end

# def html_colorize_color(red, green, blue, alpha, atome)
#   ########################### new code ###########################
#   alert self.inspect
#   # id_found = atome[:id]
#   # color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
#   # new_class_content = <<~STR
#   #   .#{id_found} {
#   #   --#{id_found}_r : #{red * 255};
#   #   --#{id_found}_g : #{green * 255};
#   #   --#{id_found}_b : #{blue * 255};
#   #   --#{id_found}_a : #{alpha};
#   #   --#{id_found}_col : rgba(var(--#{id_found}_r ),var(--#{id_found}_g ),var(--#{id_found}_b ),var(--#{id_found}_a ));
#   #   background-color: var(--#{id_found}_col);
#   #   fill: var(--#{id_found}_col);
#   #   stroke: var(--#{id_found}_col);
#   #   }
#   # STR
#   #
#   # puts "====> new_class_content #{new_class_content}"
#   # atomic_style = BrowserHelper.browser_document['#atomic_style']
#   # # atomic_style.text = atomic_style.text.gsub(/\.#{id_found}\s*{.*?}/m, new_class_content)
#   #
#   # regex = /(\.#{id_found}\s*{)([\s\S]*?)(})/m
#   # atomic_style.text = atomic_style.text.gsub(regex, new_class_content)
# end






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

new({ renderer: :html, method: :type, type: :string }) do |_value, _user_proc|
  # html.shape(@atome[:id])
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
new({ specific: :color, method: :poil }) do |_value, _user_proc|
  # html.shape(@atome[:id])
  alert "i am here"
end

new({ specific: :color, method: :poilu, renderer: :html }) do |_value, _user_proc|
  # html.shape(@atome[:id])
  alert "i am here too!!"
end

new({ method: :type, type: :string, specific: :shape, renderer: :html }) do |_value, _user_proc|
  html.shape(@atome[:id])
end

# new({ renderer: :html, method: :type, type: :string, exclusive: :shape }) do |_value, _user_proc|
#   html.shape(@atome[:id])
# end

new({ method: :width, type: :integer, specific: :shape, renderer: :html }) do |value, _user_proc|
  html.style(:width, "#{value}px")
end

new({ method: :left, type: :string, exclusive: :shape , renderer: :html}) do |value, _user_proc|
  html.style(:left, "#{value}px")
end

new({ method: :right, type: :string, specific: :shape , renderer: :html}) do |value, _user_proc|
  html.style(:right, "#{value}px")
end

new({ method: :top, type: :integer, specific: :shape , renderer: :html}) do |params, &bloc|
  html.style(:top, "#{params}px")
end

new({ method: :bottom, type: :integer, specific: :shape , renderer: :html}) do |params, &bloc|
  html.style(:bottom, "#{params}px")
end

new({ method: :right, type: :integer, specific: :shape }) do |params, &bloc|
  html.style(:right, "#{params}px")
end

new({ method: :left, type: :integer, specific: :shape , renderer: :html}) do |params, &bloc|
  html.style(:left, "#{params}px")
end

new({ method: :left, type: :integer, specific: :color, renderer: :html })
#
new({ method: :red, type: :integer, specific: :color , renderer: :html}) do |value, _user_proc|
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

new({ method: :blue, type: :integer, specific: :color , renderer: :html}) do |value, _user_proc|
  # puts "==> blue only for color: #{value}"
end

new({ method: :alpha, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
  # puts "==> alpha only for color: #{value}"
end




# new({ renderer: :html, method: :color, type: :integer, exclusive: :color }) do |value, _user_proc|
# alert 'so kool'
# end


############### Lets create the U.I.
Atome.new(
  { element: { renderers: [], id: :eDen, type: :element, tag: { system: true }, attach: [], fasten: [] } }
)
Atome.new(
  { element: { renderers: [], id: :user_view, type: :element, tag: { system: true },
               attach: [:eDen], fasten: [] } }
)

# # color creation
Atome.new(
  { color: { renderers: default_render, id: :view_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0.15, green: 0.15, blue: 0.15, alpha: 1, top: 12, left: 0, diffusion: :linear, attach: [], fasten: [] } }
)

Atome.new(
  { color: { renderers: default_render, id: :shape_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0.4, green: 0.4, blue: 0.4, alpha: 1, attach: [], fasten: [] } }
)

########################################
Atome.new(
  { color: { renderers: default_render, id: :box_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0.5, green: 0.5, blue: 0.5, alpha: 1, attach: [], fasten: [] } }
)

Atome.new(
  { color: { renderers: default_render, id: :invisible_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0, green: 0, blue: 0, alpha: 1, attach: [], fasten: [] } }
)

Atome.new(
  { color: { renderers: default_render, id: :text_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0.3, green: 0.3, blue: 0.3, alpha: 1, attach: [], fasten: [] } }
)

Atome.new(
  { color: { renderers: default_render, id: :circle_color, type: :color, tag: ({ system: true, persistent: true }),
             red: 0.6, green: 0.6, blue: 0.6, alpha: 1, attach: [], fasten: [] } }
)

# Atome.new(
#
#   { color: { renderers: default_render, id: :matrix_color, type: :color, tag: ({ system: true, persistent: true }),
#              left: 0, top: 0, red: 0.7, green: 0.7, blue: 0.7, alpha: 1, diffusion: :linear }, attach: [], fasten: [] }
# )

# # system object creation
# # the black_matter is used to store un materialized atomes
Atome.new(
  { shape: { renderers: default_render, id: :black_matter, type: :shape, attach: [:user_view],
             left: 0, right: 0, top: 0, bottom: 0, width: 0, height: 0, overflow: :hidden, tag: { system: true }, fasten: []
  } })

# view port
Atome.new(
  { shape: { renderers: default_render, id: :view, type: :shape, attach: [:user_view, :view_color], tag: { system: true },
             fasten: [], left: 0, right: 0, top: 0, bottom: 0, width: :auto, height: :auto, overflow: :auto,
  }
  }
)

# #unreal port
Atome.new(
  { shape: { renderers: default_render, id: :intuition, type: :shape, attach: [:user_view], tag: { system: true },
             left: 0, top: 0, width: 0, height: 0, overflow: :visible, fasten: []
  }
  }
)

############ user objects ######

# Atome.new(
# { color: { renderers: default_render, id: [:base_color], type: :color,tag: ({ system: true,persistent: true }),
# red: 1, green: 0.15, blue: 0.15, alpha: 1 , attach: [], fasten: []} }
# )

# a.color(:red)
s_c = grab(:shape_color)

a = Atome.new(
  { shape: { renderers: default_render, id: :my_shape, type: :shape, attach: [:view, :shape_color],
             left: 120, top: 0, width: 100, height: 100, overflow: :visible, fasten: []
  }
  }
)

s_c.red(0.2)
s_c.blue(0)
s_c.green(0)
a.top(99)
a.smooth(33)
a.web({ tag: :span })

##########
# new({ renderer: :html, method: :text }) do
#   alert :kool
# end
# new({ atome: :text, type: :hash })
# new({ sanitizer: :text }) do |params|
#   if params[:data].instance_of? Array
#     alert :ok
#     #   additional_data = params.reject { |cle| cle == :data }
#     #   data_found = params[:data]
#     #   parent_text = ''
#     #   data_found.each_with_index do |atome_to_create, index|
#     #     unless atome_to_create.instance_of? Hash
#     #       atome_to_create = { data: atome_to_create, width: :auto }
#     #     end
#     #     if index == 0
#     #       parent_text = text(atome_to_create)
#     #       parent_text.set(additional_data)
#     #     else
#     #       parent_text.text(atome_to_create)
#     #     end
#     #   end
#     #   params = { data: '' }
#     # else
#     #   params = { data: params } unless params.instance_of? Hash
#   end
#   params
# end
class Atome
  # def html_text_renderers(params=nil)
  #   puts :what
  # end
  # def  method_missing(name, args=nil)
  #   puts "missing : #{name}"
  # end
  # def html_text_type(params=nil)
  #   puts :whatou
  # end
  # def html_text_attach(params=nil)
  #   puts :whatoku
  # end


  # def html_text_id(params=nil)
  #   puts :whatif
  # end
end
# new({ atome: :text, render: false }) do
#   alert "we should pass here !"
# end

# new({html: :renderers}) do
#   puts "ok for renderer!"
# end

# new({ renderer: :html, method: :text }) do
#   alert :kooly
# end

# ee=Atome.new(
#   text: { renderers: [:html], id: :text2, type: :text
#
#   }
# )
# alert ee.methods


################# EXPLANATION BELOW ###############
# # FIXME:  new particle, should generate method for each existing rendering engine
#
# new({particle: :my_article})
# # FIXME: for now we have to manually create the html method
# new({ renderer: :html, method: :my_article, type: :string })
################# EXPLANATION ABOVE ###############

ee=Atome.new(
  text: { renderers: [:html], id: :text2, type: :text,
          # left: 333, top: 33, width: 199, height: 33, fasten: [],
          my_article: :ok_with_it

  }
)

# ee=Atome.new(
#   text: { renderers: [:html], id: :text2, type: :shape, attach: [:view], visual: { size: 33 },
#           data: 'My second text!', left: 333, top: 33, width: 199, height: 33, fasten: [],
#
#   }
# )



# alert "test a.html for tag compatibility, maybe change html renderer to www"
##### new color model now we attach the color to the object

# a=Atome.new(
#   { shape: { renderers: default_render, id: :my_shape, type: :shape, attach: [:view,:shape_color],
#              left: 0, top: 0, width: 100, height: 100, overflow: :visible, fasten: []
#   }
#   }
# )
# # ############
# collected_id = []
# Universe.atomes.each do |id_found, atome_found|
#   # puts "1 => #{atome_found.inspect}"
#   # puts "2 => #{atome_found.tag}"
#   unless atome_found.tag && atome_found.tag[:system]
#     collected_id << id_found
#   end
# end
# alert collected_id
#
# # #########
# end
# a= grab(:shape_color)
# alert a.inspect

# Universe.user_atomes.each do |atome|
#
# end

# class Atome
#   def html_color_width(var=nil)
#     puts "var is #{var}"
#     self
#   end
# end
#
#
#
#
# b=Atome.new(
#   { shape: { renderers: default_render, id: :my_colorised, type: :color, attach: [:view],
#              left: 0, top: 0, width: 100, height: 100, overflow: :visible, fasten: []
#   }
#   }
# )

# a.color(:red)
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
# c.fasten(b.id)
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

# new({ specific: :color, method: :top }) do |_value, _user_proc|
#   # html.shape(@atome[:id])
#   "i am here"
# end

# bb=Atome.new({ color: { left: 77 } })
# bb.color({top: 66})

# ############ color and other atome's type solution
# module Color;end
#
# Color.define_method :top do |params = nil, &user_proc|
#   puts "top Color"
# end
#
# Color.define_method :hello do |params = nil, &user_proc|
#   puts "Hello from Color"
# end
#
# class Atome
#   def hello
#     puts "generic hello"
#   end
#
#   def top
#     puts 'generic top'
#   end
# end
#
# obj1 = Atome.new
# obj1.extend(Color)
#
# obj1.hello
# obj1.top
#
# # Redefine the methods in the singleton class
#
# class << obj1
#   methods = Atome.instance_methods
#   methods.each do |module_method|
#     original_method = Atome.instance_method(module_method)
#     define_method(module_method, original_method)
#   end
# end
#
# obj1.hello
# obj1.top
# box
