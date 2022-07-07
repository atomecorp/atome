
class Atome
  def geolocation
    localisation = {latitude: nil, longitude: nil}
    $window.navigator.geolocate.then do |pos|
      localisation[:latitude] =  pos.coords.latitude
      localisation[:longitude] =  pos.coords.longitude
      # alert self.inspect
    end.rescue do |err|
      p  err
      localisation = nil
    end
  end
end
