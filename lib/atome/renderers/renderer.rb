# frozen_string_literal: true

# main render routerclass Renderer
# class Renderer
#   include ServerRenderer
#   include HeadlessRenderer
#   include OpalRenderer
# end

# Main render engine
module Render
  # @render_engine = Renderer.new
  def render_engine(property, value, atome, &proc)
    renderer_found = atome.render
    puts "::::: self is #{self}"
    renderer_found.each do |renderer|
      renderer_name = "#{property}_#{renderer}"
      send(renderer_name, value, &proc)
    end
  end
end
