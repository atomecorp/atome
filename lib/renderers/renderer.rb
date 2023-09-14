# frozen_string_literal: true

# Rendering method here
class Atome
  #private

  # def method_missing(name, *args)
  #   puts "atome method missing : #{name},params are #{args}"
  # end

  def render(element, params, &user_proc)
    render_engines = @atome[:renderers]
    # puts "render_engines : #{render_engines}"
    # puts "params : #{params}"
    # puts "render_engines: #{render_engines}"
    render_engines.each do |render_engine|
      # in case we found an exception the method call will have the form, example for color top  : html_color_top
      exception_found = "#{Universe.get_atomes_specificities[self.type][element]}"

      # puts  "1 => rendering :   #{render_engine}_#{exception_found}#{element} :  #{params}"
      send("#{render_engine}_#{exception_found}#{element}", params, &user_proc)
      # send("#{render_engine}_#{self.type}_#{element}", params, &user_proc)
    end
  end
end
