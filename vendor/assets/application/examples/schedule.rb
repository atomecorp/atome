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
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "data",
    "day",
    "hour",
    "min",
    "month",
    "now",
    "sec",
    "year"
  ],
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "day": {
    "aim": "The `day` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `day`."
  },
  "hour": {
    "aim": "The `hour` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `hour`."
  },
  "min": {
    "aim": "The `min` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `min`."
  },
  "month": {
    "aim": "The `month` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `month`."
  },
  "now": {
    "aim": "The `now` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `now`."
  },
  "sec": {
    "aim": "The `sec` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `sec`."
  },
  "year": {
    "aim": "The `year` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `year`."
  }
}
end
