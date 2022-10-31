# frozen_string_literal: true

# generators

Genesis.particle_creator(:html_type)

Genesis.particle_creator(:html_object)

Genesis.atome_creator(:shape)

# Genesis.atome_creator(:additional)
Genesis.atome_creator(:content)

Genesis.atome_creator(:color)

Genesis.atome_creator_option(:color_sanitizer_proc) do |params, atome|
  params = atome.send(:color_sanitizer, params, atome)
  params
end

Genesis.atome_creator(:shadow)


Genesis.atome_creator_option(:shadow_sanitizer_proc) do |params, atome|
  # params = atome.send(:color_sanitizer, params, atome)
  params
end
Genesis.atome_creator(:video) do |params, &proc|
  # todo:  factorise code below
  if params
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "video_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id
    default_params = { render: [generated_render], id: generated_id, type: :video, parent: [generated_parent],
                       path: './medias/videos/video_missing.mp4',  width: 199, height: 199 }
    params = default_params.merge(params)
  end
  params
end

# Example below

# Genesis.atome_creator(:color) do |params|
#   # puts "extra color code executed!! : #{params}"
# end
# Genesis.atome_creator_option(:color_pre_save_proc) do |params|
#   puts "1- optional color_pre_save_proc: #{params}\n"
# end
#
# Genesis.atome_creator_option(:color_post_save_proc) do |params|
#   puts "2- optional color_post_save_proc: #{params}\n"
# end
# #
# Genesis.atome_creator_option(:left_pre_render_proc) do
#   puts "3 - optional color_pre_render_proc\n"
# end
# Genesis.atome_creator_option(:left_post_render_proc) do
#   puts "4 - optional color_post_render_proc\n"
# end
#
# Genesis.atome_creator_option(:color_post_render_proc) do
#   # puts "optional color_post_render_proc\n"
# end
#
# Genesis.atome_creator_option(:color_getter_pre_proc) do
#   # puts "optional color_getter_pre_proc\n"
# end

Genesis.particle_creator(:id)
Genesis.particle_creator(:left)
Genesis.particle_creator(:right)
Genesis.particle_creator(:top)
Genesis.particle_creator(:bottom)
Genesis.particle_creator(:width)
Genesis.particle_creator(:height)
Genesis.particle_creator(:red)
Genesis.particle_creator(:green)
Genesis.particle_creator(:blue)
Genesis.particle_creator(:alpha)
Genesis.particle_creator(:type)
Genesis.particle_creator(:smooth)
Genesis.particle_creator(:blur)
Genesis.particle_creator(:touch)
Genesis.particle_creator(:play)
Genesis.particle_creator(:pause)
Genesis.particle_creator(:time)

# Genesis.atome_creator_option(:type_pre_render_proc) do |params|
#   # "it works and get #{params}"
#   params[:value]
# end

# important exemple below how to prevent rendering
# Genesis.atome_creator_option(:top_render_proc) do |params|
#   puts "====---> Hurrey no rendering :  #{params}"
# end

Genesis.particle_creator(:render)
Genesis.particle_creator(:drm)

Genesis.particle_creator(:child)

Genesis.particle_creator(:parent) do |parents|
  parents.each do |parent|
    #TODO : create a root atome instead of using the condition below
    if parent != :user_view
      grab(parent).child << id
    end
  end
  parents
end

Genesis.atome_creator_option(:parent_pre_render_proc) do |params|
  current_atome = params[:atome]
  unless params[:value].instance_of? Array
    params[:value] = [params[:value]]
  end
  current_atome.instance_variable_set("@parent", params[:value])
end

Genesis.particle_creator(:date)
Genesis.particle_creator(:location)

Genesis.atome_creator_option(:id_pre_render_proc) do |params|
  new_id = params[:value]
  current_atome = params[:atome]
  old_id = current_atome.id
  current_atome.instance_variable_set('@id', new_id)
  # we change id id the atomes hash
  Universe.change_atome_id(old_id, new_id)
  current_atome.html_object.id = new_id if current_atome.html_object

end


# generate renderers

Genesis.generate_html_renderer(:type) do |value, atome, proc|
  send("#{value}_html", value, atome, proc)
  value
