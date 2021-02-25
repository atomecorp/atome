module RenderHelper
  def color_helper(value)
    case value
    when Hash
      red = if value[:red]
        value[:red] * 255
      else
        0
      end
      green = if value[:green]
        value[:green] * 255
      else
        0
      end
      blue = if value[:blue]
        value[:blue] * 255
      else
        0
      end
      alpha = if value[:alpha]
        value[:alpha] * 1
      else
        1
      end
      value = "rgba(#{red},#{green},#{blue},#{alpha})"
    when Array
      puts "todo : create gradient"
    else
      value
    end
    value
  end

  def video_creator__helper(value)
    path = if $videos_list[value.to_sym].nil?
      "././medias/videos/video_missing.mp4"
    else
      $videos_list[value.to_sym][:path]
    end
    jq_get(atome_id).create(atome_id)
    jq_get(atome_id).find("video").html("<source src=" + path + " type='video/mp4'></source>")
    # unless width
    #  width = jq_get(atome_id).find("video").width
    # end
    # unless height
    #  height = jq_get(atome_id).find("video").height
    # end
    jq_get(atome_id).find("video").css("width", "100%")
  end
end