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

  def client_height(atome_requested)
    `var test = document.getElementById(#{atome_requested});
var height = (test.clientHeight + 1);
return height;
`

  end

  def client_width(atome_requested)
    `var test = document.getElementById(#{atome_requested});
var width = (test.clientWidth + 1);
return width;
`
  end

  def html_verif(value)
    # puts (value)
    # alert value
    # alert self.atome_id
    # alert self.width
    # var fontSize = 12;
    # var test = document.getElementById("Test");
    alert client_height(atome_id)
    alert client_width(atome_id)
    current_atome = jq_get(atome_id)
    fontSize = current_atome.css('font-size')
    # current_atome.style.fontSize = fontSize;

    # alert current_atome.css('client_height')
    `
    var test = document.getElementById(#{atome_id});
//alert(test.clientHeight + 1);
    var fontSize = #{fontSize};
    test.style.fontSize = fontSize;
    var height = (test.clientHeight + 1) + "px";
    var width = (test.clientWidth + 1) + "px"
    //alert(height);
    //alert(width);
`
    # jq_width = (current_atome.clientWidth + 1) + "px"
    # alert jq_height
    # alert jq_width

    # var test = document.getElementById("Test");
    # test.style.fontSize = fontSize;
    # var height = (test.clientHeight + 1) + "px";
    # var width = (test.clientWidth + 1) + "px"

  end
end