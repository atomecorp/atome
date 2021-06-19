
t=text( "touch me to set the websocket adress to localhost ('0.0.0.0:9292')")
t2=ext({y: 30, content: "touch me to reset the websocket adress to atome.one" })

t.touch do
  ATOME.websocket
  #second parameter is ssl (true or false)
  #or  ATOME.websocket('0.0.0.0:9292', false)
end

t2.touch do
  ATOME.websocket("ws.atome.one", true)
end