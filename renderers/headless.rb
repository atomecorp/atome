# render method

def render_id (atome, params)
end

def render_fill (atome, params)

end

def render_preset(atome, params)
  atome_id = atome.atome_id
  if params == :view
  else
    if atome.type[:content]  == :text
    elsif atome.preset == :circle
    elsif atome.preset == :image
    elsif atome.preset == :video
    elsif atome.preset == :audio
    else
    end
  end
end

def render_content(atome, params)
  if atome.type[:content] == "text"
  elsif atome.type[:content]  == "image"
  elsif atome.type[:content]  == "video"
  elsif atome.type[:content]  == "audio"
  else
  end
end

#properties
def render_color(atome, params)
  if atome.preset != :text
    color = "background-color"
  else
    color = "color"
  end
end

def render_opacity(atome, params)
end

def render_x(atome, params)
end

def render_y(atome, params)
end

def render_z(atome, params)

end

def render_left(atome, params)
end

def render_right(atome, params)
end

def render_top(atome, params)
end

def render_bottom(atome, params)
end

def render_width(atome, params)
end

def render_height(atome, params)
end

def render_overflow(atome, params)
end

def render_size(atome, params)
  if atome.type[:content]  == :text
  else
  end
end

def render_rotate(atome, params)
end

def render_shadow(atome, params)

end

def render_border(atome, params)
  formated_params = case params
                    when Array
                      #"array"
                    when Hash
                      properties = Proton.presets[:shadow]
                      params.each do |key, value|
                        properties[key] = value
                      end
                      properties
                    when String, Symbol
                      params
                    when Boolean
                      Proton.presets[:shadow]
                    end

  pattern = formated_params[:pattern]
  thickness = formated_params[:thickness]
  color = formated_params[:color]
end

def render_smooth(atome, params)
  formated_params = case params
                    when Array
                      properties = []
                      params.each do |param|
                        properties << param.to_s + 'px'
                      end
                      properties.join(" ").to_s
                    when Number
                      params
                    when Hash
                    when String, Symbol
                    when Boolean
                    end
end

def render_blur(atome, params)

end

def render_edit(atome, params)

end

def render_select(atome, params)
  if params
  else
  end
end


def render_group(atome, params)

end

def render_clear(atome)
  case atome
  when :all
  when :console
  when :ide
  when :view
  end
end

def render_delete(atome, params)

end

def render_http(url)

end


################## time operation  ##############
def render_wait(time, &proc)
  time = time.to_f

end

def render_every(delay = 1, times = 5, &proc)
  if delay.class == Hash
    times = delay[:times]
    delay = delay[:every]
  end
end

def render_reader filename, action = "run", code = :ruby
  if code == :ruby
  else
  end
end


#events
def render_touch(atome, params)
end

def render_drag(atome, params)
end

