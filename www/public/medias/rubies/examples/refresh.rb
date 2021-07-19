# refresh example
JSUtils.load_opal_parser

def refresh (all_object=true)
  if all_object
    clear(:view)
    ATOME.reader("./medias/rubies/examples/refresh.rb") do |data|
      compile data
    end
  else

  end
end
c=circle({ atome_id: :circle})
c.text({content: "click me", atome_id: :text_2 })
color=[:red, :green,:yellowgreen, :purple, :blue, :yellow, :orange, :pink, :black, :white].sample
time=Time.now
text({content: time, color: color, x:66, y: 66, atome_id: :text_1})
c.touch do
  refresh
end