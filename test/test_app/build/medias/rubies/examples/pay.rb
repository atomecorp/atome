# pay example

c=circle({width: 300})
c.text({content:  "buy an atome: 10€", center: true })
c.touch do
  box({atome_id: :my_payment, pay: "https://www.paypal.com/sdk/js?client-id=sb&enable-funding=venmo&currency=EUR",width: 222, height: 220, drag: true, x: 99, y: 120})
end
