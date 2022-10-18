# refresh example

c=circle({ atome_id: :circle})
c.text({content: "click me", atome_id: :text_2, shadow: true })
color=[:red, :green,:yellowgreen, :purple, :blue, :yellow, :orange, :pink, :black, :white].sample
time=Time.now
text({content: time, color: color, x:66, y: 66, atome_id: :text_1, shadow: true})
c.color(color)
c.touch do
  refresh("./medias/rubies/examples/refresh.rb")
end
# Possible syntax are :
# refresh #without arguments it refresh the current page
# refresh("./medias/rubies/examples/animation.rb")
# refresh({ source: "./medias/rubies/examples/animation.rb" })
# refresh({ target: :circle })
# refresh({ target: :circle , source: "./medias/rubies/examples/animation.rb" })
