module PropertyHtml
  def content_html(value = "", type_mutation = false)
    # if render
    case type
    when :text
      value = value.to_s
      if type_mutation
        # we use the color scheme of the color method to display the text correctly
        color(color)
      end
      jq_get(atome_id).remove_text(atome_id)
      child_of_text_atome = jq_get(atome_id).html
      value = value.to_s.gsub("\n", "<br>")
      new_content = value + child_of_text_atome
      jq_get(atome_id).html(new_content)
      @width = atomise(:width, JSUtils.client_width(atome_id))
      @height = atomise(:height, JSUtils.client_height(atome_id))
    when :web
      if type_mutation
        # we use the color scheme of the color method to display the text correctly
        color(color)
      end
      jq_get(atome_id).remove_text(atome_id)
      child_of_text_atome = jq_get(atome_id).html
      new_content = value + child_of_text_atome
      jq_get(atome_id).html(new_content)
      jq_get(atome_id).html(new_content)
    when :shape
      if path
        path_getter_helper(path)
      elsif type_mutation
        jq_get(atome_id).css("-webkit-background-clip", "padding")
        jq_get(atome_id).css("background-color", color)
      end
      smooth(value[:tension]) if value[:tension]
    # when :volume
    #   alert "create 3D object!"
    when :video
      video_creator_helper(value)
    when :audio
      audio_creator_helper(value)
    when :camera
      camera_creator_helper(value)
    when :image
      image_creator_helper(value)
      jq_get(atome_id).css("background-color", "transparent") if type_mutation
    else
      # no treatment
    end
    # end
    # return unless render
  end
end