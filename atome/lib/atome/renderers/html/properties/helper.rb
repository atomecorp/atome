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

  def repeat_html(delay = 1, repeat = 5, &proc)
    if delay.instance_of?(Hash)
      repeat = delay[:times]
      delay = delay[:every]
    end
    # below we exec the call a first time
    proc.call
    # as we exec one time above we subtract one below
    unless repeat==0
      repeat=repeat-1
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
    case value
    when :vr
      path = $images_list[content][:path]
      jq_get(atome_id).css("background", "transparent")
      jq_get(atome_id).append("<a-scene className='aframebox' embedded vr-mode-ui='enabled': false device-orientation-permission-ui='enabled: false'> <a-sky src='" + path + "' rotation='0 -130 0'></a-sky></a-scene>")
    end
  end
end
