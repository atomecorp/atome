module PropertyHtml

  def visual_html(values)
    # we must unbind all keyboard shortcuts to make it work
    grab(:device).key(options: :stop)
    if values.instance_of?(Integer) || values.instance_of?(Number) || values.instance_of?(Float)
      values = { size: values }
    elsif values.instance_of?(String)
      values = { path: values }
    end
    basic_visuals = { path: :arial, size: 33, alignment: :center, wrap: " ", fit: :none }

    if @visual.read.instance_of?(Hash)
      # if it's a hash it means that the visual already exist
      values = @visual.read.merge(values)
    else
      values = basic_visuals.merge(values)
    end
    path_get = values[:path]
    size_get = values[:size]
    # for later use
    width_get = values[:width]
    haight_get = values[:height]
    alignment_get = values[:alignment]
    selection= values[:select]
    wrap_get = values[:wrap]
    fit_get = values[:fit]

    jq_get(atome_id).css("font-size", size_get)
    jq_get(atome_id).css("font-family", path_get)
    case fit_get
    when :width
      jq_get(atome_id).css("word-break", "unset")
      jq_get(atome_id).css("word-wrap", "unset")
      jq_get(atome_id).css("hyphens", "unset")
      if self.edit == true
        self.edit(false)
        JSUtils.fit_text_width(atome_id)
        self.edit(true)
      else
        JSUtils.fit_text_width(atome_id)
      end

    when :height
      jq_get(atome_id).css("word-break", "unset")
      jq_get(atome_id).css("word-wrap", "unset")
      jq_get(atome_id).css("hyphens", "unset")
      if self.edit == true
        self.edit(false)
        JSUtils.fit_text_height(atome_id)
        # self.edit(true)
      else
        JSUtils.fit_text_height(atome_id)
      end
    when :both
      jq_get(atome_id).css("word-break", "unset")
      jq_get(atome_id).css("word-wrap", "unset")
      jq_get(atome_id).css("hyphens", "unset")
      if self.edit == true
        self.edit(false)
        JSUtils.fit_text_width(atome_id)
        JSUtils.fit_text_height(atome_id)
        # self.edit(true)
      else
        JSUtils.fit_text_width(atome_id)
        JSUtils.fit_text_height(atome_id)
      end
    end
    # todo add edit and word break if the were set before

    jq_get(atome_id).css("text-align", alignment_get)

    if selection
      # we select the text
      # alert selection
      JSUtils.select_text_content(atome_id, selection)
    end
    case wrap_get
    when " "
      jq_get(atome_id).css("word-wrap", "break-word")
      jq_get(atome_id).css("hyphens", "auto")
    else
      jq_get(atome_id).css("word-wrap", "nowrap")
    end
    values = values.merge({ size: jq_get(atome_id).css('font-size').gsub("px", "") })
    @visual = atomise(:visual, values)
    # important @width and @height are also update when setting content (media.rb content_html line 15 1§)
    @width = atomise(:width, JSUtils.client_width(atome_id))
    @height = atomise(:height, JSUtils.client_height(atome_id))
  end

  def color_html(values)
    angle = 180
    diffusion = "linear"
    if type == :text
      # we use a stencil to allow gradient in text
      jq_get(atome_id).css("-webkit-background-clip", "text")
      jq_get(atome_id).css("-webkit-text-fill-color", "transparent")
    end
    if self.type == :shape && self.path(nil,)
      `$('#'+#{atome_id}).children().css({fill: #{values}})`
      # elsif self.type == :image
      # alert values

      # alert :here_must_do_something
      # color = color_helper(values)
      # "linear-gradient(0deg,#{color},#{color})"
    else
      # we exclude the case when the path is defined because it means we need to use a svg
      if !values.instance_of?(Array) || values.length == 1
        if values.instance_of?(Array)
          value = values[0]
        else
          value = values
        end
        color = color_helper(value)
        val = "linear-gradient(0deg,#{color},#{color})"
        if self.type == :image
          if jq_get(atome_id).css("background-image").start_with?("url")
            self.mask_html({ content: self.content })
          end
          new_background = val + "," + jq_get(atome_id).css("background-image")
          jq_get(atome_id).css("background-image", new_background)
        else
          jq_get(atome_id).css("background-image", val)
        end
      else
        gradient = []
        values.each do |color_found|
          if color_found[:angle] || color_found[:diffusion]
            angle = color_found[:angle]
            diffusion = color_found[:diffusion]
          else
            gradient << color_helper(color_found)
          end
        end
        case diffusion
        when :linear
          val = "#{diffusion}-gradient(#{angle}deg,#{gradient.join(",")})"
          # alert atome_id+ " : "+values.to_s
          # alert gradient
          # alert val
        else
          val = "#{diffusion}-gradient(#{gradient.join(",")})"
        end
        if self.type == :image
          if jq_get(atome_id).css("background-image").start_with?("url")
            self.mask_html({ content: self.content })
          end
          new_background = val + "," + jq_get(atome_id).css("background-image")
          jq_get(atome_id).css("background-image", new_background)
        else
          jq_get(atome_id).css("background-image", val)
        end
      end
    end
  end

  def opacity_html(value)
    jq_get(atome_id).css(:opacity, value)
  end

  def border_html(value)
    pattern = value[:pattern]
    thickness = value[:thickness]
    color = color_helper(value[:color])
    if self.type == :shape && self.path
      `$('#'+#{atome_id}).children().css({stroke: #{color}})`
      `$('#'+#{atome_id}).children().css('stroke-width', #{thickness})`
    else
      jq_get(atome_id).css("border", thickness.to_s + "px " + pattern + " " + color)
    end
  end

  def overflow_html(value)
    if value.instance_of?(Hash)
      x = value[:x]
      y = value[:y]
      if x
        jq_get(atome_id).css("overflow-y", :visible)
        jq_get(atome_id).css("overflow-x", :visible)
      end
      if y
        jq_get(atome_id).css("overflow-y", y)
      end
    else
      jq_get(atome_id).css("overflow", value)
    end
  end

  def fill_html(value)
    self.x = self.y = 0
    size = ""
    number = ""
    if value.class == Hash
      target = value[:target]
      size = value[:size]
      number = value[:number]
    else
      target = if value.class == Atome
                 value
               else
                 get(value)
               end
    end
    if size.nil?
      size = self.size
    end
    width = if target.width.class == String && target.width.end_with?("%")
              target.convert(:width)
            else
              target.width
            end
    height = if target.height.class == String && target.width.end_with?("%")
               target.convert(:height)
             else
               target.height
             end
    jq_get(atome_id).css('width', width)
    jq_get(atome_id).css('height', height)
    jq_get(atome_id).css('background-repeat', 'space')
    if number
      size = width / number
    else
    end
    jq_get(atome_id).css('background-size', size)
  end
end