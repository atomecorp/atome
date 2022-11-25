# frozen_string_literal: true

# Rendering method here
class Atome
  private

  def rendering(element_to_render, content, &user_proc)
    render_engines = @atome[:renderers]
    render_engines.each do |render_engine|
      send("#{render_engine}_#{element_to_render}", content, &user_proc)
    end
  end
end
