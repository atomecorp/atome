# frozen_string_literal: true

# Rendering method here
class Atome
  private

  def rendering(element,params, &user_proc)
    render_engines = @atome[:renderers]
    render_engines.each do |render_engine|
      # puts  "rendering : send('#{render_engine}_#{element}', #{params},   &user_proc)"
      send("#{render_engine}_#{element}", params, &user_proc)
    end
  end
end
