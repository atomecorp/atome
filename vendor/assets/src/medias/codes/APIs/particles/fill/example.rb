# frozen_string_literal: true

b=box({width: 300, height: 333, color: {alpha: 0}})
image({id: :logo,path: 'medias/images/logos/atome.svg', width: 66, left: 555})
grab(:black_matter).image({id: :planet,path: 'medias/images/red_planet.png', width: 66,height: 66,  left: 555, top: 180})


b.fill([atome:  :logo, width: 33, height: 33 ])
b.overflow(:hidden)
wait 1 do
  b.fill([atome:  :planet, width: 33, height: 33 ])
  wait 1 do
    b.fill([{atome:  :planet,repeat: {x: 5, y: 3}}])
    wait 1 do
      b.fill([{atome:  :planet,width: 33, height: 33 ,rotate: 33, size: { x: 800,y: 600 }, position: { x:-200,y: -200 } }])
      wait 3 do
        b.fill([{atome:  :planet,repeat: {x: 5, y: 3}}, { atome: :logo, width: 33, height: 33 ,  opacity: 0.3} ])
      end
    end
  end
end

b.drag(true)