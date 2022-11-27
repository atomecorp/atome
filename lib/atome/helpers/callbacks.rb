# frozen_string_literal: true

#  callbacks methods here
class Atome
  def schedule_callback(proc)
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def read_callback(file, proc)
    instance_exec(file, &proc) if proc.is_a?(Proc)
  end
end
