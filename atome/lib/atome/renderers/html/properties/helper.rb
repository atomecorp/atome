module PropertyHtml
  def tactile_html(value)
    value
  end

  def wait_html(seconds, &proc)
    seconds = seconds.to_f
    set_timeout(seconds, &proc)
  end


  def program_html(date, &proc)
    set_program(date, &proc)
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
end