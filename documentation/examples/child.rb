# child

c = circle({atome_id: :c, x: 20})
c.drag do
end
e = box({atome_id: :e, x: 160})
t = text({content: 'touch me to open code editor', atome_id: :t, x: 300, width: 100, height: 200, x: 69})
c.child([t.atome_id, e.atome_id])
c.child do |fils|
  fils.set({width: 100, height: 33, rotation: 36, y: 66})
end

c.child.color(:orange)