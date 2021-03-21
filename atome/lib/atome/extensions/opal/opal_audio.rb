module JSUtils
  def audio_play(options, &proc)
    `atome.jsAudioPlay(#{atome_id},#{options},#{proc})`
  end

  def audio_dsp(options, &proc)
    `atome.jsAudio(#{atome_id},#{options},#{proc})`
  end

  def midi_communication(options, &proc)
    `atome.jsMidi(#{atome_id},#{options},#{proc})`
  end

  def midi_play(note, channel, options)
    `atome.jsMidi_play(#{note} ,#{channel}, #{options})`
  end

  def midi_stop(note, channel, options)
    `atome.jsMidi_stop(#{note} ,#{channel},#{options})`
  end

  def midi_inputs
    `atome.jsMidi_inputs()`
  end

  def midi_outputs
    `atome.jsMidi_outputs()`
  end
end