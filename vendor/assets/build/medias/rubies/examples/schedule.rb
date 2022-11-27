# frozen_string_literal: true

_alarm_format = '2022,11,27,12,06,0'
time_to_run = Time.now + 2
puts 'event schedule'
a = element

a.schedule(time_to_run) do
  alert 'event executed'
end
