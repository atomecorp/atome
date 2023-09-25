# frozen_string_literal: true

# Rendering method here
class Atome
  # private

  def render(element, params, &user_proc)
    render_engines = @atome[:renderers]
    render_engines.each do |render_engine|
      # in case we found an exception the method call will have the form, example for color top  : html_color_top
      exception_found = "#{Universe.get_atomes_specificities[self.type][element]}"
      send("#{render_engine}_#{exception_found}#{element}", params, &user_proc)
    end
  end
end
