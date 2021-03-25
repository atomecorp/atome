module JSUtils
  def video_play(options, &proc)
    `mediaHelper.playVideo(#{atome_id},#{options},#{proc})`
  end
end