# frozen_string_literal: true

# Essentials method here
class Atome
  private

  def get(element)
    @atome[element]
  end

  # def value
  #   @atome
  # end

  def to_s
    # if @value
    #   alert "what is value: #{value}"
    #   @result = @value.to_s
    # elsif @atome
    #   @result = @atome.to_s
    # end
    # @result.to_s
    @atome.to_s
  end
end
