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



m=map({id: :hgfh, longitude: 55.9876876, latitude: 33.987687, width: 333, height: 222,})
# wait 3 do
p=map({id: :poilo, location: :auto, width: 333, height: 333, top: 333 , left: 333, zoom: 3})
# end
b=box
# b.touch(true) do
#   m.zoom(33)
#   # p.zoom(3)
#   # wait 2 do
#     p.pan({ left: 370, top: 190 })
#   # end
# end

# m=map({id: :locator, location: :auto})

# alert m.longitude


