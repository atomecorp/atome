# history example recall all activities including coded creation or creation made with tools

history= Quark.get_history
time_get =history[0][:atome][:time]
formated_time=Time.at(time_get)
text ({ content: formated_time, x: 0, color: :orange })
text ({ content: history[33].to_s, y: 33, color: :orange  })