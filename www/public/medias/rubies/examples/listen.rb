# example listen speech recognition

t=text("Say box, then red then smooth, also try blue circle")

listen(:english) do |sentence|
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
  else
  end
end
