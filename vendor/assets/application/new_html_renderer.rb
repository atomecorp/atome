######## tests

def attachment_common(children_ids, parents_ids, &user_proc)
  # FIXME : it seems we sometime iterate when for nothing
  parents_ids.each do |parent_id|
    # FIXME : find a more optimised way to prevent atome to attach to itself
    parent_found = grab(parent_id)
    parent_found.atome[:attached].concat(children_ids).uniq!
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

new({ particle: :attached, render: false }) do |children_ids, &user_proc|
  # fastened
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  parents_ids = [id]
  attachment_common(children_ids, parents_ids, &user_proc)
  children_ids
end

new({ particle: :web })
new({ particle: :unit, type: :hash })

def extract_rgb_alpha(color_string)
  match_data = color_string.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+(?:\.\d+)?))?\)/)
  # if match_data
  red = match_data[1].to_i
  green = match_data[2].to_i
  blue = match_data[3].to_i
  alpha = match_data[4] ? match_data[4].to_f : nil
  { red: red, green: green, blue: blue, alpha: alpha }

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
    targeted_atome.html.style(:backgroundColor, "rgba(#{html_params}, #{rgba_data[:green]}, #{rgba_data[:blue]},
#{rgba_data[:alpha]})")
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
    targeted_atome.html.style(:backgroundColor, "rgba(#{rgba_data[:red]}, #{html_params}, #{rgba_data[:blue]},
#{rgba_data[:alpha]})")
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
    targeted_atome.html.style(:backgroundColor, "rgba(#{rgba_data[:red]}, #{rgba_data[:green]}, #{html_params},
#{rgba_data[:alpha]})")
  end
  self
end

new({ particle: :alpha, render: true }) do |params, &user_proc|
  attached.each do |attached_atome_found|
    targeted_atome = grab(attached_atome_found)
    color_found = targeted_atome.html.style(:backgroundColor).to_s
    rgba_data = extract_rgb_alpha(color_found)
    targeted_atome.html.style(:backgroundColor, "rgba(#{rgba_data[:red]}, #{rgba_data[:green]}, #{rgba_data[:blue]},
 #{params})")
  end
  self
end

class HTML
  def initialize(id_found,current_atome)
    @html_object ||= JS.global[:document].getElementById(id_found.to_s)
    @id = id_found
    @atome=current_atome
    self
  end

  def attr(attribute, value)
    @html_object.setAttribute(attribute.to_s, value.to_s)
    self
  end

  def add_class(class_to_add)
    @html_object[:classList].add(class_to_add.to_s)
    self
  end

  def id(id)
    attr('id', id)
    self
  end

  def shape(id)
    markup_found = @atome.markup || :div
    @html_type = markup_found.to_s
    @html_object = JS.global[:document].createElement(@html_type)
    JS.global[:document][:body].appendChild(@html_object)
    add_class("atome")
    id(id)
    self
  end
  # def shape(id)
  #   @html_type = :div
  #   @html_object = JS.global[:document].createElement("div")
  #   JS.global[:document][:body].appendChild(@html_object)
  #   add_class("atome")
  #   id(id)
  #   self
  # end

  def text(id, markup='pre')
    @html_type = :div
    @html_object = JS.global[:document].createElement(markup.to_s)
    JS.global[:document][:body].appendChild(@html_object)
    add_class("atome")
    id(id)
    self
  end

  # def changeMarkup(new_markup)
  #   unless @atome.markup.to_s || new_markup.to_s
  #     alert new_markup
  #   end
  # end

  def innerText(data)
    @html_object[:innerText] = data.to_s
  end

  def textContent(data)
    @html_object[:textContent] = data
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

  def append(child_id_found)
    child_found = JS.global[:document].getElementById(child_id_found.to_s)
    @html_object.appendChild(child_found)
    self
  end


  ###### event handler ######
  def event(action, options, bloc)
    # puts "bloc : #{bloc}"
    send("#{action}_#{options}", bloc)
  end

  def over_true(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('mouseover') do
      bloc.call
    end
  end

  def over_enter(bloc)
    JS.global[:myRubyMouseEnterCallback] = bloc
    JS.eval("document.querySelector('##{@id}').addEventListener('mouseenter', function() { myRubyMouseEnterCallback(); });")

  end

  def over_leave(bloc)
    JS.global[:myRubyMouseLeaveCallback] = bloc
    JS.eval("document.querySelector('##{@id}').addEventListener('mouseleave', function() { myRubyMouseLeaveCallback(); });")
  end

  def touch_true(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('tap') do
      bloc.call
    end
  end

  def touch_double(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('doubletap') do
      bloc.call
    end
  end

  def touch_long(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('hold') do
      bloc.call
    end
  end

  def touch_down(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('down') do
      bloc.call
    end
  end

  def touch_up(bloc)
    interact = JS.eval("return interact('##{@id}')")
    interact.on('up') do
      bloc.call
    end
  end

  ###### end event handler ######

end

class Atome
  def html
    @html_object = HTML.new(id,self)
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
  params
end

new({ renderer: :html, method: :height, type: :string }) do |value, _user_proc|
  html.style(:height, "#{value}px")
end

new({ renderer: :html, method: :smooth, type: :string }) do |value, _user_proc|
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

new({ renderer: :html, method: :attach, type: :string, specific: :color }) do |parent_found, _user_proc|
  grab(parent_found).apply(id)
end

new({ renderer: :html, method: :apply, type: :string }) do |parent_found, _user_proc|
  red = parent_found.red * 255
  green = parent_found.green * 255
  blue = parent_found.blue * 255
  alpha = parent_found.alpha
  html.style(:backgroundColor, "rgba(#{red}, #{green}, #{blue}, #{alpha})")
end

new({ renderer: :html, method: :apply, type: :string, specific: :text }) do |parent_found, _user_proc|
  # TODO:   we should treat objet when multiple : #{self.inspect}

  red = parent_found.red * 255
  green = parent_found.green * 255
  blue = parent_found.blue * 255
  alpha = parent_found.alpha
  html.style(:color, "rgba(#{red}, #{green}, #{blue}, #{alpha})")
end

new({ renderer: :html, method: :clones, type: :string }) do |_value, _user_proc|

end

new({ renderer: :html, method: :overflow, type: :string })

new({ renderer: :html, method: :preset, type: :string })

new({ renderer: :html, method: :id, type: :string })

new({ renderer: :html, method: :renderers, type: :string })

new({ renderer: :html, method: :diffusion, type: :string })

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


new({ method: :type, type: :string, specific: :shape, renderer: :html }) do |_value, _user_proc|
  html.shape(@atome[:id])
end

new({ method: :type, type: :string, specific: :text, renderer: :html }) do |_value, _user_proc|
  html.text(@atome[:id], :pre)
  html.add_class(:text)
end
new({ method: :size, type: :hash, renderer: :html}) do |value, _user_proc|
  # html.style('fontSize',"#{value}px")
  alert 'write method for size here'
end
#
new({ method: :size, type: :int, renderer: :html, specific: :text }) do |value, _user_proc|
  html.style('fontSize',"#{value}px")
end

# new({ method: :component, type: :hash, renderer: :html }) do |params, _user_proc|
#   params.each do |prop, value|
#     alert  "prop&value : #{prop},#{value}, #{id}"
#     wait 1 do
#       self.send(prop,value)
#     end
#     # self.send(prop,value)
#     # self.send('size',9)
#   end
#   # html.style('fontSize',"11px")
#   # html.style('top',"0px")
#   # html.style('color',"yellow")
#
#   # value.each do |particle_found, value_found|
#   #   puts "#{particle_found.class}, #{value_found.class}"
#   #   # html.style('fontSize',"#{value}px")
#   #   html.style('fontSize',"33px")
#   #   html.style('top',"0px")
#   #   # # send(particle_found,value_found)
#   # end
# end

new({ method: :width, type: :integer, renderer: :html }) do |value, _user_proc|
  unit_found = unit[:width]
  if unit_found
    html.style(:width, "#{value}#{unit_found}")
  else
    html.style(:width, "#{value}px")
  end
end

new({ method: :right, type: :string, specific: :shape, renderer: :html }) do |value, _user_proc|
  html.style(:right, "#{value}px")
end

new({ method: :top, type: :integer, renderer: :html }) do |params, &bloc|
  html.style(:top, "#{params}px")
end

new({ method: :bottom, type: :integer, renderer: :html }) do |params, &bloc|
  html.style(:bottom, "#{params}px")
end

new({ method: :right, type: :integer }) do |params, &bloc|
  html.style(:right, "#{params}px")
end

new({ method: :left, type: :integer, renderer: :html }) do |params, &bloc|

  html.style(:left, "#{params}px")
end

new({ method: :left, type: :integer, specific: :color, renderer: :html })
new({ method: :top, type: :integer, specific: :color, renderer: :html })

#
new({ method: :red, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
end

new({ method: :green, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
end

new({ method: :blue, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
end

new({ method: :alpha, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
end

new({ method: :data, type: :string, specific: :text, renderer: :html }) do |value, _user_proc|
  # if value.instance_of? Array
  #   value.each do |sub_object|
  #     if sub_object.instance_of? Hash
  #       # additional_data = sub_text.reject { |cle| cle == :data }
  #       # additional_id = sub_text.reject { |cle| cle == :id }
  #       # additional_visual = sub_text.reject { |cle| cle == :visual }
  #       ne # alert sub_text
  #       data_found=sub_object[:data]
  #       id_found=sub_object[:id]
  #       visual_found=sub_object[:visual]
  #
  #       sub_text=HTML.new(id_found)
  #       sub_text.text(id_found, :span)
  #       sub_text.innerText(data_found)
  #       sub_text.append_to(id)
  #       visual_found.each do |property, value|
  #         if property.to_s=='size'
  #           property= 'fontSize'
  #           # value="#{value}px"
  #         end
  #         # alert "#{property}, #{value}"
  #         sub_text.style(property, "#{value}px")
  #         # alert "#{property}, #{value}"
  #       end
  #     else
  #       html.innerText(sub_object)
  #     end
  #   end
  #
  # else
  #   html.innerText(value)
  # end
  html.innerText(value)
end

new({ initialize: :unit, value: {} })

new ({particle: :markup})
# new ({renderer: :html, method: :markup, type: :symbol}) do |params|
#   html.changeMarkup(params)
# end
new ({atome: :physical})

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
aa = Atome.new(
  { renderers: default_render, id: :my_shape2, type: :shape, attach: [:view], apply: [:box_color],
    left: 120, top: 30, width: 100, height: 100, overflow: :visible, attached: [:my_shape]

  }
)

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
new({ method: :touch, type: :integer, renderer: :html }) do |options, user_bloc|
  # puts user_bloc
  # puts @touch_code
  html.event(:touch, options, user_bloc)
end

new({ method: :over, type: :integer, renderer: :html }) do |options, user_bloc|
  html.event(:over, options, user_bloc)
end
#
# # Atome.class_variable_set(:@@variable_de_classe_externe, "ma valeur")
aa.touch(:long) do
  puts "cooly long touched!"
end

aa.touch(:double) do
  puts "cooly double touched!"
end

aa.touch(:up) do
  puts "cooly up touched!"
end

aa.touch(:down) do
  puts "cooly down touched!"
end
# over
aa.touch(true) do
  puts "cooly touched!"
end

aa.over(:enter) do
  puts "cool enter"
end

aa.over(true) do
  puts "true over"
end
aa.over(:leave) do
  puts "cool leave"
end
#
# b = box({ id: :titi })
# t = b.text({ data: :orangered, id: :the_orange, attach: [:my_txt] })
# aa.text({ data: :hello, id: :the_text })
# b.color(:orange)
# # ###################### uncomment above
#
# # c = circle
# # c.color(:blue)
#
# tt = text({ data: :cool, id: :new_text })
# tt.left(333)
# # alert tt.left
# tt.color(:red)
# # c.left(333)
#
#
# puts Atome.class_variable_get(:@@post_touch)
# alert Atome.class_variable_get(:@@variable_de_classe_externe)
# aa.touch(:kool)
# text(:hello_you)
#
# ################### works below
# def wait(time, &proc)
#   if time == :kill
#     # Annuler le setTimeout actuel
#     JS.eval("clearTimeout(window.myTimeoutId);")
#   else
#     # Enregistrement de la fonction de rappel pour qu'elle soit accessible depuis JavaScript
#     JS.global[:myRubyCallback] = proc
#
#     # Utilisation de JS.eval pour appeler setTimeout en JavaScript et stocker l'ID de timeout
#     JS.eval("window.myTimeoutId = setTimeout(function() { myRubyCallback(); }, #{time});")
#   end
# end
#
# wait(2000) do
#   alert "Temps écoulé !"
# end
#
# # wait(:kill)
# ################### works above

# ##### wait usage
# # Simple usage
# wait 1 do
#   alert :good
# end
#
# # Advanced usage
wait_id=wait(4, 'timeout1') do
  puts "Ceci est affiche  après 4 secondes."
end
#
wait(5, 'timeout2') do
  puts "Ceci est affiche  après 5 secondes."
end

wait(3 ) do
  puts "Ceci est affiche après 3 secondes."
end


wait(1) do
  wait(:kill, wait_id)
end
#
# sleep(2)
# wait(:kill, 'timeout1')
# alert aa.inspect

# text({id: 'phone_nb', data: :hello,component: {left: 333}})
#  grab(:phone_nb).color(:pink)
# alert grab('phone_nb')
# wait 2 do
#   alert grab(:phone_nb)
#   grab(:phone_nb).color(:green)
# end
############# crash
the_text = text({ data: [
  '74 Bis Avenue des Thermes - Chamalieres, tel: ',
  { data: '06 63 60 40 55!',width: :auto,component: {size: 63,  top: 30},top: 0, color: :blue, id: :phone_nb },
  { data: 'la suite',width: :auto}, :super, :cool,:great
],center: true, top: 120,width: 955,id: :my_x_text, component: {size: 11} })
# grab('phone_nb').top(55)
# alert grab('phone_nb')
grab('phone_nb').color(:red)
grab('phone_nb').touch(true) do
  grab('phone_nb').color(:green)
end
wait 3 do
  # alert grab('phone_nb')
  grab('phone_nb').component({ size: 9})
  grab('phone_nb').color(:yellow)
end
# TODO : Important make it work below add uniq id to wait
wait 3 do
  puts 'check passed'
end

############# crash
# # the_text=text({ data:[ ' text de verif',visual:{size: 37, top: 0, width: 555}, id: :my_new_text, width: 222] })
# # the_text.visual({size: 88})
# the_text.color(:green)
# t=text(:kool)
# t=text({ data: :hello })
# alert t.class
# wait 2 do
#   t.data('hi')
# end
# the_one=box(markup: :span)
# wait 3 do
#   the_one.markup(:div)
# end

#
# # TODO: implement complex concatenated texts
# # TODO: rename particle as property
# # the_text.color(:yellow)
#
