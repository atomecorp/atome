# frozen_string_literal: true

# Main render engine
class Renderer

  include ServerRenderer
  include HeadlessRenderer
  include OpalRenderer
end

module Render

  @render_engine = Renderer.new
  # @server_render_engine = ServerRenderer.new
  # @headless_render_engine = HeadlessRenderer.new
  def self.render(property, value, atome, &proc)
    required_renderers = atome.render
    required_renderers.each do |renderer|
      renderer_name = "#{property}_#{renderer}"
      @render_engine.send(renderer_name, value, &proc)
    end
  end
end

