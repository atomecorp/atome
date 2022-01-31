# wait

b=box({x:300})
t=text("click me to kill the wait process")
waiter= wait 5 do
  b.set({color: :orange, smooth: 20})
end

t.touch do
  t.clear({wait: waiter})
end


def notification(message,duration)
  notification=text({content: message, x: 300, y: 69})
  grab(:atome).wait duration do
    notification.delete()
  end
end

notification(:hello, 3)