module Processors
  def camera_pre_processor(value)
    media_pre_processor(:camera, value)
  end

  def camera_getter_processor
    @camera&.read
  end

  def microphone_pre_processor(value)
    media_pre_processor(:microphone, value)
  end

  def microphone_getter_processor
    @microphone&.read
  end

  def midi_pre_processor(value)
    media_pre_processor(:midi, value)
  end

  def midi_getter_processor
    @midi&.read
  end
end