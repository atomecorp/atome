# key

c=circle({width: 300})
t=c.text({content: "type some text on me!", width: 33, color: :black, x: 33, y: 15 , size: 16})
c.key({option: :press}) do |evt|
  t.content(evt.key_code)
end