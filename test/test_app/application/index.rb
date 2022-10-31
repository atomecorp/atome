# # TODO: when using Rake the atomejs and others are rebuild iun test application
# # TODO : maybe revert default renderer to headless instead of html
# # TODO : over
# # TODO :shadow
# #TODO : text align
# #TODO : audio objct
# # ###################### animation tests
# #
# # Genesis.atome_creator(:animator)
# # Genesis.generate_html_renderer(:animator) do |value, atome, proc|
# #   id_found = id
# #   instance_exec(&proc) if proc.is_a?(Proc)
# #   DOM do
# #     div(id: id_found)
# #   end.append_to($document[:user_view])
# #   @html_object = $document[id_found]
# #   @html_type = :div
# # end
# #
# #
# #
# #
# # Genesis.particle_creator(:target) do |params|
# #   # alert params
# # end
# #
# # Genesis.generate_html_renderer(:target) do |value, atome, proc|
# #   @html_object
# # end
# #
# #
# #
# # def animation(params = {}, &proc)
# #   Utilities.grab(:view).animation(params, &proc)
# # end
# #
# #
# # class Atome
# #
# #   def animation(params = {}, &proc)
# #     generated_id = params[:id] || "animation_#{Universe.atomes.length}"
# #     generated_parent = params[:parent] || id
# #
# #     temp_default = { id: generated_id, type: :animator, parent: [generated_parent], bloc: proc }
# #     params = temp_default.merge(params)
# #     # alert params
# #     new_atome = Atome.new({ animator: params })
# #     new_atome.animator
# #   end
# #
# #   def play_animator(params)
# #     "I play the animation : #{params}"
# #     exec_found = params[:atome].bloc
# #     instance_exec('::callback from anim player', &exec_found) if exec_found.is_a?(Proc)
# #   end
# # end
# #
# # ######################################
# # # Anim verif
# #
# # anim1 = {
# #   start: { smooth: 0, blur: 0, rotate: 0, color: { red: 1, green: 1, blue: 1 } },
# #   end: { smooth: 25, rotate: 180, blur: 20, color: { red: 1, green: 0, blue: 0 } },
# #   duration: 1000,
# #   loop: 1,
# #   curve: :easing,
# #   target: :my_shape
# # }
# # my_anim = animation({ data: anim1, id: :my_animation }) do |params|
# #   puts "animation params callback is : #{params} #{self.id}"
# # end
# # my_anim.play(true)
# # alert my_anim
# #
# # my_animation = Atome.new(
# #   animator: { render: [:html], id: :anim12, type: :animator, parent: [:view], target: :image1, data: anim1, left: 333, top: 333, width: 199, height: 99,
# #   }
# # # animator: { render: [:html], id: :anim1, type: :animator, parent: [:view], target: :image1, code: "alert :web", left: 333, top: 333, width: 199, height: 99,
# # # }
# # ) do
# #   puts "non proc exec added at atome creation level : #{self.class}"
# # end
# ############# Drag ###########

$window.on :resize do |e|
  puts $window.view.height
end

# TODO: when we add a color we must change the code : do we create a new color with it's id or do we replace the old one?
# TODO: gem install webrick  ; ruby -run -e httpd . -p 8080
# TODO: new id Scheme base on id, with verification if already exist
# FIXME : if we change the id, changing the color crash
# TODO : maybe add Shape, text, Image, etc.. Classes to simplify type exeption methods
# TODO : maybe add Genesis as an atome module to be in the context of the atome to simplify and accelerate methods treatment

#
# my_video=video({ path: "./medias/videos/madmax.mp4", left: 6, top: 120, width: 666, height: 666})
# my_video.touch(true) do
#   my_video.play(true)
# end

class Atome
  def color_sanitizer(params)
    if params.instance_of? Hash and color.nil?
      default_color = { red: 0, green: 0, blue: 0, alpha: 1 }
      params.merge!(default_color)
      params
    elsif params.instance_of? Hash
      params.each do |particle, value|
        send(:color, particle, value)
      end
    else
      if RUBY_ENGINE.downcase == 'opal'
        rgb_color = `d = document.createElement("div");
	                   d.style.color = #{params};
	                   document.body.appendChild(d)
                     rgb_color=(window.getComputedStyle(d).color);
                     d.remove();
                     `
        color_converted = { red: 0, green: 0, blue: 0, alpha: 1 }
        rgb_color.gsub("rgb(", "").gsub(")", "").split(",").each_with_index do |component, index|
          color_converted[color_converted.keys[index]] = component.to_i / 255
        end
      else
        rgb_color = Color::CSS["red"].css_rgb
        color_converted = { red: 0, green: 0, blue: 0, alpha: 1 }
        rgb_color.gsub("rgb(", "").gsub(")", "").gsub("%", "").split(",").each_with_index do |component, index|
          component = component.to_i / 100
          color_converted[color_converted.keys[index]] = component
        end
      end
      params = { render: [:html], id: "color_#{id}", type: :color }.merge(color_converted)
    end
    params
  end

end

Genesis.atome_creator_option(:color_sanitizer_proc) do |params, atome|
  params = atome.send(:color_sanitizer, params)
  params
end

c = circle


# the most performant way :
wait 1 do
  c.color(
    { render: [:html], id: :c319, type: :color,
      red: 1, green: 1, blue: 0.15, alpha: 0.6 }
  )
end

wait 2 do
  # now we overload the color
  c.color({ red: 1 })
end

wait 4 do
  # now the easy way
  c.color(:yellow)
end
# please note that render , id and type params must place in order

# box({left: 99, top: 99, shadow:{blur: 9, left: 3, top: 3, color: :black}})
# box({left: 99, top: 99, shadow: :black})
image({ path: "./medias/images/moto.png", left: 33, bottom: 33 })

