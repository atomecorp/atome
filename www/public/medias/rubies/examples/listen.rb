# example listen speech recognition

t = text({content:  "Say box, dessine moi un cercle, mets le en jaune, avance le vers la droite", y: 66, x: 33 })

listen(:french) do |sentence|
  t.content = sentence
  if sentence.include?("box")
    grab(:the_box).delete
    box({ atome_id: :the_box, x: 333 })
    if sentence.include?("red")
      grab(:the_box).color("red")
    end
    if sentence.include?("smooth")
      grab(:the_box).smooth(9)
    end
  elsif sentence.include?("circle")
    grab(:the_circle).delete
    circle({ atome_id: :the_circle, x: 66, y: 66 })
    if sentence.include?("blue")
      grab(:the_circle).color("blue")
    end
  elsif t.content.include?("cercle")
    # grab(:the_circle).delete
    unless grab(:the_circle)
      circle({ atome_id: :the_circle, x: 66, y: 66 })
    end
    if t.content.include?("jaune")
      grab(:the_circle).color("yellow")
    elsif t.content.include?("avance") && t.content.include?("droite")
      grab(:the_circle).x=grab(:the_circle).x+90
    elsif t.content.include?("recule") && t.content.include?("gauche")
      grab(:the_circle).x=grab(:the_circle).x-90
    end
  else
  end
end
