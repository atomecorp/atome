module JSUtils
  def js_play(options, &proc)
    case self.type
    when :audio
      `videoHelper.playAudio(#{atome_id},#{options},#{proc})`
    when :video
      `videoHelper.playVideo(#{atome_id},#{options},#{proc})`
    else
      `videoHelper.playVideo(#{atome_id},#{options},#{proc})`
    end
  end
end