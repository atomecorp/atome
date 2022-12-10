# frozen_string_literal: true

# markers
generator = Genesis.generator

module BrowserHelper
  def self.browser_play_video(_value, browser_object_found, atome_hash, atome_object, proc)
    sorted_markers={}
    atome_hash[:markers].each do |id, params|
      locator=params[:time]
      action=params[:code]
      name=params[:code]
      sorted_markers[locator]={code: action, id: id, label: name}
    end if atome_hash[:markers]
    sorted_markers=sorted_markers.sort.to_h
    browser_object_found.play
    # TODO : change timeupdate for when possible requestVideoFrameCallback
    # (opal-browser/opal/browser/event.rb line 36)
    video_callback = atome_hash[:code] # this is the video callback not the play callback
    play_callback = proc # this is the video callback not the play callback

    browser_object_found.on(:timeupdate) do |e|
      current_time = browser_object_found.currentTime
      # we update the time particle
      atome_object.time_callback(current_time,sorted_markers)
      e.prevent # Prevent the default action (eg. form submission)
      # You can also use `e.stop` to stop propagating the event to other handlers.

      atome_object.instance_exec(current_time, &video_callback) if video_callback.is_a?(Proc)
      atome_object.instance_exec(current_time, &play_callback) if play_callback.is_a?(Proc)
    end
  end

end

my_video = Atome.new(
  video: { renderers: [:browser], id: :video1, type: :video, parents: [:view], clones: [],
           path: './medias/videos/avengers.mp4', left: 333, top: 33, width: 777
  }
) do |p|

end

my_video.touch(true) do
  my_video.play(10)
  # my_video.atome[:pause]="lkjlkjn"
  alert my_video.play
  alert my_video.pause
end


# @counter = 0
# my_video.at({ time: 15 }) do |value|
#   # my_video.pause(true)
#   if @counter
#     puts "ok : #{@counter}"
#   else
#     @counter = 0
#   end
#   # puts "#{15}"
#   puts "value is : #{value} : counter : #{@counter}"
#   puts "---- #{my_video.time}-----"
#   my_video.play(15+(@counter*1))
#   # my_video.play() do |val|
#   #   puts val
#   # end
#
#   @counter = @counter + 1
#   @at_time[:used] = false
# end

# my_video.at({ time: 18 }) do |value|
#   # my_video.pause(true)
#   puts :kool
# end

# frozen_string_literal: true



# generator.build_particle(:markers)
generator.build_particle(:markers, :hash)

generator.build_option(:pre_render_markers) do |markers, _user_proc|
  markers.each do |marker, value|
    atome[:markers][marker] = value
  end
end

class Atome
  def add_to_hash(particle, values, &user_proc)
    # we update  the holder of any new particle if user pass a bloc
    store_code_bloc(particle, &user_proc) if user_proc
    values.each do |value_id, value|
      @atome[particle][value_id] = value
    end
  end

  def add_to_array(particle, value, &_user_proc)
    # we update  the holder of any new particle if user pass a bloc
    @atome[particle] << value
  end

  def add(particles, &user_proc)
    particles.each do |particle, value|
      particle_type = Universe.particle_list[particle]
      send("add_to_#{particle_type}", particle, value, &user_proc)
    end
  end

  def time_callback(current_time,sorted_markers)
    # puts "time_callback = #{current_time.round(1)}\n#{current_time}"
    @atome[:time] = current_time
    # the line below is used only to set up a one shot event
    # return unless @at_time[:time] && (current_time > @at_time[:time] && @at_time[:used].nil?)
    if sorted_markers.keys[0] && current_time >sorted_markers.keys[0]
      code_found=sorted_markers[sorted_markers.keys[0]][:code]
     instance_exec(current_time, &code_found) if code_found.is_a?(Proc)

     sorted_markers.shift
    end

    return unless @at_time[:time] && (current_time > @at_time[:time])
    proc = @at_time[:code]
    instance_exec(current_time, &proc) if proc.is_a?(Proc)
    # @at_time[:used] = true
  end
end


my_lambda = lambda do |val|
  puts "hello : #{val}"
end
my_lambada = lambda do |val|
  puts "hi there : #{val}"
end

my_lambada2 = lambda do |val|
  puts "Super!! : #{val}"
end
##############
my_video.markers({ m1: { time: 18, code: my_lambda } }) do |_params|
  puts 'stop'
end

my_video.markers({ m2: { time: 12.87576, code: my_lambda } }) do |_params|
  puts'good'
end

my_video.add({ markers: { m3: { time: 16.87576, code: my_lambada } } }) do |_params|
  puts :goody
end
my_video.add({ markers: { m4: { time: 14.87576, code: my_lambada2 } } }) do |_params|
  puts :goody
end

my_lambda.call(:jeezs)



my_video.left(33)
code2 = my_video.markers.value[:m3][:code]
instance_exec(:bigjeezs, &code2) if code2.is_a?(Proc)

proc_passed = my_video.instance_variable_get("@markers_code")
instance_exec(:bigjeezs, &proc_passed) if proc_passed.is_a?(Proc)
################@
# puts "my vid = > #{code2}"
# puts my_video.instance_variables
# puts "=> #{my_video}"
# puts my_video
# wait 0.3 do
#   `console.clear()`
#   b=box
#   b.text({data: :hello})
#
#
# end

