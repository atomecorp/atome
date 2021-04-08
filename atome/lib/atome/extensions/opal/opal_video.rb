module JSUtils
  def video_play(options, &proc)
    `videoHelper.playVideo(#{atome_id},#{options},#{proc})`
  end
end