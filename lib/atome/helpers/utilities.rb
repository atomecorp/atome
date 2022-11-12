# frozen_string_literal: true

# toolbox   method here
class Atome

  private
  def identity_generator
    { date: Time.now, location: geolocation }
  end

  def broadcaster(property, value)
    puts  "===> broadcasting : #{property} #{value}"
  end

  def history(property, value)
    "historize : #{property} #{value}"
  end
end
