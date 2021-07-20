# here stand some atome's function to allow atome's objects manipulation
def render_analysis(methods, val, passsword)
  renderer = case val[:engine]
             when :fabric
               "#{methods}_fabric"
             when :zim
               "zim_#{methods}_zim"
             when :html
               "#{methods}_html"
             when :headless
               "#{methods}_headless"
             when :speech
               "#{methods}_speech"
             else
               alert "other rendering to catch!!!"
               "#{methods}_#{$default_renderer}"
             end
  send(renderer, val, passsword)
end

def initialised_libraries(render_engine)
  if render_engine
    $renderer.include?(:fabric)
  else
    $renderer
  end
end

def libraries(render_engine)
  $renderer |= [render_engine]
end

def web_state(val = nil)
  if val
    AtomeHelpers.class_variable_set("@@web_state", val)
  else
    AtomeHelpers.class_variable_get("@@web_state")
  end
end

# the result method is used to get the return queries of the database
def result(params)
  result = {}
  params.each do |key_pair|
    result[key_pair[0]] = key_pair[1]
  end
  text("msg from atome_extension line 9 : #{result}")
end

def identity
  "a_" + object_id.to_s + "_" + Atome.atomes.length.to_s + "_" + Time.now.strftime("%Y%m%d%H%M%S")
end

def get(id)
  Atome.atomes.values.each do |atome|
    if atome.id == id
      return atome
    end
  end
  nil
end

def grab(atome_id)
  if Atome.atomes.key?(atome_id)
    Atome.atomes[atome_id]
  end
end

def find(query)
  grab(:view).find(query)
end

def batch(objects)
  batched_atomes = []
  objects.each do |atome_id|
    batched_atomes << atome_id.atome_id
  end
  ATOME.atomise(:batch, batched_atomes)
end

def tactile
  # check if user's device is a tactile device
  false
end

def lorem
  <<~STRDELIM
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
  STRDELIM
end

def schedule(date, &proc)
  date = date.to_s
  delimiters = [",", " ", ":", "-"]
  formated_date = date.split(Regexp.union(delimiters))

  missing_datas = Time.now
  missing_datas = missing_datas.to_s
  delimiters = [",", " ", ":", "-"]
  missing_datas_formated_date = missing_datas.split(Regexp.union(delimiters))

  case formated_date.length
  when 1
    seconds = formated_date[0]
    minutes = missing_datas_formated_date[4]
    hours = missing_datas_formated_date[3]
    days = missing_datas_formated_date[2]
    months = missing_datas_formated_date[1]
    years = missing_datas_formated_date[0]

  when 2
    seconds = formated_date[0]
    minutes = formated_date[1]
    hours = missing_datas_formated_date[3]
    days = missing_datas_formated_date[2]
    months = missing_datas_formated_date[1]
    years = missing_datas_formated_date[0]
  when 3
    seconds = formated_date[0]
    minutes = formated_date[1]
    hours = formated_date[2]
    days = missing_datas_formated_date[2]
    months = missing_datas_formated_date[1]
    years = missing_datas_formated_date[0]
  when 4
    seconds = formated_date[0]
    minutes = formated_date[1]
    hours = formated_date[2]
    days = formated_date[3]
  when 5
    seconds = formated_date[0]
    minutes = formated_date[1]
    hours = formated_date[2]
    days = formated_date[3]
    months = formated_date[4]
    years = missing_datas_formated_date[0]
  else
    years = formated_date[0]
    months = formated_date[1]
    days = formated_date[2]
    hours = formated_date[3]
    minutes = formated_date[4]
    seconds = formated_date[5]
  end
  schedule_html(years, months, days, hours, minutes, seconds, &proc)
end

def wait(seconds)
  ATOME.wait_html(seconds) do
    yield
  end
end

def repeat(delay = 3, repeat = 5, &proc)
  ATOME.repeat_html(delay, repeat, &proc)
end

def clear(value)
  grab(:view).clear(value)
end

def atomes(full_list)
  ATOME.atomes(full_list)
end

def renderer params = nil
  if params
    $default_renderer = params
  else
    $default_renderer
  end

end

def atome_require(file)
  alert "atome_require message I replace atome_require with require to be able to load the file '#{file}'"
end

def compile(code)
  code = code.gsub("require ", "atome_require ")
  eval(code)
end

def version
  "v:0.017"
end

def animate(params)
  if params[:start][:blur]
    value_found = params[:start][:blur]
    params[:start][:filter] = "blur(#{value_found}px)"
    params[:start].delete(:blur)
  end
  if params[:end][:blur]
    value_found = params[:end][:blur]
    params[:end][:filter] = "blur(#{value_found}px)"
    params[:end].delete(:blur)
  end
  if params[:start][:smooth]
    value_found = params[:start][:smooth]
    params[:start][:borderRadius] = value_found
    params[:start].delete(:smooth)
  end
  if params[:end][:smooth]
    value_found = params[:end][:smooth]
    params[:end][:borderRadius] = value_found
    params[:end].delete(:smooth)
  end

  if params[:start][:color]
    value_found = params[:start][:color]
    value_found = grab(params[:target]).color_helper(value_found)
    params[:start][:background] = value_found
    params[:start].delete(:color)
  end
  if params[:end][:color]
    value_found = params[:end][:color]
    value_found = grab(params[:target]).color_helper(value_found)
    params[:end][:background] = value_found
    params[:end].delete(:color)
  end

  if params[:start][:shadow]
    value_found = params[:start][:shadow]
    value_found = grab(params[:target]).shadow_helper(value_found)
    params[:start][value_found[0]] = value_found[1]
    params[:start].delete(:shadow)
  end
  if params[:end][:shadow]
    value_found = params[:end][:shadow]
    value_found = grab(params[:target]).shadow_helper(value_found)
    params[:end][value_found[0]] = value_found[1]
    params[:end].delete(:shadow)
  end
  ATOME.animate_html(params)
