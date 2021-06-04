def atome_list
  [:authorization,:share,:value, :x, :y, :z, :thickness, :red, :green, :blue, :alpha, :up, :down, :long, :double , :stop, :remove ]
end
def molecules_list
  { share: [:authorization, :share],
    blur: [:value],
    shadow: [:blur, :x,:y, :thickness, :color] ,
    smooth: [:value],
    touch: [{ options: [:up, :down,:long, :double, :stop, :remove] }],
    drag: [{ options: [:destroy, :disable, :containment, :lock, :handle] }],
    options: [:up, :down,:long, :double, :stop, :remove, :destroy, :disable, :containment, :lock, :handle ]
  }
end