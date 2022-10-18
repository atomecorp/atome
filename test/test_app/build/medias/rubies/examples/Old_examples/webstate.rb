# webstate example

t=text(web_state)


b=box({x: 333})
b.touch do
  ATOME.message({ type: :code, content: "circle({x: 33,y: 33})" })
  t.content(web_state)
end