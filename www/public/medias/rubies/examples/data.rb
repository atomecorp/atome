# data example
# data property is used to store datas inside the atome
bb=box(width: 333)
bb.text("touch me")
bb.data("data stored here")
bb.touch do
  t=text({y: 133})
  t.content(bb.data)
end

