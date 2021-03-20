#clear

b=box({atome_id: :the_box})
c=circle(x: 96)
t=text({content: "click tme to clear the screen", atome_id: :the_text})
t2=text({content: "hello", x: 96, y: 96})
image({content: :boat, size: 96, x: 96, y: 96})
image({content: :moto, size: 96, y: 96})
t.touch do
  clear(:view)
end