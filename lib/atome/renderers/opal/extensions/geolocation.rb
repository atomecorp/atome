

# def geolocation
# native version
#   # public_ip = `curl https://api.ipify.org`
#   # results = Geocoder.search(public_ip)
#   # puts results.first.coordinates
# end

def geolocation
  localisation = {latitude: nil, longitude: nil}
  $window.navigator.geolocate.then do |pos|
    localisation[:latitude] =  pos.coords.latitude
    localisation[:longitude] =  pos.coords.longitude
  end.rescue do |err|
    p  err
    localisation = nil
  end
end
