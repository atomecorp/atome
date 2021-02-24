module UtilitiesProperties
  def delete=(value)
    @delete = Quark.new(value)
    delete_html(@delete)
  end

  def delete
    @delete.read
  end

  def render=(value)
    @render = Quark.new(value)
    render_html(@render)
  end

  def render
    @render.read
  end
end
