# frozen_string_literal: true

image({id: :planet,path: 'medias/images/red_planet.png', width: 66,height: 66,  left: 33, top: 33})
b=box({width: 66, height: 66, color: :yellowgreen})

  wait 1 do

    b.opacity(0.3)
  end
