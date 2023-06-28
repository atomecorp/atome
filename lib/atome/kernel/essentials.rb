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
    if type == :group
      # if the atome is a group we need to collect the atomes of the group
      atomes_found=[]
      @atome[:grouped].each do |atome_found|
        atomes_found <<  grab(atome_found).atome
      end
      atomes_found.to_s
    else
      @atome.to_s
    end

  end
end
