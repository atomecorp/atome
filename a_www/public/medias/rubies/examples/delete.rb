# delete

b = box()
c = b.text({content: :ok})
c.circle({atome_id: :the_c, color: :green, x:96})
d = b.text({content: :ok2, y: 30, atome_id: :the_second_text})
d.circle({y: 96})
info_text=text({content:  "click the box to delete the childs\nthe :view childs are : #{b.child}", x: 96, y: 96, width: :auto})
b.touch do
  info_text.content( "the childs are : #{b.child}")
  b.child.delete
end