# example listen speech recognition

t = text({content:  "Say box, dessine moi un cercle, mets le en jaune, avance le vers la droite", y: 66, x: 33 })
t.touch do
  listen(:stop)
end
listen(:french) do |sentence|
  t.content = sentence
  if sentence.include?("box")
    grab(:the_box).delete(true)
    box({ atome_id: :the_box, x: 333 })
    if sentence.include?("red")
      grab(:the_box).color("red")
    end
    if sentence.include?("smooth")
      grab(:the_box).smooth(9)
    end
  elsif sentence.include?("circle")
    grab(:the_circle).delete(true)
    circle({ atome_id: :the_circle, x: 66, y: 66 })
    if sentence.include?("blue")
      grab(:the_circle).color("blue")
    end
  elsif sentence.include?("cercle")
    grab(:the_circle).delete(true)
    unless grab(:the_circle)
      circle({ atome_id: :the_circle, x: 66, y: 66 })
    end
    if sentence.include?("jaune")
      grab(:the_circle).color("yellow")
    elsif sentence.include?("avance") && sentence.include?("droite")
      grab(:the_circle).x=grab(:the_circle).x+90
    elsif sentence.include?("recule") && sentence.include?("gauche")
      grab(:the_circle).x=grab(:the_circle).x-90
    end
    # listen(:stop)
    # listen(:start)
  else
  end
end