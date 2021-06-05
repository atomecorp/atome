# def atome_list
#   [:authorization,:share,:value, :x, :y, :z, :thickness, :red, :green, :blue, :alpha, :up, :down, :long, :double , :stop, :remove ]
# end
def molecules_list
  { share: [{ authorization: [:read,:write] }],
    blur: [:value],
    shadow: [:blur, :x,:y, :thickness, { color:[:red, :green, :blue, :x, :y, diffusion: [:radial, :linear, :conic]] }] ,
    smooth: [:value],
    touch: [{ options: [:up, :down,:long, :double, :stop, :remove] }],
    drag: [{ options: [:destroy, :disable, :containment, :lock, :handle] }]
  }
end


molecules=[]
atomes=[]
molecules_list.each do |molecule, atome_or_molecule|
  puts

end