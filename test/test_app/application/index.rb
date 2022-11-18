# frozen_string_literal: true
# class Atome
#   def clear
#     # alert self
#     # child.each do |child_found|
#     #   # grab(child_found).html_object&.remove
#     # end
#     # child([])
#
#   end
# end
# class Atome
#   def box(params = {}, &bloc)
#     default_renderer = Sanitizer.default_params[:render]
#
#     generated_id = params[:id] || "box_#{Universe.atomes.length}"
#     generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
#     generated_parent = params[:parent] || id.value
#
#     temp_default = { render: generated_render, id: :poil, type: :shape, parent: [generated_parent],
#                      width: 99, height: 99,
#                      color: { render: generated_render, id: "color_#{generated_id}", type: :color,
#                               parent: :poil, red: 0.69, green: 0.69, blue: 0.69, alpha: 1 }
#     }
#     params = temp_default.merge(params)
#     Atome.new({ shape: params }, &bloc)
#   end
#
#
# end
a = box({ id: :the_box })

wait 1 do
  a.left(333)
  # grab(:the_box).circle({ left: -320 })
  # a.circle({ left: -320 })
  # a.color({ render: [:html], id: "color_the_me", type: :color, parent: :the_box, red: 0.69, green: 0.69, blue: 0.69, alpha: 1 })
  # a.color.red(0)
  # alert a.color.id
end
puts "----------"
#
circle(left: 333)

# wait 0.5 do
#   grab(:view).clear
# end
# alert   grab(:view)
# alert Universe.atomes.keys
# alert Universe.renderer_list
# alert Universe.atome_list
# alert Universe.particle_list
# :atomes, :renderer_list, :atome_list
# Atome.new(
#   shape: { render: [:html], id: :my_box, type: :shape, parent: [:view], left: 99, right: 99, width: 99, height: 99,
#            color: { render: [:html], id: :c31, type: :color,parent: [:my_box],
#                     red: 1, green: 0.15, blue: 0.15, alpha: 0.6 }
#            }
# )
# vv=grab(:view)
# alert "#{grab(:the_box).parent}, #{grab(:the_box).parent.value.class}"
# alert Universe.atomes.keys
# alert "#{grab(:color_the_box).parent}, #{grab(:color_the_box).parent.value.class}"
# alert grab(:the_box).parent
# vv.children << a.id
# alert vv
# `
# document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor = 'red'
# alert(document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor)
#
# //cssRules
#
# `