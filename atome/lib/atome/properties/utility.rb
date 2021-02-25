module UtilitiesProperties
  def render=(value)
    @render = atomise(value)
    render_html(@render)
  end

  def render
    @render&.read
  end

  def tactile=(value)
    @tactile = atomise(value)
  end

  def tactile
    @tactile&.read
  end

  def edit=(value)
    @edit = atomise(value)
  end

  def edit
    @edit&.read
  end
end
