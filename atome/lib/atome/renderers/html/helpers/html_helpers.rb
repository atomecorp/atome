module HtmlHelpers
  def delete_html
    jq_get(atome_id).remove
  end

  def play_html(options, &proc)
    video_play(options, proc)
    # audio_play(options, proc)
  end
end