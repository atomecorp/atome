# render methods
module Render

  def self.initialize
    Element.find(JS_utils.device).resize do |evt|
      grab(:view).width(Element.find('#view').css('width').sub('px', '').to_i, false)
      grab(:view).height(Element.find('#view').css('height').sub('px', '').to_i, false)
    end
    # the line below alllow to capture the size of the view at init time
    grab(:view).width(Element.find('#view').css('width').sub('px', '').to_i, false)
    grab(:view).height(Element.find('#view').css('height').sub('px', '').to_i, false)
  end


  def self.render_type(atome, params, parent = :body)
    alert "message is \n\nid : #{atome.atome_id} , render : #{"just to check order"} \n\nLocation: html.rb, line 16"
    atome_id = atome.atome_id
    dark_matter = Element.find('#dark_matter')
    if atome_id == :blackhole
      Element.find('body').prepend("<div class='atome' id='#{atome_id}'></div>")
    elsif atome_id == :dark_matter
      Element.find('body').prepend("<div class='atome' id='#{atome_id}'></div>")
    elsif atome_id == :device
      Element.find('body').prepend("<div class='atome' id='#{atome_id}'></div>")
    elsif atome_id == :intuition
      Element.find('body').prepend("<div class='atome' id='#{atome_id}'></div>")
    elsif atome_id == :view
      Element.find('body').prepend("<div class='atome' id='#{atome_id}'></div>")
    else
      if atome.type == :text
        dark_matter.append("<div class='atome' style='display:inline-block' id='#{atome_id}'></div>")
      elsif atome.type == :shape
        dark_matter.append(("<div class='atome' id='#{atome_id}'></div>"))
      elsif atome.type == :image
        dark_matter.append("<div class='atome' id='#{atome_id}'></div>")
      elsif atome.type == :video
        dark_matter.append("<div  id=" + atome_id + " class='atome' ><video  width='512' muted ></video></div>");
      elsif atome.type == :audio
        dark_matter.append("<div  id=" + atome_id + " class='atome' ></div>");
      else
        dark_matter.append(("<div class='atome' id='#{atome_id}'></div>"))
      end
    end
    atome.properties.each do |property|
      #we collect all previously stored property to avoid inifinite recursive loop and atome_id which may be already set as it should be set in first
      unless property.keys[0].to_sym == :type || property.keys[0].to_sym == :parent || property.keys[0].to_sym == :advertise || property.keys[0].to_sym == :preset || property.keys[0].to_sym == :atome_id || property.keys[0].to_sym == :child || property.keys[0].to_sym == :center || property.keys[0].to_sym == :render
        send("render_" + property.keys[0], atome, property.values[0])
      end
    end
  end

  def self.render_parent(atome, params, add = false)
    params.each do |parent|
      grab(parent).insert(atome)
    end
  end

  def self.render_content(atome, params, add = false)
    alert "message is \n\nid : #{atome.atome_id} , from content width is : #{atome.width} \n\nLocation: html.rb, line 59"

    if atome.type == "text" || atome.type == "web"
      params = params.to_s.gsub("\n", "<br>")
      Element.find('#' + atome.atome_id).html(params)
    elsif atome.type == "image"
      if $images_list[params.to_sym].nil?
        path = '././medias/images/image_missing.svg'
        width = 390
        height = 200
      else
        path = $images_list[params.to_sym][:path]
        width = $images_list[params.to_sym][:width]
        height = $images_list[params.to_sym][:height]
      end
      Element.find('#' + atome.atome_id).css('background-image', 'url(' + path)
      if width.nil?
        width = 300
      end
      if height.nil?
        height = 300
      end
      atome.width = width
      atome.height = height

    elsif atome.type == "video"
      path = if $videos_list[params.to_sym].nil?
               '././medias/videos/video_missing.mp4'
             else
               $videos_list[params.to_sym][:path]
             end
      Element.find('#' + atome.atome_id).find('video').html("<source src=" + path + " type='video/mp4'></source>")

    elsif atome.type == "audio"
      path = if $audios_list[params.to_sym].nil?
               '././medias/audios/audio_missing.wav'
             else
               $audios_list[params.to_sym][:path]
             end
      Element.find('#' + atome.atome_id).html("<audio  src=" + path + " type='audio/wav'></audio>")

    elsif atome.type == "shape"
      # below temp patch waiting for parametric shape to allow circkle creation
      Element.find('#' + atome.atome_id).css('border-radius', params[:tension])
    else
    end
  end

  def self.render_id(atome, params, add = false)
    Element.find('#' + atome.atome_id).attr(:a_id, params)
  end

  # properties

  def self.render_color(atome, params, add = false)
    color = "background-image"
    if atome.type == :text
      Element.find('#' + atome.atome_id).css('-webkit-background-clip', 'text')
      Element.find('#' + atome.atome_id).css('-webkit-text-fill-color', 'transparent')
    end
    if params.class == Hash
      value = ' linear-gradient(0deg,' + params[:content] + ', ' + params[:content] + ')'
    elsif params.class == Array
      value = []
      angle = '180'
      diffusion = "linear"
      params.each do |param|
        if param.class == Hash
          if param[:angle]
            angle = param[:angle].to_s
          end
          if param[:diffusion]
            diffusion = param[:diffusion]
          end
          if param[:content]
            value << param[:content]
          end
          if param[:color]
            value << param[:color]
          end
        else
          value << param
        end
      end
      value = if diffusion == 'linear'
                ' linear-gradient(' + angle + 'deg, ' + value.join(',') + ')'
              else
                ' radial-gradient(' + value.join(',') + ')'
              end
    else
      value = ' linear-gradient(0deg,' + params + ', ' + params + ')'
    end
    Element.find('#' + atome.atome_id).css(color, value)
  end

  def self.render_opacity(atome, params, add = false)
    Element.find('#' + atome.atome_id).css(:opacity, params)
  end

  def self.render_x(atome, params, add = false)
    alert "message is \n\nid : #{atome.atome_id} , from  x width is: #{atome.width} \n\nLocation: html.rb, line 159"
    if !atome.width || atome.width == "auto"
      Element.find('#' + atome.atome_id).css("width", "auto")
    end
    Element.find('#' + atome.atome_id).css('left', params)
  end

  def self.render_y(atome, params, add = false)
    if !atome.height || atome.height == "auto"
      Element.find('#' + atome.atome_id).css("height", "auto")
    end
    Element.find('#' + atome.atome_id).css('top', params)
  end

  def self.render_z(atome, params, add = false)
    Element.find('#' + atome.atome_id).css('z-index', params)
  end


  def self.render_xx(atome, params, add = false)
    if !atome.width || atome.width == "auto"
      Element.find('#' + atome.atome_id).css("width", "auto")
    else
      Element.find('#' + atome.atome_id).css("left", "auto")
    end
    Element.find('#' + atome.atome_id).css('right', params)
  end

  def self.render_yy(atome, params, add = false)
    if !atome.height || atome.height == "auto"
      Element.find('#' + atome.atome_id).css("height", "auto")
    else
      Element.find('#' + atome.atome_id).css("top", "auto")
    end
    Element.find('#' + atome.atome_id).css('bottom', params)
  end

  def self.render_convert(atome, property, unit)
    property = property.to_sym
    case property
    when :width
      Element.find('#' + atome.atome_id).width
    when :height
      Element.find('#' + atome.atome_id).height
    end
  end

  def self.render_width(atome, params, add = false)
    alert "message is \n\nid : #{atome.atome_id} , from width width is :#{params} :  #{"to chek if its always setted before position"} \n\nLocation: html.rb, line 207"
    Element.find('#' + atome.atome_id).css('width', params)
  end

  def self.render_height(atome, params, add = false)
    Element.find('#' + atome.atome_id).css('height', params)
  end

  def self.render_size(atome, params, add = false)
    atome_id = Element.find('#' + atome.atome_id)
    if params.class == Hash
      axis = params.keys[0]
      value = params.values[0]
      if atome.type == :text
        height = Element.find('#' + atome.atome_id).innerHeight
        atome.height(height, false)

        if params.class == String && params.end_with?("%")
          params.sub("%", "vw")
        end
        Element.find('#' + atome.atome_id).css('font-size', value)
      else
        el_width = Element.find('#' + atome.atome_id).css('width').to_f
        el_height = Element.find('#' + atome.atome_id).css('height').to_f
        ratio = el_width / el_height
        if axis == :width
          atome.width(value * ratio)
          atome.height(value)
        else
          atome.width(value)
          atome.height(value * ratio)
        end
        Element.find('#' + atome.atome_id).css('background-size', "100%")
      end
    else
      if atome.type == :text
        height = Element.find('#' + atome.atome_id).innerHeight
        atome.height(height, false)
        if params.class == String && params.end_with?("%")
          params = params.sub("%", "vw")
        end
        Element.find('#' + atome.atome_id).css('font-size', params)
      else
        el_width = Element.find('#' + atome.atome_id).css('width').to_f
        el_height = Element.find('#' + atome.atome_id).css('height').to_f
        ratio = el_width / el_height
        atome.width(params * ratio)
        atome.height(params)
        Element.find('#' + atome.atome_id).css('background-size', "100%")
      end
    end
    height = atome_id.height
    atome.height(height, false)
    width = atome_id.width
    atome.width(width, false)
  end

  def self.render_position(atome, params, add = false)
    if params.class == Hash
      params = params.values[0]
    else
    end
    Element.find('#' + atome.atome_id).css('position', params)
  end

  def self.render_get_size (params, add = false)
    size = {}
    size[:width] = Element.find('#' + params.atome_id).width
    size[:height] = Element.find('#' + params.atome_id).height
    return size
  end

  def self.render_get_width(params, add = false)
    Element.find('#' + params.atome_id).width
  end

  def self.render_get_height(params, add = false)
    Element.find('#' + params.atome_id).height
  end

  def self.render_get_x(params, add = false)
    Element.find('#' + params.atome_id).css(:left)
  end

  def self.render_get_y(params, add = false)
    Element.find('#' + params.atome_id).css(:top)
  end

  def self.render_rotate(atome, params, add = false)
    Element.find('#' + atome.atome_id).css('transform', 'rotate(' + params.to_s + 'deg)')
  end

  def self.render_align(atome, params, add = false)
    case params
    when :centered
    when :center
    when :middle
    when :left
    when :right
    when :top
    when :bottom
    end
    puts "unfinished  api"
  end

  def self.render_overflow(atome, params, add = false)
    if params.class == Hash
      x = params[:x]
      y = params[:y]
      if x
        Element.find('#' + atome.atome_id).css('overflow-y', :visible)
        Element.find('#' + atome.atome_id).css('overflow-x', :visible)
      end
      if y
        Element.find('#' + atome.atome_id).css('overflow-y', y)
      end
    else
      Element.find('#' + atome.atome_id).css('overflow', params)
    end
  end

  def self.render_fill(atome, params, add = false)
    atome.x = atome.y = 0
    if params.class == Hash
      target = params[:target]
      size = params[:size]
      number = params[:number]
    else
      target = if params.class == Atome
                 params
               else
                 get(params)
               end
    end
    if size.nil?
      size = atome.size
    end
    width = if target.width.class == String && target.width.end_with?("%")
              target.convert(:width, :px)
            else
              target.width
            end
    height = if target.height.class == String && target.width.end_with?("%")
               target.convert(:height, :px)
             else
               target.height
             end
    Element.find('#' + atome.atome_id).css('width', width)
    Element.find('#' + atome.atome_id).css('height', height)
    Element.find('#' + atome.atome_id).css('background-repeat', 'space')
    if number
      size = width / number
    else
    end
    Element.find('#' + atome.atome_id).css('background-size', size)
  end

  def self.render_shadow(atome, params, add = false)
    formated_params = case params
                      when Array
                        #"array"
                      when Hash
                        properties = Nucleon::Core::Proton.presets[:shadow]
                        params.each do |key, value|
                          properties[key] = value
                        end
                        properties
                      when Boolean, :true
                        Nucleon::Core::Proton.presets[:shadow]
                      when String, Symbol
                        params

                      end
    x = formated_params[:x]
    y = formated_params[:y]
    blur = formated_params[:blur]
    thickness = formated_params[:thickness]
    color = formated_params[:color]
    invert = formated_params[:invert]
    invert = if invert
               :inset
             else
               " "
             end
    if add
      if atome.type == :text || atome.type == :image
        prev_prop = Element.find('#' + atome.atome_id).css('text-shadow')
        Element.find('#' + atome.atome_id).css('filter', prev_prop + " " + 'drop-shadow(' + x.to_s + 'px ' + y.to_s + 'px ' + blur.to_s + 'px ' + color + ')')
      else
        prev_prop = Element.find('#' + atome.atome_id).css('box-shadow')
        Element.find('#' + atome.atome_id).css('box-shadow', prev_prop + " ," + x.to_s + 'px ' + y.to_s + 'px ' + blur.to_s + 'px ' + thickness.to_s + 'px ' + color + ' ' + invert)
      end
    else
      if atome.type == :text || atome.type == :image
        Element.find('#' + atome.atome_id).css('filter', 'drop-shadow(' + x.to_s + 'px ' + y.to_s + 'px ' + blur.to_s + 'px ' + color + ')')
      else
        Element.find('#' + atome.atome_id).css('box-shadow', x.to_s + 'px ' + y.to_s + 'px ' + blur.to_s + 'px ' + thickness.to_s + 'px ' + color + ' ' + invert)
      end
    end
  end

  def self.render_border(atome, params, add = false)
    formated_params = case params
                      when Array
                      when Hash
                        properties = Nucleon::Core::Proton.presets[:shadow]
                        params.each do |key, value|
                          properties[key] = value
                        end
                        properties
                      when String, Symbol
                        params
                      when Boolean
                        Nucleon::Core::Proton.presets[:shadow]
                      end
    pattern = formated_params[:pattern]
    thickness = formated_params[:thickness]
    color = formated_params[:color]
    Element.find('#' + atome.atome_id).css('border', thickness.to_s + 'px ' + pattern + ' ' + color)
  end

  def self.render_smooth(atome, params, add = false)
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
    Element.find('#' + atome.atome_id).css('border-radius', formated_params)
  end

  def self.render_blur(atome, params, add = false)
    case params
    when Array
      properties = []
      params.each do |param|
        properties << param.to_s + 'px'
      end
      properties.join(" ").to_s
    when Hash
      if params[:invert]
        Element.find('#' + atome.atome_id).css('backdrop-filter', 'blur(' + params[:value].to_s + 'px)')
      else
        Element.find('#' + atome.atome_id).css('filter', 'blur(' + params[:value].to_s + 'px)')
      end
    when String, Symbol, Number
      Element.find('#' + atome.atome_id).css('filter', 'blur(' + params.to_s + 'px)')
    when Boolean
    end
  end

  def self.render_level(atome, params, add = false)
    if params < 0
      params = 0
    elsif params > 1
      params = 1
    end
    JS_utils.audio_level atome, params
  end

  def self.render_virtual_touch(atome, params, add = false)
    JS_utils.virtual_touch params[:target], params[:content]
  end

  def self.render_edit(atome, params, add = false)
    if params == :true || params == true
      Element.find('#' + atome.atome_id).attr('contenteditable', 'true')
      Element.find('#' + atome.atome_id).css('-webkit-user-select', 'text')
      Element.find('#' + atome.atome_id).css('-khtml-user-select', 'text')
      Element.find('#' + atome.atome_id).css('-moz-user-select', 'text')
      Element.find('#' + atome.atome_id).css('-o-user-select', 'text')
      Element.find('#' + atome.atome_id).css('user-select: text', 'text')
    elsif params == :false || params == false
      Element.find('#' + atome.atome_id).attr('contenteditable', 'false')
      Element.find('#' + atome.atome_id).css('-webkit-user-select', 'none')
      Element.find('#' + atome.atome_id).css('-khtml-user-select', 'none')
      Element.find('#' + atome.atome_id).css('-moz-user-select', 'none')
      Element.find('#' + atome.atome_id).css('-o-user-select', 'none')
      Element.find('#' + atome.atome_id).css('user-select: text', 'none')
    end

    Element.find('#' + atome.atome_id).keyup do |evt|
      content = Element.find('#' + atome.atome_id).html().gsub('<br>', "\n").gsub('<div>', "\n").gsub('</div>', "").gsub(';', "").gsub('&nbsp', " ")
      atome.content(content, false)
    end
  end

  def self.render_select(atome, params, add = false)
    if params
      if atome.type == :text
        Element.find('#' + atome.atome_id).attr('contenteditable', 'true')
        Element.find('#' + atome.atome_id).css('-webkit-user-select', 'text')
        Element.find('#' + atome.atome_id).css('-khtml-user-select', 'text')
        Element.find('#' + atome.atome_id).css('-moz-user-select', 'text')
        Element.find('#' + atome.atome_id).css('-o-user-select', 'text')
        Element.find('#' + atome.atome_id).css('user-select: text', 'text')
      end

      Element.find('#' + atome.atome_id).add_class 'selected'
    else
      if atome.type == :text
        Element.find('#' + atome.atome_id).attr('contenteditable', 'false')
        Element.find('#' + atome.atome_id).css('-webkit-user-select', 'none')
        Element.find('#' + atome.atome_id).css('-khtml-user-select', 'none')
        Element.find('#' + atome.atome_id).css('-moz-user-select', 'none')
        Element.find('#' + atome.atome_id).css('-o-user-select', 'none')
        Element.find('#' + atome.atome_id).css('user-select: text', 'none')
      end
      Element.find('#' + atome.atome_id).remove_class 'selected'
    end
  end

  def self.render_active(atome, params, add = false)

  end

  def self.render_group(atome, params, add = false)
    parent = Element.find('#' + atome.atome_id)
    #me= Element.find('#' + params.atome_id)
    ##alert "message :\n#{me}\n from : html.rb : 529"
    if params.class == Array
    else
      if params.class == Atome
        params = params.atome_id
      elsif params.class == String || params.class == Symbol
        params = Object.get(params).atome_id
      end
      child = Element.find('#' + params)
      #alert "message :\n#{child}\n from : html.rb : 569"
      parent.append(child)
      offset = child.offset
      child.offset(offset)
    end
  end

  def self.render_clear(atome, params, add = false)
    if params.class == Symbol || params.class == String
      case params
      when :reset_view
        JS_utils.clear_intervals
        JS_utils.clear_timeouts
      when :all
        JS_utils.clear_intervals
        JS_utils.clear_timeouts
      when :console
      when :ide
      when :view
        JS_utils.clear_intervals
        JS_utils.clear_timeouts
      else
        # when have an atome so the method comes from neutron not electron! we clear a prop of a specific atome
        case params
        when :group
          Element.find('#' + atome.atome_id).empty()
        end
      end
    end
  end

  def self.render_selector(atome, params, add = false)
    Element.find('#' + atome.atome_id).add_class params
  end

  def self.render_delete(atome, params, add = false)
    atome_body = Element.find('#' + atome.atome_id)
    if params.class == Atome
      Element.find('#blackhole').append(atome_body)
    elsif params.class == Hash
      property = params.keys[0]
      case property
      when :selector
        Element.find('#' + atome.atome_id).remove_class(params[:selector])
      when :touch
        if params[:touch].class == Integer || params[:touch].class == Number
          atome.touch.delete_at(params[:touch])
          Element.find('#' + atome.atome_id).unbind("click")
          Element.find('#' + atome.atome_id).unbind("touchstart")
          Element.find('#' + atome.atome_id).unbind("mousedown")
          Element.find('#' + atome.atome_id).unbind("mouseup")
          Element.find('#' + atome.atome_id).unbind("touchend")
          atome.touch.each_with_index do |event, index|
            proc = event[:content]
            if index == 0
              atome.set(touch: {option: event[:option]}, &proc)
            else
              atome.add(touch: {option: event[:option]}, &proc)
            end
          end
        elsif params[:touch].to_sym == :up
          Element.find('#' + atome.atome_id).unbind('mouseup')
          Element.find('#' + atome.atome_id).unbind('touchend')
        elsif params[:touch].to_sym == :down
          Element.find('#' + atome.atome_id).unbind('mousedown')
          Element.find('#' + atome.atome_id).unbind('touchstart')
        elsif params[:touch].to_sym == :all
          Element.find('#' + atome.atome_id).unbind("click")
          Element.find('#' + atome.atome_id).unbind("touchstart")
          Element.find('#' + atome.atome_id).unbind("mousedown")
          Element.find('#' + atome.atome_id).unbind("mouseup")
          Element.find('#' + atome.atome_id).unbind("touchend")
        else
          Element.find('#' + atome.atome_id).unbind("click")
          Element.find('#' + atome.atome_id).unbind("touchstart")
          Element.find('#' + atome.atome_id).unbind("mousedown")
          Element.find('#' + atome.atome_id).unbind("mouseup")
          Element.find('#' + atome.atome_id).unbind("touchend")
          atome.touch.each_with_index do |event, index|
            next if (event[:name] && event[:name].to_sym == params[:touch].to_sym)
            proc = event[:content]
            if index == 0
              atome.set(touch: {option: event[:option]}, &proc)
            else
              atome.add(touch: {option: event[:option]}, &proc)
            end
          end
        end
      end
    else
      if params == :touch
        Element.find('#' + atome.atome_id).unbind("click")
        Element.find('#' + atome.atome_id).unbind("touchstart")
        Element.find('#' + atome.atome_id).unbind("mousedown")
        Element.find('#' + atome.atome_id).unbind("mouseup")
        Element.find('#' + atome.atome_id).unbind("touchend")
      end
      if params == :true || params == true
        atome_to_delete = '#' + atome.atome_id
        Element.find(atome_to_delete).remove('')
      end
    end
  end

  def self.render_http(url)
    Js.window.open("https://" + url)
  end

  # time operation

  def self.render_wait(time, &proc)
    time = time.to_f
    return JS_utils.setTimeout(time, &proc)
  end

  def self.render_every(delay = 1, times = 5, &proc)
    if delay.class == Hash
      times = delay[:times]
      delay = delay[:every]
    end
    return JS_utils.setInterval(delay, times, &proc)
  end

  def self.render_reader filename, action = :run, code = :ruby
    JS_utils.loader(filename, action, code)
  end

  # events

  def self.render_touch(atome, params, add = false)
    unless add
      atome.delete(:touch)
    end
    if params != true
      proc = params[:proc]
      params = params[:params]
    end
    if params == :down
      Element.find('#' + atome.atome_id).on("touchstart mousedown") do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    elsif params == :up
      Element.find('#' + atome.atome_id).on("touchenter") do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    elsif params == :long
      Element.find('#' + atome.atome_id).on("touchstart mousedown") do |evt|
        @trig = true
        wait 1.2 do
          if @trig
            proc.call(evt) if proc.is_a?(Proc)
          end
        end
      end
      Element.find('#' + atome.atome_id).on("touchend mouseup") do |evt|
        @trig = false
      end

    else
      Element.find('#' + atome.atome_id).on(:click) do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    end
    return atome
  end

  def self.render_update_atome (atome, property, value)
    atome.send(property, value, false)
  end

  def self.render_key(atome, params, add = false)
    unless add
      atome.delete(:touch)
    end
    if params != true
      proc = params[:proc]
      params = params[:params]
    end
    if params == :down
      Element.find('#' + atome.atome_id).on("keydown") do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    elsif params == :up
      Element.find('#' + atome.atome_id).on("keyup") do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    else
      view = JS_utils.document
      view.on(:keypress) do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    end
    return atome

  end

  def self.render_over(atome, params, add = false)
    if params != true
      proc = params[:proc]
      params = params[:params]
    end
    if params == :enter || params == :in
      Element.find('#' + atome.atome_id).mouseenter do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    elsif params == :exit || params == :leave || params == :out
      Element.find('#' + atome.atome_id).mouseleave do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    else
      Element.find('#' + atome.atome_id).mouseover do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    end
    return atome
  end

  def self.render_drag(atome, params, add = false)
    unless add
      atome.delete(:touch)
    end
    current_atome = Element.find('#' + atome.atome_id)

    device = Element.find("#device")
    if params != true
      proc = params[:proc]
      params = params[:params]
    else
      params = :true
    end
    if params && params.class == Hash
      case params[:lock]
      when :parent
        options = {containment: "parent"}
      when :x
        options = {axis: "y"}
      when :y
        options = {axis: "x"}
      when :test
        options = {containment: "parent", axis: "x"}
      when :all
        left = current_atome.css("left").sub("px", '').to_i
        top = current_atome.css("top").sub("px", '').to_i
        options = {containment: [left, top, left, top]}
      else
        options = {containment: "#" + params[:lock].id}
      end
    end
    current_atome.draggable(options)
    xx_position = ""
    yy_position = ""
    current_atome.on(:drag) do |evt|
      #bottom_pos = device.height - current_atome.offset().top - current_atome.height
      #atome.yy(bottom_pos, false)
      ##for future use to stop event propagation
      #evt.stop_propagation
      proc.call(evt) if proc.is_a?(Proc)
      # we update current_atome position

      if atome.x
        x_position = current_atome.css('left').sub('px','').to_i
        atome.x({content: x_position}, false)
      end
      if atome.y
        y_position = current_atome.css('top').sub('px','').to_i
        atome.y({content: y_position}, false)
      end
      if atome.xx
        xx_position = Element.find('#' + atome.parent.last.atome_id).width - (current_atome.offset().left + current_atome.width())
        atome.xx({content: xx_position}, false)
      end

      if atome.yy
        yy_position = Element.find('#' + atome.parent.last.atome_id).height - (current_atome.offset().top + current_atome.height())
        atome.yy({content: yy_position}, false)
      end
    end
    current_atome.on(:dragstop) do |evt|
      if atome.align
        if atome.align[:x] == :xx
          current_atome.css("left", :auto)
          current_atome.css("right", xx_position)
        end
        if atome.align[:y] = :yy
          current_atome.css("top", :auto)
          current_atome.css("bottom", yy_position)
        end
      end

    end

  end

  def self.render_enter(atome, params, add = false)
    atome_id = '#' + atome.atome_id


    Element.find("#device")
    if params != true
      proc = params[:proc]
      params[:params]
    else
      :true
    end
    JS_utils.enter(atome_id, proc)
  end

  def self.render_exit(atome, params, add = false)
    current_atome = Element.find('#' + atome.atome_id)
    atome_id = '#' + atome.atome_id
    if params != true
      proc = params[:proc]
      params[:params]
    else
      :true
    end
    JS_utils.leave(atome_id, proc)
  end

  def self.render_drop(atome, params, add = false)
    current_atome = Element.find('#' + atome.atome_id)
    atome_id = '#' + atome.atome_id
    if params != true
      proc = params[:proc]
      params[:params]
    else
      :true
    end
    JS_utils.drop(atome_id, proc)
  end

  def self.render_scale(atome, params, add = false)
    Element.find('#' + atome.atome_id).resizable({handles: 'all'})
    Element.find('#' + atome.atome_id).on('resize') do |evt|
      atome.width(Element.find('#' + atome.atome_id).css("width").to_i, false)
      atome.height(Element.find('#' + atome.atome_id).css("height").to_i, false)
      params.call(evt) if params.is_a?(Proc)
    end
    Element.find("#device").on('resize') do |evt|
      if atome.width != (Element.find('#' + atome.atome_id).css("width")).to_i
        params.call(evt) if params.is_a?(Proc)
      end
    end
    #resize handles
    JS_utils.set_handles_size
  end

  def self.render_scroll(atome, params, add = false)
    atome_id = Element.find('#' + atome.atome_id)
    Element.find(atome_id).on(:scroll) do |evt|
      offset_y = Element.find(atome_id).prop('scrollHeight').to_i - Element.find(atome_id).css('height').sub("px", "").to_i
      params.call(offset_y) if params.is_a?(Proc)
    end
  end

  def self.render_resize(atome, params, add = false)
    if params != true
      proc = params[:proc]
      params[:params]
    else
      :true
    end
    Element.find(JS_utils.device).resize do |evt|
      proc.call(evt) if proc.is_a?(Proc)
    end
  end

  def self.render_play(atome, params, add = false)
    #below to play also all video child (mostly audio tracks)
    if atome.child
      if atome.child.each do |child|
        if child.type == :audio || atome.child[0].type == :video
          render_play(child, params, add = false)
        end
      end
      end
    end
    if params != true && params != nil
      proc = params[:proc]
      params = params[:params]
    else
      params = true
      proc = false
    end
    if atome.type == :video && params == false
      video_pause atome, 0
    elsif atome.type == :audio && params == false
      audio_pause atome, 0
    elsif atome.type == :video
      JS_utils.video_play atome, params, proc
    elsif atome.type == :audio
      JS_utils.audio_play atome, params, proc
    end
  end

  def self.render_pause(atome, params, add = false)
    #below to pause also all video child (mostly audio tracks)
    if atome.child
      if atome.child.each do |child|
        if child.type == :audio || atome.child[0].type == :video
          render_pause(child, params, add = false)
        end
      end
      end
    end
    if atome.type == :video
      JS_utils.video_pause atome, params
    elsif atome.type == :audio
      JS_utils.audio_pause atome, params
    end
  end

  # anim
  def self.render_animate(params, obj, add = false)
    atome = grab(obj)
    $$.html.animate(params, obj)
    wait params[:duration] / 1000 do
      params[:end].each_key do |property|
        value = params[:end][property]
        case property
        when :filter
          property = value.split "("
          value = property[1]
          value = value.sub(")", "")
          property = property[0]
          atome.send(property, value, false)
        else
        end
      end
    end
  end

  #util
  def self.render_to_px(atome, property)
    property = property.to_sym
    atome_body = Element.find('#' + atome.atome_id)
    case property
    when :width
      return atome_body.width()
    when :height
      return atome_body.height()
    when :top
      return atome_body.css("top")
    when :left
      return atome_body.css("left")
    when :bottom
      return atome_body.css("bottom")
    when :right
      return atome_body.css("right")
    end
  end

  def self.render_ide ide_atome_id, content = ""
    unless JS_utils.codemirror_ready
      JS_utils.load_codemirror(ide_atome_id, content)
    end
  end

end