end

Genesis.generate_html_renderer(:shape) do |value, atome, proc|
  id_found = id
  instance_exec(&proc) if proc.is_a?(Proc)
  DOM do
    div(id: id_found).atome
  end.append_to($document[:user_view])
  @html_object = $document[id_found]
  @html_type = :div
end

Genesis.generate_html_renderer(:color) do |value, atome, proc|
  instance_exec(&proc) if proc.is_a?(Proc)
  @html_type = :style
  # we remove previous unused style tag
  $document[id].remove if $document[id]
  $document.head << DOM("<style atome='#{type}'  id='#{id}'></style>")
end
Genesis.generate_html_renderer(:red) do |value, atome, proc|
  green_found = green
  green_found ||= 0
  blue_found = blue
  blue_found ||= 0
  alpha_found = alpha
  alpha_found ||= 0
  $document[id].inner_html = "\n.#{id}{background-color: rgba(#{value * 255},#{green_found * 255},#{blue_found * 255},#{alpha_found})}\n"

end
Genesis.generate_html_renderer(:green) do |value, atome, proc|
  red_found = red
  red_found ||= 0
  blue_found = blue
  blue_found ||= 0
  alpha_found = alpha
  alpha_found ||= 0
  $document[id].inner_html = "\n.#{id}{background-color: rgba(#{red_found * 255},#{value * 255},#{blue_found * 255},#{alpha_found})}\n"

end
Genesis.generate_html_renderer(:blue) do |value, atome, proc|
  red_found = red
  red_found ||= 0
  green_found = green
  green_found ||= 0
  alpha_found = alpha
  alpha_found ||= 0
  $document[id].inner_html = "\n.#{id}{background-color: rgba(#{red_found * 255},#{green_found * 255},#{value * 255},#{alpha_found})}\n"
end
Genesis.generate_html_renderer(:alpha) do |value, atome, proc|
  red_found = red
  red_found ||= 0
  green_found = green
  green_found ||= 0
  blue_found = blue
  blue_found ||= 0
  $document[id].inner_html = "\n.#{id}{background-color: rgba(#{red_found * 255},#{green_found * 255},#{blue_found * 255},#{value})}\n"
end


Genesis.generate_html_renderer(:shadow) do |value, atome, proc|
  alert " now treat this: #{value}, #{atome}"
  # instance_exec(&proc) if proc.is_a?(Proc)
  # @html_type = :style
  # # we remove previous unused style tag
  # $document[id].remove if $document[id]
  # $document.head << DOM("<style atome='#{type}'  id='#{id}'></style>")
end

Genesis.generate_html_renderer(:drm)

Genesis.generate_html_renderer(:parent) do |values, atome, proc|
  instance_exec(&proc) if proc.is_a?(Proc)
  values.each do |value|
    atome.html_decision(@html_type, value, id)
  end
end



Genesis.generate_html_renderer(:id) do |value, atome, proc|
  # send("#{value}_html", value, atome, proc)
end

Genesis.generate_html_renderer(:left) do |value, atome, proc|
  @html_object.style[:left] = "#{value}px" unless @html_type == :style
end

Genesis.generate_html_renderer(:right) do |value, atome, proc|
  @html_object.style[:right] = "#{value}px" unless @html_type == :style
end

Genesis.generate_html_renderer(:top) do |value, atome, proc|
  @html_object.style[:top] = "#{value}px" unless @html_type == :style
end

Genesis.generate_html_renderer(:bottom) do |value, atome, proc|
  @html_object.style[:bottom] = "#{value}px" unless @html_type == :style
end

Genesis.generate_html_renderer(:width) do |value, atome, proc|
  @html_object.style[:width] = "#{value}px" unless @html_type == :style
end

Genesis.generate_html_renderer(:height) do |value, atome, proc|
  @html_object.style[:height] = "#{value}px" unless @html_type == :style
end

Genesis.particle_creator(:rotate)

Genesis.generate_html_renderer(:rotate) do |value, atome, proc|
  @html_object.style[:transform] = "rotate(#{value}deg)" unless @html_type == :style
end

