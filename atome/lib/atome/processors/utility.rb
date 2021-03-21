module Processors
  def monitor_processor(value)
    # we only call the proc when there's a value to monitor empty event that is send send applying monitor methods onto
    # the atome
    if value[:value]
      proc = value[:proc]
      proc.call(value) if proc.is_a?(Proc)
    end
  end
end
