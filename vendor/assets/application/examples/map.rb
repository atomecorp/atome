# new({ atome: :map, type: :hash })

# new({particle: :longitude}) do |params, _user_proc|
#   render(:map, {longitude: params })
#   params
# end
#
# new({particle: :latitude}) do |params, _user_proc|
#   render(:map, {latitude: params })
#   params
# end

# new({ method: :map, renderer: :html, type: :int }) do |params, _user_proc|
#   latitude_found=@latitude
#   longitude_found=@longitude
#   location_hash={longitude: longitude_found, latitude: latitude_found}.merge(params)
#   html.location(location_hash)
# end



m=map({id: :locator, longitude: 55.9876876, latitude: 33.987687, width: 699, height: 333})
wait 3 do
  m.delete(true)
  map({id: :locator, location: :auto})
end

# m=map({id: :locator, location: :auto})

# alert m.longitude


