# key

c=circle({width: 300})
t=c.text({content: "type some text on me!", width: 280, color: :black, x: 33, y: 15})
c.key({option: :down}) do |evt|
  t.content( evt.key_code)
end