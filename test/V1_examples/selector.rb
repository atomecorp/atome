# selector

c = circle({ atome_id: :c, x: 300, y: 96, color: :cyan })
c.selector({ toto: :titi })

text "selectors are : #{c.selector}"