# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:html_shape) do
  current_atome = @atome
  id_found = current_atome[:id]
  DOM do
    div(id: id_found).atome
  end.append_to($document[:user_view])
  @html_object = id_found
  @html_type = :div
end
generator.build_render_method(:html_color)

generator.build_render_method(:html_image) do |_user_prc|
  current_atome = @atome
  id_found = current_atome[:id]
  DOM do
    div(id: id_found).atome
  end.append_to($document[:user_view])
  # @html_object = $document[id_found]
  @html_object = id_found
  @html_type = :div
end
# generator.build_render_method(:html_color) do |params|
#   user_proc = params[:bloc]
#   instance_exec(&user_proc) if user_proc.is_a?(Proc)
#   puts "the html color render params is #{params}"
# end
generator.build_atome(:html_shadow)

generator.build_render_method(:html_type) do |params, user_proc|
  # current_atome = @atome
  # puts "=> #{params}, #{user_proc}"
  # id_found = current_atome[:id]
  # puts "id is #{id_found}"
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
  send("html_#{params}", user_proc)
end
