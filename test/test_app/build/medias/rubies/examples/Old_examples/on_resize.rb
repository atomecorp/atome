# window resize

t = text({content: "window size", x: 66})
ATOME.resize_html do |evt|
  t.content("#{evt[:width]}  #{evt[:height]}")
end

stop = text({ content: "touch me to unbind resize event" , y: 63})

stop.touch do
  ATOME.resize_html(:false)
end