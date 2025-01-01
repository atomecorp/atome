# frozen_string_literal: true



def format_time
  time = Time.now
  {
    year: time.year,
    month: time.month,
    day: time.day,
    hour: time.hour,
    minute: time.min,
    second: time.sec
  }
end

# Exemple d'utilisation

t=text({data: "message here", id: :messenger})

schedule_task('every_minute_task', format_time[:year], format_time[:month], format_time[:day], format_time[:hour], format_time[:minute], format_time[:second]+5, recurrence: :minutely) do
  t.data("every minute i change from :#{format_time}, now : #{format_time[:minute]} , #{format_time[:second]}")
end