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

  def action_getter_processor
    proc= @action.q_read[:proc]
    instance_exec &proc if proc.is_a?(Proc)
  end


  def tag_pre_processor(params)
  if @tag.nil?
    @tag=atomise(:tag, params)
  elsif @tag
    if @tag.instance_of?(Quark)
      @tag=atomise(:tag, @tag&.q_read.merge(params))
    end
  end
  end
end
