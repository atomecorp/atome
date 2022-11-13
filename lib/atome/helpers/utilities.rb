# frozen_string_literal: true

# toolbox   method here
class Atome

  private

  def identity_generator
    { date: Time.now, location: geolocation }
  end

  def broadcasting(property, value)
    puts "::>#{@broadcast}"
    # @broadcast.each do |k,v|
    #   puts "===> (#{k}, #{v})"
    # end
  end

  def history(property, value)
    "historize : #{property} #{value}"
  end
end
