# JSUtils.load_opal_parser
# def run_demo(path)
#   clear(:view)
#   ATOME.reader(path) do |data|
#     compile data
#   end
# end
#
# def demo_navigator(demo_list, index)
#   grab(:demo_list).delete
#   grab(:demo_back).delete
#   grab(:demo_prev).delete
#   grab(:demo_next).delete
#   text({ content: "#{index} : " + demo_list.keys[index], color: :white, fixed: true, yy: 3, xx: 3, atome_id: :demo_list, visual: {alignment: :right}  })
#   next_example = demo_list.keys[index + 1]
#   previous_example = demo_list.keys[index - 1]
#   back = text({ content: :demos, xx: 20, z: 300, parent: :intuition, atome_id: :demo_back, visual: {alignment: :right} })
#   back.touch do
#     # we clear the buffer to avoid treatment on no more existent atome
#     grab(:buffer).content[:resize]=[]
#     demo_reel(demo_list)
#   end
#
#   unless index == 0
#     index = index - 1
#     previous_demo = text(content: :previous, y: 33, xx: 20, z: 300, parent: :intuition, atome_id: :demo_prev, visual: {alignment: :right} )
#     previous_demo.touch do
#       # we clear the buffer to avoid treatment on no more existent atome
#       grab(:buffer).content[:resize]=[]
#       path = demo_list[previous_example]
#       run_demo(path)
#       demo_navigator(demo_list, index - 1)
#     end
#   end
#
#   unless demo_list.length == index + 1
#     index = index + 1
#     next_demo = text({ content: :next, y: 69, xx: 20, parent: :intuition , atome_id: :demo_next, visual: {alignment: :right}  })
#     next_demo.touch do
#       # we clear the buffer to avoid treatment on no more existent atome
#       grab(:buffer).content[:resize]=[]
#       path = demo_list[next_example]
#       run_demo(path)
#       demo_navigator(demo_list, index + 1)
#     end
#   end
#   text({ content: demo_list[index], color: :white })
# end
#
# def demo_reel(demo_list)
#   require "./www/public/medias/app/scripts/background.rb"
#   bluegreen_gradient=[ { red: 0.3, green: 0.1, blue: 0.9 },{ red: 0.3, green: 0.1, blue: 0.6 }]
#   Background.theme(bluegreen_gradient)
#   clear(:view)
#   sorted_list=demo_list.sort
#   sorted_list.each_with_index do |demo, index|
#     the_code = text({ content: "#{index} : " + demo[0], y: 20 * index,  visual: {alignment: :left, size: 15} })
#     the_code.touch do
#       run_demo(demo[1])
#       demo_navigator(demo_list, index)
#     end
#   end
# end
#
# ATOME.reader("./medias/rubies/examples/!demos.rb") do |data|
#   demos = compile(data)
#     demo_reel(demos)
# end
#
############ new code below

require "./www/public/medias/app/scripts/background.rb"
bluegreen_gradient = [{ red: 0.3, green: 0.1, blue: 0.9 }, { red: 0.3, green: 0.1, blue: 0.6 }]
Background.theme(bluegreen_gradient)

JSUtils.load_opal_parser

def run_demo(path)
  clear(:view)
  ATOME.reader(path) do |data|
    compile data
  end
end

demo_container = grab(:intuition).box({ yy: 0, color: { alpha: 0.3 }, width: 120, height: 399 , overflow: :scroll })
demo_container.touch do
  if self.height == 66
    self.height(333)
  else
    self.height(66)
  end
end

ATOME.reader("./medias/rubies/examples/!demos.rb") do |data|
  demos = compile(data)
  demos.keys.each_with_index do |demo_title, index|
    title = demo_container.text ({content: index.to_s+" - "+demo_title, visual: 12})
    title.y = index * 24 + 12
    title.touch(stop: true) do
      self.color(:red)
      run_demo demos[demo_title]
      demo_container.height(66).x(0).yy(00)
    end
  end
end
