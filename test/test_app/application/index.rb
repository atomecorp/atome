# animation atome
Genesis.atome_creator(:animation)
Genesis.generate_html_renderer(:animation) do |value, atome, proc|
  id_found = id
  instance_exec(&proc) if proc.is_a?(Proc)
  DOM do
    div(id: id_found)
  end.append_to($document[:user_view])
  @html_object = $document[id_found]
  @html_type = :div
end
Genesis.particle_creator(:code)
Genesis.generate_html_renderer(:code) do |value, atome, proc|
  # alert proc
  # @html_object << value
end
Genesis.particle_creator(:target) do |params|
  # alert params
end

Genesis.particle_creator(:bloc)
Genesis.atome_creator_option(:bloc_pre_render_proc) do |params|
  proc_found = params[:value][:bloc]
  instance_exec(&proc_found) if proc_found.is_a?(Proc)

  params[:value]
end
Genesis.generate_html_renderer(:target) do |value, atome, proc|
  @html_object
end
# Genesis.generate_html_renderer(:bloc) do |value, atome, proc|
#   # alert value
#
# end

# Anim verif
animation = Atome.new(
  animation: { render: [:html], id: :anim1, type: :animation, parent: [:view], target: :image1, code: "alert :web", left: 333, top: 333, width: 199, height: 99,
  }
) do
  puts " proc exec added at atome creation level : #{self.class}"
end
# alert animation.inspect

# TODO: insert html elements

#TODO int8!



# def web_iframe(adress)
#
# end
# def web(value, password = nil)
#
#   if value.instance_of?(Hash)
#     if value[:type]
#       type_found = value[:type]
#       case type_found
#         #Time.now is used to force refresh if the image changes
#       when :iframe
#         value = "<iframe class='atome' width='100%' height='180%' src='#{value[:path]}?#{Time.now}' frameborder='5' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen/>"
#       when :image
#         #Time.now is used to force refresh if the image changes
#         value = "<image class='atome' width ='100%' height= '100%' src='#{value[:path]}?#{Time.now}'/>"
#       when :audio
#       when :video
#       else
#         value = "<iframe class='atome' width='100%' height='180%' src='#{value[:path]}?#{Time.now}' frameborder='5' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen/>"
#       end
#       media_pre_processor(:web, :web, value, password)
#     elsif value[:address]
#       JSUtils.adress(value[:address])
#     else
#     end
#
#   end
#
# end
#
# m web({type: :iframe, path: "https://www.youtube.com/embed/usQDazZKWAk" })
# web({ type: :image, path: "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg" })


# Genesis.particle_creator(:smooth)
