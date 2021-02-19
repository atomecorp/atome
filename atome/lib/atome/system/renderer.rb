module Renderer
  def render_properties(params)
    params.each do |atome_id, properties|
      properties.each do |property, value|
        RenderHtml.send("render_#{property}", atome_id, value[:value])
      end
    end
    params
  end
end