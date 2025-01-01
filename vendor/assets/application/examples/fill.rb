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
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "3",
    "drag",
    "fill",
    "overflow",
    "png",
    "svg"
  ],
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "drag": {
    "aim": "The `drag` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `drag`."
  },
  "fill": {
    "aim": "The `fill` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fill`."
  },
  "overflow": {
    "aim": "The `overflow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `overflow`."
  },
  "png": {
    "aim": "The `png` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `png`."
  },
  "svg": {
    "aim": "The `svg` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `svg`."
  }
}
end
