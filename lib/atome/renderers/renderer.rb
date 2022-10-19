# frozen_string_literal: true

# Main render engine
module Render
  def render_engine(property, value, atome, &proc)

    renderer_found = atome.render
    renderer_found.each do |renderer|
      renderer_name = "#{property}_#{renderer}"
      send(renderer_name, value,atome, &proc)
    end
  end
end
