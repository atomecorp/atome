# ide

t=text(content: "open the ide", xx: 50)
t.touch do
  ide=code({atome_id: "ide_atome_id", content: :box})
  ide.size(396) do |evt|
    puts evt
  end
  ide.x(30)
end