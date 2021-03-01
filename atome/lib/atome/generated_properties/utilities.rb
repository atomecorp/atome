module UtilitiesProperties
  def edit(value = nil, &proc)
    if value.nil? && !proc
      @edit&.read
    else
      value = properties_common(value, &proc)
      @edit = atomise(value)
      edit_html(@edit)
    end
  end 
 def edit=(value, &proc)
  edit(value, &proc)
 end

  def record(value = nil, &proc)
    if value.nil? && !proc
      @record&.read
    else
      value = properties_common(value, &proc)
      @record = atomise(value)
      record_html(@record)
    end
  end 
 def record=(value, &proc)
  record(value, &proc)
 end

  def enliven(value = nil, &proc)
    if value.nil? && !proc
      @enliven&.read
    else
      value = properties_common(value, &proc)
      @enliven = atomise(value)
      enliven_html(@enliven)
    end
  end 
 def enliven=(value, &proc)
  enliven(value, &proc)
 end

  def selector(value = nil, &proc)
    if value.nil? && !proc
      @selector&.read
    else
      value = properties_common(value, &proc)
      @selector = atomise(value)
      selector_html(@selector)
    end
  end 
 def selector=(value, &proc)
  selector(value, &proc)
 end

  def render(value = nil, &proc)
    if value.nil? && !proc
      @render&.read
    else
      value = properties_common(value, &proc)
      @render = atomise(value)
      render_html(@render)
    end
  end 
 def render=(value, &proc)
  render(value, &proc)
 end

  def preset(value = nil, &proc)
    if value.nil? && !proc
      @preset&.read
    else
      value = properties_common(value, &proc)
      @preset = atomise(value)
      preset_html(@preset)
    end
  end 
 def preset=(value, &proc)
  preset(value, &proc)
 end

end
