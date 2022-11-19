# frozen_string_literal: true

# document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor = 'red'
# alert(document.getElementById('color_the_box').sheet.cssRules[0].style.backgroundColor)

# TODO : add a global sanitizer
# TODO : look why get_particle(:children) return an atome not the value

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
  puts "kito"
end

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
