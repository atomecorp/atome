# frozen_string_literal: true

_alarm_format = '2022,11,27,12,06,0'
time_to_run = Time.now + 3
t=text ({ data: "an event  schedule will create a box" })
t.width(555)
a = element({})

a.schedule(time_to_run) do
  puts 'event executed'
  t.delete(true)
  grab(:view).box #FIXME: box doesnt work we must use a grab , plaese fix
end
