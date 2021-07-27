########################### meteo ####################################
meteo("paris") do |data|
  text({content:  "la temperature à paris est de : #{data} °c", x: 33, y: 33 })
end
