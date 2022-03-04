module PropertyHtml
  def tactile_html(value)
    value
  end

  def wait_html(seconds, &proc)
    seconds = seconds.to_f
    set_timeout(seconds, &proc)
  end

  def schedule_html(years, months, days, hours, minutes, seconds, &proc)
    js_schedule(years, months, days, hours, minutes, seconds, &proc)
  end

  def repeat_html(delay = 1, repeat = à, &proc)
    if delay.instance_of?(Hash)
      repeat = delay[:times]
      delay = delay[:every]
    end
    # below we exec the call a first time
    proc.call
    # as we exec one time above we subtract one below
    unless repeat == 0
      repeat = repeat - 1
    end
    set_interval(delay, repeat, &proc)
  end

  def clear_wait_html(value)
    clear_timeout(value)
  end

  def clear_repeat_html(value)
    clear_interval(value)
  end

  def display_html(value)
    # The display api @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&    jhfgerggru is used both to view special items and or prevent the display
    case value
    when ->(h) { h[:value] == false }
      jq_get(atome_id).css(display: :none)
    when ->(h) { h[:value] == true }
      jq_get(atome_id).css(display: :block)
    when :none
      jq_get(atome_id).css(display: :none)
    when :vr
      # path = $images_list[content][:path]
      path = Universe.images[content][:path]
      jq_get(atome_id).css("background", "transparent")
      jq_get(atome_id).append("<a-scene className='aframebox' embedded vr-mode-ui='enabled': false device-orientation-permission-ui='enabled: false'> <a-sky src='" + path + "' rotation='0 -130 0'></a-sky></a-scene>")
    end
  end

  def fullscreen_html (value)
    element = if type == :video
                Element.find("##{atome_id} video")
              else
                jq_get(atome_id)
              end
    alert  "fullscreen_html: #{value}"
    JSUtils.js_fullscreen(element, value[value])
  end

  def reboot_html
    JSUtils.reboot
  end

end
