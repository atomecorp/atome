# fit example

b=box({size: 96})
b.image({ content: :boat, size: :fit })

t=text({content: "my text"})
t.border({color: :orange, thickness: 7, pattern: :solid})
c=circle({x: 333})
c.touch do
  t.visual({fit: :width})
  notification "element height is :#{t.height}"
  bbb.size({ fit: t.atome_id, margin: { x: 33, y: 33 } })
  bbb.size({ fit: t.atome_id, margin: 66 })
  t.center(true)
end