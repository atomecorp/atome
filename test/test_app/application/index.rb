# frozen_string_literal: true

# document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor = 'red'
# alert(document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor)

# TODO : add a global sanitizer
# TODO : look why get_particle(:children) return an atome not the value
# TODO : create color JS for Opal?
generator = Genesis.generator

generator.build_particle(:drag)
generator.build_particle(:remove)

generator.build_render_method(:html_drag) do |options, proc|
  puts "options are #{options}"
  @html_object[:draggable]=true
  # @html_object.poil("toto")
  @html_object.on :drag do |e|
    instance_exec(&proc) if proc.is_a?(Proc)
  end
end

# box({width: 333, height: 333, id: :the_constraint_box, color: :orange})

b = box do
  alert  "kito"
end

# cc=box.bloc.value
# alert cc
b.drag({ remove: true }) do |position|
  # below here is the callback :
  puts "1 - callback drag position: #{position}"
  puts "1 - callback id is: #{id}"
end

# wait 4 do
#   b.drag({ max: { left: 333 ,right: 90, top: 333, bottom: 30}})
# end
#
# bb = box({ left: 120, color: :green })
# bb.touch(true) do
#   puts left
# end
#
# bb.drag({ lock: :x }) do |position|
#   # below here is the callback :
#   puts "2 - drag position: #{position}"
#   puts "2 - id is: #{id}"
# end
# #TODO: when we add a color we must change the code : do we create a new color with it's id or do we replace the old one?
#
# bbb = box({ left: 120, top: 120 })
# bbb.drag({}) do |position|
#   # below here is the callback :
#   puts "bbb drag position: #{position}"
#   puts "bbb id is: #{id}"
# end
# bbb.color(:black)
#
# bbb.remove(:drag)
# wait 3 do
#   bbb.drag({fixed: true}) do |position|
#     puts position
#   end
# end
#
# circle({drag: {inside: :the_constraint_box}, color: :red})




# Atome.new(
#   shape: { render: [:html], id: :the_shape2, type: :shape, parent: [:view],children: [],
#            left: 99, right: 99, width: 99, height: 99,
#            color: { render: [:html], id: :c31, type: :color, parent: [:the_shape2],children: [],
#                     red: 1, green: 0.15, blue: 0.15, alpha: 0.6 } }
# ) do
#   alert :kool
# end