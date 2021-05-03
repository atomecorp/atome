module JSUtils

  def audio_dsp(options, &proc)
    `audioHelper.basicSynth(#{atome_id},#{options},#{proc})`
  end

  def midi_controller(controller, value)
    `midiHelper.send_cc(#{controller} ,#{value})`
  end

  def midi_play(note, channel, options)
    `midiHelper.play(#{note} ,#{channel}, #{options})`
  end

  def midi_stop(note, channel, options)
    `midiHelper.stop(#{note} ,#{channel},#{options})`
  end

  def midi_inputs
    `midiHelper.inputs()`
  end

  def midi_outputs
    `midiHelper.outputs()`
  end
end