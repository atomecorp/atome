# frozen_string_literal: true

b=box({width: 300, height: 333})
image({id: :logo,path: 'medias/images/logos/atome.svg', width: 66, left: 555})
grab(:black_matter).image({id: :planet,path: 'medias/images/red_planet.png', width: 66,height: 66,  left: 555, top: 180})


new({particle: :fill})

new({ method: :fill, renderer: :html }) do |params|
  html.fill(params)
end
b.fill({atome:  :logo, width: 33, height: 33 })

wait 1 do
  b.fill({atome:  :planet, width: 33, height: 33 })
end