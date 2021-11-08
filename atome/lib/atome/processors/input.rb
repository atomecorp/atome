module Processors
  def camera_pre_processor(value)
    media_pre_processor(:camera, :camera, value)
  end

  def camera_getter_processor
    @camera&.read
  end

  def microphone_pre_processor(value)
    media_pre_processor(:microphone, :microphone, value)
  end

  def microphone_getter_processor
    @microphone&.read
  end

  def midi_pre_processor(value)
    media_pre_processor(:midi, :midi, value)
  end

  def midi_getter_processor
    @midi&.read
  end

  def read_processor(value)
    ATOME.message({ type: :monitor, input: [1,2], target: :tryout, atome: :text, options: { color: :yellowgreen } })
    # alert value
  end


  def write_processor(value)
    ATOME.message({ type: :set, output: [1,2],content: value, target: :tryout, atome: :text, options: { color: :yellowgreen } })
    # alert value
  end
end