end

def animate=(params)
  animate(params)
end

def anim(params)
  animate(params)
end

def selection
  ATOME.selection_html
end

def group(params)
  grab(:view).group(params)
end

def kickstart_keyboard_shortcut
  # alert :called
  # keyboard short cut
  grab(:device).key({ option: :down }) do |evt|
    if evt.alt_key
      evt.stop_propagation
      evt.stop_immediate_propagation
      evt.prevent_default
      case evt.key_code
      when 65
        #key a
        if grab("code_editor")
          #the line below store the current state in the buffer object
          grab(:buffer).content = grab(:buffer).content.merge(
            code_editor: { content: ATOME.get_ide_content(:code_editor.to_s + "_code_editor"),
                           x: grab(:code_editor).x,
                           y: grab(:code_editor).y,
                           width: grab(:code_editor).width,
                           height: grab(:code_editor).height })
          grab("code_editor").delete
          evt.prevent_default
        else
          #the restore the  state found in the buffer object
          if grab(:buffer).content[:code_editor]
            code_editor_content = grab(:buffer).content[:code_editor][:content]
            x_position = grab(:buffer).content[:code_editor][:x]
            y_position = grab(:buffer).content[:code_editor][:y]
            width_size = grab(:buffer).content[:code_editor][:width]
            height_size = grab(:buffer).content[:code_editor][:height]
          else
            code_editor_content = :box
            x_position = 0
            y_position = 0
            width_size = 150
            height_size = 150
          end
          code({ atome_id: :code_editor, content: code_editor_content,
                 x: x_position,
                 y: y_position,
                 width: width_size,
                 height: height_size
               })
          evt.prevent_default
        end
      when 69
        #key e
        puts('console')
      when 82
        #key r
        if grab(:code_editor)
          evt.stop_propagation
          evt.stop_immediate_propagation
          evt.prevent_default
          clear(:view)
          compile(ATOME.get_ide_content("code_editor_code"))
        end
      when 84
        #key t
      when 89
        #key y
      when 90
        #key z
      else
      end
      # elsif evt.ctrl_key
      # else
    end
  end
end

def notification(message, option = nil, size = 16)
  margin = 6
  if grab(:alert)
    alert_box = grab(:alert)
    alert_messages = grab(:alert_content)
    if option == :clear
      alert_messages.content("")
      alert_box.height = 0
    elsif option == :delete
      alert_messages.content("")
      alert_box.delete(true)
    else
      new_content = if alert_messages.content == "\n" || alert_messages.content == ""
                      "#{message}"
                    else
                      "#{alert_messages.content}\n#{message}"
                    end
      alert_messages.content(new_content)
      alert_box.height = alert_box.height + size
    end
  else
    style = grab(:UI).content
    alert_box = box(style.merge({ atome_id: :alert, parent: :intuition }))
    alert_content = alert_box.text({ x: margin,
                                     y: margin,
                                     visual: { size: size, path: :arial },
                                     atome_id: :alert_content,
                                     content: "#{message}\n",
                                     color: :white })
    alert_box.height = size + margin * 2
    alert_box.touch do
      alert_content.content("")
      alert_box.delete(true)
    end
    alert_box.xx(33)
    alert_box.yy(33)
  end

end

def notif(message, size)
  notification(message, size)
end

def atomic_request(target = nil, content, options)
  if target
    Object.send(target, content[:content], options[:options])
  end
end

def reader(params, &proc)
  ATOME.reader(params, &proc)
end

def refresh (params=nil)
  if params.nil?
    target = :all
  elsif params.instance_of?(String) || params.instance_of?(Array)
    target = :all
    source = params

  else
    target = params[:target]
    source = params[:source]
  end
  unless source
    source=current_code
  end
  if target == :all || target.nil?
    clear(:view)
    reader(source) do |data|
      compile data
    end
  else
    # # we  colect it's content
    # collected_atome=[]
    # grab(:view).child do |atome|
    #   if atome.atome_id.to_s != target.to_s
    #     collected_atome << atome
    #   end
    # end
    # clear(:view)
    # reader(source) do |data|
    #   compile data
    # end
    #  collected_atome.each do |atome|
    #    alert atome.atome_id
    #    grab(atome.atome_id).delete
    #    Atome.new(atome.properties)
    #  end
  end
  # temp patch before using a DB to store current script
  $current_script=source
  # alert $current_script
end

def current_code code=nil
  if code
    $current_script=code
  else
    $current_script
  end
end

