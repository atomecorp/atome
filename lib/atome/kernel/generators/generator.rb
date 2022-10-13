# frozen_string_literal: true

# generators
Genesis.atome_creator(:shape) do
  # puts "and now!!! "
end
Genesis.atome_creator(:image) do
end
Genesis.atome_creator(:shadow)
# Genesis.atome_creator(:additional)
Genesis.atome_creator(:content)

Genesis.atome_creator(:color)
Genesis.atome_creator(:shadow)

# Example below

# Genesis.atome_creator(:color) do |params|
  #   # puts "extra color code executed!! : #{params}"
  # end
# Genesis.atome_creator_option(:color_pre_save_proc) do |params|
#   puts "The params are : #{params}\n"
# end
#
# Genesis.atome_creator_option(:color_post_save_proc) do
#   # puts "optional color_post_save_proc\n"
# end
#
# Genesis.atome_creator_option(:color_pre_render_proc) do
#   # puts "optional color_pre_render_proc\n"
# end
#
# Genesis.atome_creator_option(:color_post_render_proc) do
#   # puts "optional color_post_render_proc\n"
# end
#
# Genesis.atome_creator_option(:color_getter_pre_proc) do
#   # puts "optional color_getter_pre_proc\n"
# end

Genesis.particle_creator(:id) do
end
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
Genesis.atome_creator_option(:type_pre_render_proc) do |params|
  "it works and get #{params}"
end

# important exemple below how to prevent rendering
# Genesis.atome_creator_option(:top_render_proc) do |params|
#   puts "====---> Hurrey no rendering :  #{params}"
# end

Genesis.particle_creator(:render)
Genesis.particle_creator(:drm)
Genesis.particle_creator(:parent)
Genesis.particle_creator(:date)
Genesis.particle_creator(:location)



# generate renderers

Genesis.generate_html_renderer(:type) do |value, atome, proc|
  send("#{value}_html", value, atome, proc)
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
  $document.head << DOM("<style id='#{id}'></style>")
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

Genesis.generate_html_renderer(:drm) do |value, atome, proc|
  # instance_exec(&proc) if proc.is_a?(Proc)
end

Genesis.generate_html_renderer(:parent) do |value, atome, proc|
  instance_exec(&proc) if proc.is_a?(Proc)
  if @html_type == :style
    $document[value].add_class(id)
  else
    @html_object.append_to($document[value])
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
