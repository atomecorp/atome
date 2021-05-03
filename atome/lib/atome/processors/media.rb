module Processors
  def media_pre_processor(type, preset, value)
    if value.instance_of?(Hash) && value[:proc]
      # if a proc is found we yield we search for child of the requested type to be treated , ex :
      # a.text do |text_found|
      #text_found.color(:red)
      #end
      child do |child_found|
        if child_found.type == type
          value[:proc].call(child_found) if value[:proc].is_a?(Proc)
        end
      end
    else
      if value == true
        value = {}
      elsif value.instance_of?(String)
        value = { content: value }
      end
      preset_found = grab(:preset).get(:content)
      preset_found = preset_found[preset]
      # we overload the parent to the current and finally add the value set by user
      preset_found = preset_found.merge({ parent: atome_id }).merge(value)
      Atome.new(preset_found)
    end
  end


  def group_pre_processor(value)
    # parent_found= self.atome_id

    # content = find(value[:condition])
    new_group=Atome.new({ type: :find, render: false, name: value[:name], content: content, condition: value[:condition], dynamic: value[:dynamic] })
    alert "media.rb line 33, group is : #{new_group.inspect}"

        # value = properties_common(value, &proc)
        # @group = atomise(:content, value)
  end

  def container_pre_processor(value)
    media_pre_processor(:shape, :container, value)
  end

  def container_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :shape
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end

  def shape_pre_processor(value)
    media_pre_processor(:shape, :box, value)
  end

  def shape_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :shape
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end

  def box_pre_processor(value)
    media_pre_processor(:shape, :box, value)
  end

  def box_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :shape
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end

  def circle_pre_processor(value)
    media_pre_processor(:shape, :circle, value)
  end

  def circle_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :shape
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end

  def text_pre_processor(value)
    media_pre_processor(:text, :text, value)
  end

  def text_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :text
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end

  def image_pre_processor(value)
    media_pre_processor(:image, :image, value)
  end

  def image_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :image
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end

  def video_pre_processor(value)
    media_pre_processor(:video, :video, value)
  end

  def video_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :video
      end
    end
    atomise(:temp, child_collected)
  end

  def audio_pre_processor(value)
    media_pre_processor(:audio, :audio, value)
  end

  def audio_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :audio
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end
end