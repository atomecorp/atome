# Batch

c = circle({atome_id: :c, x: 200})
t = text({content: 'touch me to open code editor', atome_id: :t,x: 300, width: 100, height: 200})
e = box({atome_id: :e, x: 100})
batch([c, t, e]).y(66).color(:cyan).rotate(33).blur(3)