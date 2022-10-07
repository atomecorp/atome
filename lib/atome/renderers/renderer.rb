# frozen_string_literal: true

# Main render engine
module Render
  def self.render(property, value, atome, &proc)
    required_renderers = atome.render
    required_renderers.each do |renderer|
      renderer_name = "#{property}_#{renderer}"
      send(renderer_name, value, proc)
    end
  end
end
