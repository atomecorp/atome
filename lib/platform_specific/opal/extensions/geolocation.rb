# frozen_string_literal: true

class Atome
  def geolocation
    localisation = { latitude: nil, longitude: nil }
    $window.navigator.geolocate.then do |pos|
      localisation[:latitude] = pos.coords.latitude
      localisation[:longitude] = pos.coords.longitude
    end.rescue do |err|
      p err
      nil
    end
  end
end
