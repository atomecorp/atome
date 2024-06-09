# frozen_string_literal: true

require 'time'
# Helper method to store task configuration in localStorage
def store_task(name, config)
  JS.global[:localStorage].setItem(name, config.to_json)
end

# Helper method to retrieve task configuration from localStorage
def retrieve_task(name)
  config = JS.global[:localStorage].getItem(name)
  config.nil? ? nil : JSON.parse(config)
end

# Helper method to retrieve all tasks from localStorage
def retrieve_all_tasks
  tasks = []
  local_storage = JS.global[:localStorage]
  if Atome::host == "web-opal"
    local_storage.each do |key|
      value = local_storage.getItem(key)
      if value
        value= JSON.parse(value)
        tasks << { name: key, config:value }
      end
    end
  else
    length = local_storage[:length].to_i
    length.times do |i|
      key = local_storage.call(:key, i)
      value = local_storage.call(:getItem, key)
      tasks << { name: key, config: JSON.parse(value.to_s) } if value
    end
  end
  tasks
end

# Helper method to schedule a task
def schedule_task(name, years, month, day, hours, minutes, seconds, recurrence: nil, &block)
  target_time = Time.new(years, month, day, hours, minutes, seconds)
  now = Time.now

  if target_time < now
    schedule_recurrence(name, target_time, recurrence, &block)
  else
    seconds_until_target = target_time - now
    wait_task = wait(seconds_until_target) do
      block.call
      schedule_recurrence(name, target_time, recurrence, &block) if recurrence
    end
    store_task(name, { wait: wait_task, target_time: target_time, recurrence: recurrence })
  end
end

def schedule_recurrence(name, target_time, recurrence, &block)
  now = Time.now
  next_time = target_time

  case recurrence
  when :yearly
    next_time += 365 * 24 * 60 * 60 while next_time <= now
  when :monthly
    next_time = next_time >> 1 while next_time <= now
  when :weekly
    next_time += 7 * 24 * 60 * 60 while next_time <= now
  when :daily
    next_time += 24 * 60 * 60 while next_time <= now
  when :hourly
    next_time += 60 * 60 while next_time <= now
  when :minutely
    next_time += 60 while next_time <= now
  when :secondly
    next_time += 1 while next_time <= now
  when Hash
    if recurrence[:weekly]
      wday = recurrence[:weekly]
      next_time += 7 * 24 * 60 * 60 while next_time <= now
      next_time += 24 * 60 * 60 until next_time.wday == wday
    elsif recurrence[:monthly]
      week_of_month = recurrence[:monthly][:week]
      wday = recurrence[:monthly][:wday]
      while next_time <= now
        next_month = next_time >> 1
        next_time = Time.new(next_month.year, next_month.month, 1, target_time.hour, target_time.min, target_time.sec)
        next_time += 24 * 60 * 60 while next_time.wday != wday
        next_time += (week_of_month - 1) * 7 * 24 * 60 * 60
      end
    end
  else
    puts "Invalid recurrence option"
    return
  end

  seconds_until_next = next_time - Time.now
  wait_task = wait(seconds_until_next) do
    block.call
    schedule_recurrence(name, next_time, recurrence, &block)
  end
  store_task(name, { wait: wait_task, target_time: next_time, recurrence: recurrence })
end

# Helper method to stop a scheduled task
def stop_task(name)
  task_config = retrieve_task(name)
  return unless task_config

  stop({ wait: task_config['wait'] })
  JS.global[:localStorage].removeItem(name)
end

# Method to relaunch all tasks from localStorage
def relaunch_all_tasks
  tasks = retrieve_all_tasks

  tasks.each do |task|
    name = task[:name]
    config = task[:config]
    target_time_found = config['target_time']
    target_time = Time.parse(target_time_found)
    recurrence_found = config['recurrence']
    next unless recurrence_found
    recurrence = config['recurrence'].is_a?(Hash) ? config['recurrence'].transform_keys(&:to_sym) : config['recurrence'].to_sym
    puts "found : #{name}, #{target_time.year}, #{target_time.month}, #{target_time.day}, #{target_time.hour}, #{target_time.min}, #{target_time.sec}, recurrence: #{recurrence}"
    schedule_task(name, target_time.year, target_time.month, target_time.day, target_time.hour, target_time.min, target_time.sec, recurrence: recurrence) do
      puts "Relaunched task #{name}"
    end
  end
end

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
