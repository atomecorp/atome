
class Atome
  def geolocation
    # native version
    public_ip = `curl https://api.ipify.org`
    Geocoder.search(public_ip)
    # puts results.first.coordinates
  end
end

