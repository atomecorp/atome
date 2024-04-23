
new(application: {name: :compose })


grab(:toto).color(:cyan)

def layout
  compose_back=box

  compose_back.color({ alpha: 0 })
  media_reader=compose_back.box({left: 99, width: 250, height: 250, top: 99})
  viewer_1=compose_back.box({left: 360, width: 250, height: 250, top: 99})
  viewer_2=compose_back.box({left: 690, width: 250, height: 250, top: 99})
  timeline=compose_back.box({left: 99, width: 250, height: 250, top: 399})
  login=compose_back.text(:log)
  login.touch(true) do
    compose_back.delete(true)
    # grab(:view).clear(true)
    form
  end

end

def form
  form1=box
  form1.text(:login)

  form1.touch(true) do
    form1.delete(true)
    layout
  end

end
form
