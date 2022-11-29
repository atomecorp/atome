# frozen_string_literal: true

#  callbacks methods here
class Atome
  private

  attr_accessor :drag_start_proc, :drag_move_proc, :drag_end_proc

  public

  def schedule_callback(proc)
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def read_callback(file, proc)
    instance_exec(file, &proc) if proc.is_a?(Proc)
  end

  def time_callback(current_time)
    @atome[:time] = current_time
    return unless @at_time[:time] && (current_time.round(1) > @at_time[:time] && @at_time[:used].nil?)

    proc = @at_time[:code]
    instance_exec(current_time, &proc) if proc.is_a?(Proc)
    @at_time[:used] = true
  end

  def drag_start_callback(page_x, page_y, left_val, top_val)
    @atome[:left] = left_val
    @atome[:top] = top_val
    proc = @drag_start_proc
    instance_exec({ pageX: page_x, pageY: page_y, left: left_val, top: top_val }, &proc) if proc.is_a?(Proc)
  end

  def drag_move_callback(page_x, page_y, left_val, top_val)
    proc = @drag_move_proc
    @atome[:left] = left_val
    @atome[:top] = top_val
    instance_exec({ pageX: page_x, pageY: page_y, left: left_val, top: top_val }, &proc) if proc.is_a?(Proc)
  end

  def drag_end_callback(page_x, page_y, left_val, top_val)
    @atome[:left] = left_val
    @atome[:top] = top_val
    proc = @drag_end_proc
    instance_exec({ pageX: page_x, pageY: page_y, left: left_val, top: top_val }, &proc) if proc.is_a?(Proc)
  end
end
