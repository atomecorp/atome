# frozen_string_literal: true

require 'geocoder'

class Atome
  def geolocation
    # native version
    public_ip = `curl https://api.ipify.org`
    results = Geocoder.search(public_ip)
    results.first.coordinates
  end
end

