# action example
a = box({ atome_id: :the_box })
a.action do
    a.animation({
                start: { x: 3, y: 33 },
                end: { x: 99, y: 99 },
                duration: 3000,
                loop: 0,
                target: a.atome_id
              })
    a.play(true)
end
a.action