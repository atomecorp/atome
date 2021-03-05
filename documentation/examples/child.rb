# child

c = circle({atome_id: :c, x: 20})
c.drag do
end
img=image(:red_planet)
e = c.box({atome_id: :e, x: 160})
t = c.text({content: 'touch me to open code editor', atome_id: :t, x: 300, width: 100, height: 200, x: 69})
b2=box({x:200})
c.child.color(:green)

c.child([img.atome_id, b2.atome_id])
c.child do |child_found|
  child_found.set({width: 100, height: 33, rotation: 36, y: 66})
end