module PropertylHtml
  def tactile_html(value)
    value.read
  end

  def wait_html(seconds, &proc)
    seconds = seconds.to_f
    set_timeout(seconds, &proc)
  end

  def every_html(delay = 1, repeat = 5, &proc)
    if delay.instance_of?(Hash)
      repeat = delay[:times]
      delay = delay[:every]
    end
    set_interval(delay, repeat, &proc)
  end

  def clear_interval_html(value)
    clear_timeout(value)
  end

  def clear_repeat_html(value)
    clear_interval(value)
  end
end