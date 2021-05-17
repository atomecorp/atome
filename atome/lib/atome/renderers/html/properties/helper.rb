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
      # if atome.type == :image
      #   wait 0.0001 do
          alert content
          # path = $images_list[atome.content.to_sym][:path]
          # jq_get(atome_id).append("<a-scene className='aframebox' embedded vr-mode-ui='enabled': false device-orientation-permission-ui='enabled: false'> <a-sky src='" + path + "' rotation='0 -130 0'></a-sky></a-scene>")
        # end
      # end
    when :swap
      #replaceElementTag(:img)
    end
  end
end
