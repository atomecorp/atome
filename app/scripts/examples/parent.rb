# parent

# an atome can have multiple parents. (for now, please note that only the last setted parent is the real father, it ll be change i the future)
c = circle({atome_id: :c, x: 20})
c.drag do
end
e = box({atome_id: :e, x: 160})
t = text({content: 'some texts', atome_id: :t, x: 300, width: 100, height: 200})
t.parent([e.atome_id, c.atome_id])
t.parent do |father|
  father.set({width: 100, height: 33, rotate: 36, y: 66})
end
t.parent.color(:orange)
#both parent are treated