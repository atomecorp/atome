module Processors
  def media_pre_processor(type, preset, value, password = nil)
    # alert self.inspect
    if value.instance_of?(Hash) && value[:proc]
      # if a proc is found we yield we search for child of the requested type to be treated , ex :
      # a.text do |text_found|
      #text_found.color(:red)
      #end
      self.child(nil, password) do |child_found|
        if child_found.type(nil, password) == type
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
      #now we create the new atome
      Atome.new(preset_found)
    end
  end

  def group_pre_processor(value, password = nil)
    #todo allow group deletion and remove all monitoring binding
    #if there's a condition we feed the content else we treat the content directly
    if value[:condition]
      content_found = find(value[:condition])
    else
      content_found = []
    end
    if value[:content]
      content_found.concat(value[:content])
    end
    # we we atomise the content so it can be process directly
    value[:content] = self.atomiser(content: content_found)
    if value[:dynamic]
      # first we remove the scope that don't need to be treated
      value[:condition].delete(:scope)
      self.child.each do |child_found|
        child_found.monitor(true) do |evt|
          unless content_found.include?(child_found.atome_id)
            if value[:treatment] && (value[:condition].keys[0] == evt[:property] && value[:condition].values[0] == evt[:value])
              value[:treatment].each do |prop, val|
                child_found.send(prop, val, password)
              end
            end
          end
        end
      end
    end
    if value[:treatment]
      value[:treatment].each do |prop, val|
        self.content.send(prop, val)
      end
    end

    value = value.merge({ type: :find, render: false })
    Atome.new(value)
  end

  def container_pre_processor(value, password = nil)
    media_pre_processor(:shape, :container, value, password)
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

  def particle_pre_processor(value, password = nil)
    media_pre_processor(:particle, :particle, value, password)
  end

  def particle_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :particle
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end

  def shape_pre_processor(value, password = nil)
    media_pre_processor(:shape, :shape, value, password)
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

  def box_pre_processor(value, password = nil)
    media_pre_processor(:shape, :box, value, password)
  end

  def star_pre_processor(value, password = nil)
    # star_fabric(value)
    media_pre_processor(:shape, :star, value, password)
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

  def circle_pre_processor(value, password = nil)
    media_pre_processor(:shape, :circle, value, password)
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

  def text_pre_processor(value, password = nil)
    media_pre_processor(:text, :text, value, password)
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

  def image_pre_processor(value, password = nil)
    media_pre_processor(:image, :image, value, password)
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

  def video_pre_processor(value, password = nil)
    media_pre_processor(:video, :video, value, password)
  end

  def video_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :video
      end
    end
    atomise(:temp, child_collected)
  end

  def audio_pre_processor(value, password = nil)
    media_pre_processor(:audio, :audio, value, password)
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

  def web_pre_processor(value, password = nil)

    if value.instance_of?(Hash)
      if value[:type]
        type_found = value[:type]
        case type_found
          #Time.now is used to force refresh if the image changes
        when :iframe
          value = "<iframe class='atome' width='100%' height='180%' src='#{value[:path]}?#{Time.now}' frameborder='5' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen/>"
        when :image
          #Time.now is used to force refresh if the image changes
          value = "<image class='atome' width ='100%' height= '100%' src='#{value[:path]}?#{Time.now}'/>"
        when :audio
        when :video
        else
          value = "<iframe class='atome' width='100%' height='180%' src='#{value[:path]}?#{Time.now}' frameborder='5' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen/>"

        end
        media_pre_processor(:web, :web, value, password)
      elsif value[:address]
        JSUtils.adress(value[:address])
      else
      end

    end

  end

  def web_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :web
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end

  def visual_pre_processor(value, password)
    unless @visual
      @visual = atomise(:visual, value)
    end
    visual_html(value, password)
  end

  def active_processor(value, password)
    if value[:exec] == true
      value[:proc].call if value[:proc].is_a?(Proc)
    end
  end

  def inactive_processor(value, password)
    if value[:exec] == true
      value[:proc].call if value[:proc].is_a?(Proc)
    end
  end

  def tool_pre_processor(value, password = nil)
    media_pre_processor(:shape, :tool, value, password)
  end

  def tool_getter_processor
    child_collected = []
    child do |child_found|
      if child_found.type == :tool
        child_collected << child_found.atome_id
      end
    end
    atomise(:temp, child_collected)
  end

  def content_pre_processor(value, password)
    # treatment to get local version of text
    if value.instance_of?(Hash) && type == :text
      @content = atomise(:content, value.merge(atome_id: atome_id))
      required_language = self.language || grab(:view).language
      all_language_content = value
      value = all_language_content[required_language]
    elsif type == :text
      formated_value = { default: value, atome_id: atome_id }
      @content = atomise(:content, formated_value)
    else
      @content = atomise(:content, value)
    end

    def send_to_renderer(renderer, value, password)
      case renderer
      when :html
        content_html(value, password)
      when :fabric
        content_fabric(value, password)
      when :headless
        content_headless(value, password)
      when :speech
        content_speech(value, password)
      when :three
        content_three(value, password)
      when :zim
        content_zim(value, password)
      else
        content_html(value, password)
      end
    end

    if $default_renderer.nil?
      content_html(value, password)
    elsif $default_renderer.instance_of?(Array)
      $default_renderer.each do |renderer|
        send_to_renderer(renderer, value, password)
      end
    else
      send_to_renderer($default_renderer, value, password)
    end

  end

  def content_getter_processor
    # alert  grab(:view).language
    if self.type == :text
      # if  @content.read.instance_of?(Hash)
      #   @content.read[:default]
      # else
      #   @content
      # end
      @content
    else
      @content&.read
    end
  end

end
