# frozen_string_literal: true

# document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor = 'red'
# alert(document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor)

# TODO : add a global sanitizer
# TODO : look why get_particle(:children) return an atome not the value

generator = Genesis.generator

# generator.build_particle(:clear)

# generator.build_render_method(:html_clear) do
#   @atome[:children].each do |child_found|
#     grab(child_found).html_object&.remove
#   end
#   children([])
# end

# box(id: :my_box)
#
# circle(left: 333)
#
# wait 2 do
#   grab(:view).clear(true)
# end
