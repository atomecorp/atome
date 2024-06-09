# frozen_string_literal: true


######## check

# Relaunch all tasks
relaunch_all_tasks

# Example: Schedule a task to run at a specific date and time
schedule_task('specific_time_task', 2024, 11, 12, 15, 12, 30) do
  puts "Task running at the specific date and time"
end

# Example: Schedule a task to run every minute
schedule_task('every_minute_task', 2024, 05, 12, 15, 12, 3, recurrence: :minutely) do
  puts "Task running every minute"
end

# Example: Schedule a task to run every Tuesday at the same time
schedule_task('weekly_tuesday_task', 2024, 11, 12, 15, 12, 30, recurrence: { weekly: 2 }) do
  puts "Task running every Tuesday at the same time"
end

# Example: Schedule a task to run every second Wednesday of the month at the same time
schedule_task('second_wednesday_task', 2024, 11, 12, 15, 12, 30, recurrence: { monthly: { week: 2, wday: 3 } }) do
  puts "Task running every second Wednesday of the month at the same time"
end

# Stop a task
# wait 133 do
#   puts 'stop'
#   stop_task('every_minute_task')
# end
