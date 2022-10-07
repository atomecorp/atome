# frozen_string_literal: true

# Main render engine
module Render
  def render_engine(property, value, atome, &proc)
    puts "#{property}, #{value}"
    # renderer_found = atome.render
    # renderer_found.each do |renderer|
    #   renderer_name = "#{property}_#{renderer}"
    #   send(renderer_name, value, &proc)
    # end
  end
end
