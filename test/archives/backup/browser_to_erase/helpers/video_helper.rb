# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  # video
  def self.browser_left_video(value, browser_object, _atome)
    browser_object.style[:left] = "#{value}px"
  end

  def self.browser_right_video(value, browser_object, _atome)
    browser_object.style[:right] = "#{value}px"
  end

  def self.browser_top_video(value, browser_object, _atome)
    browser_object.style[:top] = "#{value}px"
  end

  def self.browser_bottom_video(value, browser_object, _atome)
    browser_object.style[:bottom] = "#{value}px"
  end

  def self.browser_path_video(value, browser_object, _atome)
    browser_object[:src] = value
  end

  def self.browser_play_video(_value, browser_object_found, atome_hash, atome_object, proc)
    markers = atome_hash[:markers] ||= {}
    markers.each_value do |value|
      value[:end] = value[:begin] + 0.25 unless value[:end]
      value[:label] = "label_#{atome_hash[:markers].length}" unless value[:label]
    end

    browser_object_found.play
    # TODO : change timeupdate for when possible requestVideoFrameCallback
    # (opal-browser/opal/browser/event.rb line 36)
    video_callback = atome_hash[:code] # this is the video callback not the play callback
    play_callback = proc # this is the video callback not the play callback

    browser_object_found.on(:timeupdate) do |e|
      current_time = browser_object_found.currentTime
      # we update the time particle
      atome_object.time_callback(current_time, markers)
      e.prevent # Prevent the default action (eg. form submission)
      # You can also use `e.stop` to stop propagating the event to other handlers.
      atome_object.instance_exec(current_time, &video_callback) if video_callback.is_a?(Proc)
      atome_object.instance_exec(current_time, &play_callback) if play_callback.is_a?(Proc)
    end
  end

end
