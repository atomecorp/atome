module UtilitiesProperties
  def delete=(value)
    @delete = atomise(value)
    delete_html(@delete)
  end

  def delete
    @delete.read
  end

  def render=(value)
    @render = atomise(value)
    render_html(@render)
  end

  def render
    @render.read
  end

  def tactile=(value)
    @tactile = atomise(value)
  end

  def tactile
    @tactile.read
  end
end
