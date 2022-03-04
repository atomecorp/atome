# child

c = circle({atome_id: :c, x: 20, drag: true})
img=image({content: :red_planet, atome_id: :red_planet})
c.box({atome_id: :e, x: 160})
c.text({content: 'some text', atome_id: :t, width: 100, height: 200, x: 69})
b2=box({x:200, atome_id: :the_box})
c.child.color(:white)

c.child([img.atome_id, b2.atome_id])
c.child do |child_found|
  child_found.set({width: 100, height: 33})
end

c.child.each do |child_found|
  child_found.set({width: 100, height: 33, rotate: 36, y: 66})
end

c.child.blur(3)
c.child[:red_planet].y(200)
b2.parent[1].color({ red: 1, green: 1, blue: 0, alpha: 0.3 })

