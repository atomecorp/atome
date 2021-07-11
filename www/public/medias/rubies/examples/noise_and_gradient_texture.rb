# noise example
# noise in a circle
c=circle({ width: 300, color: :green, x: 600 })
c.shadow({ x: 16, y: 16, blur: 7, color: :black})
c.noise({ opacity: 0.3 })

# b is used for a hack to allow correct shadow when using mask or noise then applying shadow
b=box({color: :transparent})
b.shadow({ x: 16, y: 16, blur: 7, color: :black})

a=b.image({content: :boat})
a.noise({ opacity: 0.6 })
a.color({red: 1, green: 0.3, blue: 0.5, alpha: 0.5})
# add gradient
a.color([{red: 0, green: 1, blue: 1, alpha: 0.1}, {red: 1, green: 0, blue: 0, alpha: 0.1}, {red: 0, green: 1, blue: 0, alpha: 0.1}, {angle: 150}, {diffusion: :linear}])
a.opacity(0.7)
a.drag(true)

# # with shape
# svg = shape({ path: :apple, drag: true, width: 333, height: 333, atome_id: :the_path})
# ATOME.wait 2 do
#   `$('#the_path').children().css({fill: 'blue'}).css({stroke: 'yellow'})`
#   svg.noise({ opacity: 1 })
# end