module Processors
  def monitor_processor(value)
    # we only call the proc when there's a value to monitor empty event that is send  applying monitor methods onto
    # the atome
    if value[:value]
      proc = value[:proc]
      proc.call(value) if proc.is_a?(Proc)
    end
  end

  def render_processor(value)
    case engine
    when :fabric
      render_fabric(value)
    when :headless
      render_headless(value)
    when :html
      render_html(value)
    when :speech
      render_speech(value)
    when :three
      render_three(value)
    when :zim
      render_zim(value)
    else
      render_html(value)
    end
  end
end
