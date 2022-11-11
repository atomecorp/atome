# frozen_string_literal: true

# toolbox   method here
class Atome
  def identity_generator
    { date: Time.now, location: geolocation }
  end
end
