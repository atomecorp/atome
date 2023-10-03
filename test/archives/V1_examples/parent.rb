# parent example

# an atome can have multiple parents. (for now, please note that only the last setted parent is the real father, it ll be change i the future)
c = circle({ atome_id: :c, x: 20 })
c.drag(true)
e = box({ atome_id: :e, x: 160 })
t = text({ content: 'some texts', atome_id: :the_father_text, x: 96 })
t.parent([e.atome_id, c.atome_id])
grab(:view).extract(t.atome_id)
t.parent do |father|
  father.set({ rotate: 36, y: 66 })
end
t.parent.blur(2)
wait 1 do
  grab(:view).attach(grab(:the_father_text))
  t.set(x: 33, y: 33,)
  # fixme bug we have to re add the content
  t.content("bug we have to re add the content")
  t.width(:auto)
end
# both parent are treated