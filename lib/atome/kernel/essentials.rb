# frozen_string_literal: true

# Essentials method here
class Atome
  private

  def rendering(element_to_render, content, &user_proc)
    render_engines = @atome[:render]
    render_engines.each do |render_engine|
      send("#{render_engine}_#{element_to_render}", content, &user_proc)
    end
  end

  def get(element)
    @atome[element]
  end

  def value
    @atome
  end

  def to_s
    if @value
      @result = @value.to_s
    elsif @atome
      @result = @atome.to_s
    end
    @result.to_s
  end
end
