b=box({drag: true,atome_id: :the_box})
t=b.text({content: :hello, atome_id: :the_text})
b.text({content: :cool, x: 72, atome_id: :the_text_1})
b.text({content: :super, y: 66, atome_id: :the_text_2})
b.text({content: "too much", y: 66, x: 96,  atome_id: :the_text_3})
b.circle({x: 333, atome_id: :the_circle})
t.center(:all)
# we can treat all text of b using .each
b.circle.each do |circles_founc|
  circles_founc.color(:green)
end
# or iterate  on the object type
b.text do |atome|
  atome.color(:orange)
end

ATOME.wait 2 do
  # or even directly setting the property
  b.text.color(:cyan)
  # or choose an atome
  b.text[2].color(:red)
  # or a range of atomes
  ATOME.wait 2 do
    b.text[0..1].color(:yellow)
  end
end