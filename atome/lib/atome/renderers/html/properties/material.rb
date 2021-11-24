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

    values = if @visual.q_read.instance_of?(Hash)
               # if it's a hash it means that the visual already exist
               @visual.q_read.merge(values)
             else
               basic_visuals.merge(values)
             end
    path_get = values[:path]
    size_get = values[:size]
    # for later use
    width_get = values[:width]
    haight_get = values[:height]
    alignment_get = values[:alignment]
    selection = values[:select]
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
    # if values == :red
    # #   if jq_get(atome_id).children().length == 0
    #     alert self.properties
    #   # end
    # end
    angle = 180
    diffusion = "linear"
    if type == :text
      # we use a stencil to allow gradient in text
      jq_get(atome_id).css("-webkit-background-clip", "text")
      jq_get(atome_id).css("-webkit-text-fill-color", "transparent")
    end
    if self.type == :shape && self.path(nil,)
      `$('#'+#{atome_id}).children().css({fill: #{values}})`
    else

      # we exclude the case when the path is defined because it means we need to use a svg

      if !values.instance_of?(Array) || values.length == 1

        value = if values.instance_of?(Array)
                  values[0]
                else
                  values
                end
        color = color_helper(value)
        val = "linear-gradient(0deg,#{color},#{color})"
        if self.type == :image

          if jq_get(atome_id).css("background-image").start_with?("url")
            if jq_get(atome_id).children().length() == 0
              jq_get(atome_id).append("<div id= '#{atome_id}_mask' style='position: absolute;display: inline-block; background-color: transparent;width:100%;height:100%''></div>")
            end
            sub_atome = jq_get(atome_id).children.first
            # alert sub_atome
            atome_background = jq_get(atome_id).css("background-image")
            # sub_atome.css("-webkit-mask-image": atome_background)
            sub_atome.css("mask-image": atome_background)
            sub_atome.css("mask-size": "100% 100%")
            # sub_atome.css("mask-size": "50% 50%")
          end
          # new_background = val + "," + jq_get(atome_id).css("background-image")
            if sub_atome
              # new_background = val + "," + jq_get(atome_id).css("background-image")
              # new_background = "linear-gradient(0deg,rgba(255,0,0,0.3),rgba(255,0,0,0.3))"
              new_background = val
              # alert new_background
              # alert new_background.class
              sub_atome.css("background-image", new_background)


            else
              new_background = val + "," + jq_get(atome_id).css("background-image")

              jq_get(atome_id).css("background-image", new_background)
            end
          # sub_atome.css("width", "33px");
          # sub_atome.css("height", "100px");
          # sub_atome.css("top", "0px");
          # sub_atome.css("left", "0px");
          # sub_atome.css("height", "100px");
          # sub_atome.css("background-position", " bottom 0px right 0px");
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
        val = case diffusion
              when :linear
                "#{diffusion}-gradient(#{angle}deg,#{gradient.join(",")})"
                # alert atome_id+ " : "+values.to_s
                # alert gradient
                # alert val
              else
                "#{diffusion}-gradient(#{gradient.join(",")})"
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

  def blend_html(value)
    jq_get(atome_id).css("mix-blend-mode", value)
  end
end