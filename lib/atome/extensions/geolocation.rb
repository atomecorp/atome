# frozen_string_literal: true

require 'geocoder'

# add on for the atome method
class Atome
  def geolocation
    # native version
    public_ip = `curl https://api.ipify.org`
    results = Geocoder.search(public_ip)
    results.first.coordinates
  end
end
