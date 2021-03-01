module Processors
  def media_processor(type, value)
    if value == true
      value = {}
    elsif value.instance_of?(String)
      value = {content: value}
    end
    preset = grab(:preset).get(:content)
    preset = preset[type]
    preset = preset.merge(value)
    atome = Atome.new(preset)
    atome.parent = atome_id
    atome
  end

  def box_processor(value)
    media_processor(:box, value)
  end

  def box_getter_processor(value)
    alert "processor media line 7 : #{value}get the box if needed to be created"
    #  box()
  end

  def circle_processor(value)
    media_processor(:circle, value)
  end

  def circle_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  circle()
  end

  def text_processor(value)
    media_processor(:text, value)
  end

  def text_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  text()
  end

  def image_processor(value)
    media_processor(:image, value)
  end

  def image_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  image()
  end

  def video_processor(value)
    media_processor(:video, value)
  end

  def video_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  video()
  end

  def audio_processor(value)
    media_processor(:audio, value)
  end

  def audio_getter_processor(value)
    alert "processor media line 17 : #{value}get the box if needed to be created"
    #  audio()
  end
end