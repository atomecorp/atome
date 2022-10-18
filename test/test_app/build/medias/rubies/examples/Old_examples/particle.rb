# particle exam≈ple :

p=particle({ color: :cyan,
             rotate: 33,
             y: 150,
             width: 333,
             shadow: { color: :black, blur: 3, x: 3, y: 3 },
             content: "particle can be used as placeholder or style repository"
           })
t =text({x: 99, content: p, atome_id: :verif})
t.set(p)
b=box
b.set(p)

circle.y(p.width)