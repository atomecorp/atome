########################### meteo ####################################

  meteo("paris") do |data|
    text({content: "la temperature a paris est de : "+ data.to_s})
  end