Genesis.generate_html_renderer(:smooth) do |value, atome, proc|
  formated_params = case value
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
  @html_object.style['border-radius'] = formated_params unless @html_type == :style
end

Genesis.generate_html_renderer(:touch) do |value, atome, proc|
  @html_object.on :click do |e|
    instance_exec(&proc) if proc.is_a?(Proc)
  end
end

Genesis.generate_html_renderer(:video) do |value, atome, proc|
  id_found = id
  instance_exec(&proc) if proc.is_a?(Proc)
  DOM do
    video({ id: id_found, autoplay: true ,loop: false, muted: true }).atome
  end.append_to($document[:user_view])
  @html_object = $document[id_found]
  @html_type = :video
end

# overflow
Genesis.particle_creator(:overflow)
Genesis.generate_html_renderer(:overflow) do |value, atome, proc|
  @html_object.style[:overflow] = value unless @html_type == :style
end

Genesis.particle_creator(:bloc)

# image

Genesis.atome_creator(:image) do |params, &proc|
  # todo:  factorise code below
  if params
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "image_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id
    default_params = { render: [generated_render], id: generated_id, type: :image, parent: [generated_parent],
                       path: './medias/images/atome.svg',  width: 199, height: 199 }
    params = default_params.merge(params)
  end
  params
end

Genesis.generate_html_renderer(:image) do |value, atome, proc|
  id_found = id
  instance_exec(&proc) if proc.is_a?(Proc)
  DOM do
    img({ id: id_found }).atome
  end.append_to($document[:user_view])
  @html_object = $document[id_found]
  @html_type = :image
end

# text

Genesis.atome_creator(:text) do |params|
  # TODO: factorise code below
  if params
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "text_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    default_params = { render: [generated_render], id: generated_id, type: :text, parent: [generated_parent],
                       visual: { size: 33 }, data: "hello world",
                       color: { render: [generated_render], id: "color_#{generated_id}", type: :color,
                                red: 0.3, green: 0.3, blue: 0.3, alpha: 1 }
    }
    params = default_params.merge(params)
    params
  end
  # params
end
Genesis.particle_creator(:string)

Genesis.particle_creator(:visual)
Genesis.generate_html_renderer(:visual) do |value, atome, proc|
  @html_object.style['font-size'] = "#{value[:size]}px"
end

Genesis.generate_html_renderer(:text) do |value, atome, proc|
  id_found = id
  instance_exec(&proc) if proc.is_a?(Proc)
  DOM do
    div(id: id_found).atome.text
  end.append_to($document[:user_view])
  @html_object = $document[id_found]
  @html_type = :text
end

# particles method below to allow to retrieve all particles for an atome
Genesis.particle_creator(:particles)
Genesis.atome_creator_option(:particles_getter_pre_proc) do |params|
  atome_found = params[:atome]
  particles_hash = {}
  atome_found.instance_variables.each do |particle_found|
    particle_content = atome_found.instance_variable_get(particle_found)
    particles_hash[particle_found.sub('@', '')] = particle_content
  end
  particles_hash
end

# link
Genesis.particle_creator(:link)
Genesis.atome_creator_option(:link_pre_render_proc) do |params|
  atome_found = params[:atome]
  atome_to_link = grab(params[:value])
  particles_found = atome_to_link.particles
  atome_type = particles_found.delete(:type)
  sanitized_particles = {}
  particles_found.each do |particle_name, value|
    particle_name = particle_name.gsub('@', '')
    sanitized_particles[particle_name] = value
  end
  sanitized_particles[:parent] = [atome_found.id]
  atome_found.send(atome_type, sanitized_particles)
  params[:value]
end
Genesis.atome_creator(:web)
Genesis.particle_creator(:path)
Genesis.generate_html_renderer(:path) do |value, atome, proc|
  @html_object[:src] = value
end

Genesis.generate_html_renderer(:web) do |value, atome, proc|
  id_found = id
  instance_exec(&proc) if proc.is_a?(Proc)
  DOM do
    iframe({ id: id_found }).atome
  end.append_to($document[:user_view])
  @html_object = $document[id_found]
  @html_object.attributes[:allow] = 'accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture'
  @html_object.attributes[:allowfullscreen] = true
  @html_type = :web
