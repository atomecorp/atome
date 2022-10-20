
" date can be entered in  several ways , 2 digit it'll be the next time the seconds match ,
if 2 digits the minutes and seconds and so on, you can also enter Time.now+3 (not a,string) for schedule in 3 sec "

time_to_run= Time.now+6
puts 'event schedule'
schedule(time_to_run) do
  puts 'event executed'
  # i=image({ content: :boat , drag: :true, x: 99, y:99 })
  # wait 2 do
  #   i.delete(true)
  # end
end