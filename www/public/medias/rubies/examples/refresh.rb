# refresh example
c=circle
c.text("click me")
color=[:red, :green,:yellowgreen, :purple, :blue, :yellow, :orange, :pink, :black, :white].sample
time=Time.now
text({content: time, color: color, x:66, y: 66})
a=grab(:view).child
c.touch do

  ATOME.reader("./medias/rubies/examples/refresh.rb") do |data|
    compile data
  end
  # a.render(false)
  # clear(:view)
  # a.each do |atome_on_stage|
  #   alert atome_on_stage.inspect
  # end
  # a.render(true)
end