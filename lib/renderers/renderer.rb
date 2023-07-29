# frozen_string_literal: true

# Rendering method here
class Atome
  private

  # def method_missing(name, *args)
  #   puts "atome method missing : #{name},params are #{args}"
  # end

  def render(element, params, &user_proc)
    render_engines = @atome[:renderers]
    render_engines.each do |render_engine|
      # puts  "rendering : send('#{render_engine}_#{self.type}_#{element}', #{params}\n#{self})"
      # send("#{render_engine}_#{self.type}_#{element}", params, &user_proc)
      if render_engine == :html
        puts "Temporary condition : #{render_engine}_#{self.type}_#{element}, #{params}"
        send("#{render_engine}_#{self.type}_#{element}", params, &user_proc)
      else
        puts "element : #{element}"
        send("#{render_engine}_#{element}", params, &user_proc)
      end
    end
  end
end
