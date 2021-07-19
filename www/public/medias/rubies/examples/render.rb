# refresh example
JSUtils.load_opal_parser
# alert grab(:view).child
c=circle
c.text("click me")
color=[:red, :green,:yellowgreen, :purple, :blue, :yellow, :orange, :pink, :black, :white].sample
time=Time.now
text({content: time, color: color, x:66, y: 66})
c.touch do
  # alert grab(:view).child
  clear(:view)
  # alert @@atomes
  wait 3 do
    reader("./medias/rubies/examples/refresh.rb") do |data|
      compile data
    end
  end
end
t=text("standard version")
t.xx(33)
alert ATOME.poil