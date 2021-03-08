module HtmlHelpers
  def delete_html
    jq_get(atome_id).remove
  end

  def play_html(options, &proc)
    video_play(options, proc)
    # audio_play(options, proc)
  end

  def resize_html(&proc)
    Element.find(JSUtils.device).resize do
      width = jq_get(:view).css("width").sub("px", "").to_i
      height = jq_get(:view).css("height").sub("px", "").to_i
      proc.call({width: width, height: height}) if proc.is_a?(Proc)
    end
  end
end