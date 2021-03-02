module Processors

  def media_pre_processor(type, value)
    if value == true
      value = {}
    elsif value.instance_of?(String)
      value = {content: value}
    end
    preset = grab(:preset).get(:content)
    preset = preset[type]
    # we overload the parent to the current and finnaly add the value set by user
    preset = preset.merge({parent: atome_id}).merge(value)
    Atome.new(preset)
  end

  def box_pre_processor(value)
    media_pre_processor(:box, value)
  end

  def box_getter_processor(value)
      @box&.read
  end

  def circle_pre_processor(value)
    media_pre_processor(:circle, value)
  end

  def circle_getter_processor(value)
    @circle&.read
  end

  def text_pre_processor(value)
    media_pre_processor(:text, value)
  end

  def text_getter_processor(value)
    @text&.read
  end

  def image_pre_processor(value)
    media_pre_processor(:image, value)
  end

  def image_getter_processor(value)
    @image&.read
  end

  def video_pre_processor(value)
    media_pre_processor(:video, value)
  end

  def video_getter_processor(value)
    @video&.read
  end

  def audio_pre_processor(value)
    media_pre_processor(:audio, value)
  end

  def audio_getter_processor(value)
    @audio&.read
  end
end