end

Genesis.particle_creator(:data)

Genesis.generate_html_renderer(:data) do |value, atome, proc|
  # TODO: create a method for each type
  send("#{type}_data", value)
end

Genesis.particle_creator(:code)
Genesis.atome_creator_option(:code_pre_render_proc) do |params|
  def get_binding
    binding
  end

  str = params[:value][:code]
  eval str, get_binding, __FILE__, __LINE__
  params[:value]
end
Genesis.particle_creator(:on)

Genesis.generate_html_renderer(:on) do |value, atome, proc|
  @html_object.on(value) do |e|
    instance_exec(e, &proc) if proc.is_a?(Proc)
  end
end

Genesis.atome_creator_option(:shape_post_save_proc) do |params|
  current_atome = params[:atome]
  #FIXME: look why we have to look in [:value][:value] this looks suspect
  bloc_found = params[:value][:value][:bloc]
  current_atome.instance_exec(params, &bloc_found) if bloc_found.is_a?(Proc)
  params
end

Genesis.atome_creator_option(:text_post_save_proc) do |params|
  current_atome = params[:atome]
  #FIXME: look why we have to look in [:value][:value] this looks suspect
  bloc_found = params[:value][:value][:bloc]
  current_atome.instance_exec(params, &bloc_found) if bloc_found.is_a?(Proc)
  params
end

Genesis.atome_creator_option(:play_pre_render_proc) do |params|
  params[:atome].send("play_#{params[:atome].type}", params)
end

Genesis.atome_creator_option(:pause_pre_render_proc) do |params|
  params[:atome].send("pause_#{params[:atome].type}", params)
  proc_found = params[:proc]
  params[:atome].instance_exec('::call back from pause render', &proc_found) if proc_found.is_a?(Proc)
end

Genesis.generate_html_renderer(:time) do |value, atome, proc|
  # params[:atome].html_object.currentTime= 33
  @html_object.currentTime = value
end

#drag
Genesis.generate_html_renderer(:drag) do |value, atome, proc|
  alert ("this is very strange that I had a style tag please check")
  instance_exec(&proc) if proc.is_a?(Proc)
  @html_type = :style
  $document.head << DOM("<style atome='#{type}' id='#{id}'></style>")
end
Genesis.particle_creator(:lock)
Genesis.particle_creator(:target)
Genesis.atome_creator(:drag) do |params|
  # TODO: factorise code below
  if params
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "drag_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id
    default_params = { render: [generated_render], id: generated_id, type: :drag, parent: [generated_parent], target: [generated_parent]
    }
    params = default_params.merge(params)
    params
  end
  params
end
Genesis.particle_creator(:remove)
Genesis.particle_creator(:fixed)
Genesis.particle_creator(:max)
Genesis.particle_creator(:inside)
Genesis.atome_creator_option(:remove_pre_render_proc) do |params|
  type_found = params[:atome].type
  current_atome = params[:atome]
  particle_to_remove = params[:value]
  current_atome.send("#{type_found}_remove_#{particle_to_remove}", current_atome)
end
Genesis.atome_creator_option(:max_pre_render_proc) do |params|
  current_atome = params[:atome]
  current_atome.constraint_helper(params, current_atome, :max)
end
Genesis.atome_creator_option(:inside_pre_render_proc) do |params|
  current_atome = params[:atome]
  params[:value] = grab(params[:value]).html_object
  current_atome.constraint_helper(params, current_atome, :max)
end
Genesis.atome_creator_option(:lock_pre_render_proc) do |params|
  current_atome = params[:atome]
  current_atome.constraint_helper(params, current_atome, :lock)
end
Genesis.atome_creator_option(:fixed_pre_render_proc) do |params|
  current_atome = params[:atome]
  current_atome.constraint_helper(params, current_atome, :fixed)
end
Genesis.generate_html_renderer(:target) do |targets, atome, proc|
  targets.each do |value|
    atome_found = grab(value)
    # we get the id of the drag and ad add it as a html class to all children so they become draggable
    atome_found.html_object.add_class(id)
  end
  html_drag_helper(atome, {})
end

