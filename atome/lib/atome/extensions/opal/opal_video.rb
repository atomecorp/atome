module JSUtils
  def video_play(options, &proc)
    `atome.jsVideoPlay(#{atome_id},#{options},#{proc})`
  end
end