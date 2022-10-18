image(:avion)
b=image(:atome)
b.shadow(true)

t=text"blending mode"
modes=[:normal,:multiply,:screen,:overlay,:darken,
       :lighten,"color-dodge","color-burn","hard-light","soft-light","difference","exclusion","hue",
       "saturation","color","luminosity"]
modes.each_with_index do |mode,index|

  wait 1*index do
    t.content(mode)
    b.blend(mode)
  end
end