# window resize

t = text({content: "window size", x: 66})
ATOME.resize_html do |evt|
  t.content("#{evt[:width]}  #{evt[:height]}")
end