# frozen_string_literal: true

# # # frozen_string_literal: true

# # # Done : when sanitizing property must respect the order else no browser
# object will be created, try to make it more flexible allowing any order
# # # TODO : add a global sanitizer
# # # TODO : look why get_particle(:children) return an atome not the value
# # # Done : create color JS for Opal?
# # # TODO : box callback doesnt work
# # # TODO : Application is minimized all the time, we must try to condition it
# # # TODO : A anew atome is created each time Genesis.generator is call, we better always use the same atome
# # # TODO : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# # # DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
# # # DONE : server crash, it try to use opal_browser_method

# ########## Drag to implement
# generator = Genesis.generator
# #
# # generator.build_particle(:drag)
# # generator.build_particle(:remove)
# #
# # generator.build_render_method(:html_drag) do |options, proc|
# #   puts "options are #{options}"
# #   @html_object[:draggable]=true
# #   @html_object.on :drag do |e|
# #     instance_exec(&proc) if proc.is_a?(Proc)
# #   end
# # end
# #
# box({width: 333, height: 333, id: :the_constraint_box, color: :orange})

# # b = box do
# #   alert  "hello"
# # end
# #
# # # cc=box.bloc.value
# # # alert cc
# # b.drag({ remove: true }) do |position|
# #   # below here is the callback :
# #   puts "1 - callback drag position: #{position}"
# #   puts "1 - callback id is: #{id}"
# # end
# #
# # # wait 4 do
# # #   b.drag({ max: { left: 333 ,right: 90, top: 333, bottom: 30}})
# # # end
# # #
# # # bb = box({ left: 120, color: :green })
# # # bb.touch(true) do
# # #   puts left
# # # end
# # #
# # # bb.drag({ lock: :x }) do |position|
# # #   # below here is the callback :
# # #   puts "2 - drag position: #{position}"
# # #   puts "2 - id is: #{id}"
# # # end
# # # #TODO: when we add a color we must change the code : do we create a new color
# # # #with it's id or do we replace the old one?
# # #
# # # bbb = box({ left: 120, top: 120 })
# # # bbb.drag({}) do |position|
# # #   # below here is the callback :
# # #   puts "bbb drag position: #{position}"
# # #   puts "bbb id is: #{id}"
# # # end
# # # bbb.color(:black)
# # #
# # # bbb.remove(:drag)
# # # wait 3 do
# # #   bbb.drag({fixed: true}) do |position|
# # #     puts position
# # #   end
# # # end
# # #
# # # circle({drag: {inside: :the_constraint_box}, color: :red})
#
# b = box({ id: :the_box, left: 99, top: 99 })

# b = box({ drag: true, left: 66, top: 66 })
# my_text = b.text({ data: 'drag the bloc behind me', width: 333 })
# wait 2 do
#   my_text.color(:red)
# end

# ############################
# def self.read_ruby(file)
#   # TODO write a ruby script that'll list and sort all files so they can be read
#   `
# fetch('medias/rubies/'+#{file})
#   .then(response => response.text())
#   .then(text => Opal.eval(text))
# `
# end
#
# def self.read_text(file)
#   `
# fetch('medias/rubies/'+#{file})
#   .then(response => response.text())
#   .then(text => console.log(text))
# `
# end
#
# def read(file, action=:text)
#   Internal.send("read_#{action}", file)
# end
#
#
# puts "Attention this method only work with a server due to security restriction "
# read('examples/image.rb')
# read('examples/image.rb')
# puts "----"
############# schedule
# generator = Genesis.generator


# generator.build_particle(:schedule) do |date, proc|
#   date = date.to_s
#   delimiters = [',', ' ', ':', '-']
#   format_date = date.split(Regexp.union(delimiters))
#   Universe.renderer_list.each do |renderer|
#     send("#{renderer}_schedule",format_date,&proc)
#   end
# end

# generator.build_render_method(:browser_schedule) do |format_date, proc|
#   years = format_date[0]
#   months = format_date[1]
#   days = format_date[2]
#   hours = format_date[3]
#   minutes = format_date[4]
#   seconds = format_date[5]
#   `atome.jsSchedule(#{years},#{months},#{days},#{hours},#{minutes},#{seconds},#{self},#{proc})`
# end


# class Atome
  # def schedule(date, &proc)
  #   date = date.to_s
  #   delimiters = [',', ' ', ':', '-']
  #   format_date = date.split(Regexp.union(delimiters))
  #   years = format_date[0]
  #   months = format_date[1]
  #   days = format_date[2]
  #   hours = format_date[3]
  #   minutes = format_date[4]
  #   seconds = format_date[5]
  #   `atome.jsSchedule(#{years},#{months},#{days},#{hours},#{minutes},#{seconds},#{self},#{proc})`
  # end

  # def schedule_callback(proc)
  #   instance_exec(&proc) if proc.is_a?(Proc)
  # end
# end

# date can be entered in  several ways , 2 digit it'll be the next time the seconds match ,
# if 2 digits the minutes and seconds and so on, you can also enter Time.now+3 (not a,string) for schedule in 3 sec

_alarm_format = '2022,11,27,12,06,0'
time_to_run = Time.now + 2
puts 'event schedule'
a = element

a.schedule(time_to_run) do
  alert 'event executed'
end
