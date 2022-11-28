# frozen_string_literal: true

#  callbacks methods here
class Atome
  def schedule_callback(proc)
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def read_callback(file, proc)
    instance_exec(file, &proc) if proc.is_a?(Proc)
  end

  def time_callback(current_time)
    @atome[:time] = current_time
    if @at_time[:time] && (current_time.round(1) > @at_time[:time] && @at_time[:used].nil?)
      proc = @at_time[:code]
      instance_exec(current_time, &proc) if proc.is_a?(Proc)
      @at_time[:used] = true
    end
  end
end
