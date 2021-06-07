@molecules_list= { share: [{ authorization: [:read,:write] }],
                  blur: [:value],
                  shadow: [:blur, :x,:y, :thickness, { color:[:red, :green, :blue, :x, :y, diffusion: [:radial, :linear, :conic]] }] ,
                  smooth: [:value],
                  touch: [{ options: [:up, :down,:long, :double, :stop, :remove] }],
                  drag: [{ options: [:destroy, :disable, :containment, :lock, :handle] }]
}


@tools=[]
@atomes=[]
def molecule_analysis(molecules)
  molecules.each do |molecule, array_content|
    @tools << molecule
    array_content.each do |content|
      if content.instance_of?(Symbol)
        @atomes << content
      else
        molecule_analysis(content)
      end
    end
  end
  {molecules: molecules,tools: @tools, atomes: @atomes}
end




# notif @atomes


# todo add atome and molecule list inside mol api it self instead of this standalone list
# tod