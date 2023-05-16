# frozen_string_literal: true

#  callbacks methods here
class Atome
  private

  attr_accessor :drag_start_proc, :drag_move_proc, :drag_end_proc,
                :drop_action_proc,:over_action_proc,
                :play_start_proc, :play_active_proc, :play_end_proc,
                :animation_start_proc, :animation_active_proc, :animation_stop_proc

  public

  def schedule_callback(proc)
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def read_callback(file, proc)
    file_content=file.split('</head><body>')[1].split('</body></html>')[0]
    # FIXME : found why '> is converted to &gt;'
    file_content=file_content.gsub("&gt;", ">")
    instance_exec(file_content, &proc) if proc.is_a?(Proc)
  end

  def time_callback(current_time, markers)
    @atome[:time] = current_time
    markers.each_value do |marker|
      # check if the current time matches the time of the marker, thanks to chat GPT for the example
      if current_time >= marker[:begin] && current_time < marker[:end]
        code_found = marker[:code]
        instance_exec(current_time, &code_found) if code_found.is_a?(Proc)
      end
    end
  end

  # drag callbacks
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
    # alert :loo
    # #now we rest the position
    # self.left(left_val)
    # self.top(top_val)
    proc = @drag_end_proc
    instance_exec({ pageX: page_x, pageY: page_y, left: left_val, top: top_val }, &proc) if proc.is_a?(Proc)
  end

  # drop callbacks
  def drop_action_callback( data_found, _full_event)
    proc = @drop_action_proc
    instance_exec(data_found, &proc) if proc.is_a?(Proc)
  end

  # def over_action_callback( data_found, _full_event)
  #   proc = @enter_action_proc
  #   instance_exec(data_found, &proc) if proc.is_a?(Proc)
  # end

  # drop callbacks
  def enter_action_callback( data_found, _full_event)
    proc = @enter_action_proc
    instance_exec( data_found,&proc) if proc.is_a?(Proc)
  end

  def leave_action_callback(data_found)
    proc = @leave_action_proc
    instance_exec( data_found,&proc) if proc.is_a?(Proc)
  end


  # def drag_move_callback(page_x, page_y, left_val, top_val)
  #   proc = @drag_move_proc
  #   @atome[:left] = left_val
  #   @atome[:top] = top_val
  #   instance_exec({ pageX: page_x, pageY: page_y, left: left_val, top: top_val }, &proc) if proc.is_a?(Proc)
  # end
  #
  # def drag_end_callback(page_x, page_y, left_val, top_val)
  #   @atome[:left] = left_val
  #   @atome[:top] = top_val
  #   proc = @drag_end_proc
  #   instance_exec({ pageX: page_x, pageY: page_y, left: left_val, top: top_val }, &proc) if proc.is_a?(Proc)
  # end

  # sort callbacks
  def sort_callback(atome)
    sort_proc = @sort_proc
    instance_exec(atome, &sort_proc) if sort_proc.is_a?(Proc)
  end

  # animation
  def browser_animate_callback(particle_found, value, animation_hash, original_particle, animation_atome)
    anim_proc = animation_hash[:code]
    #  we exec the callback bloc from :animate
    instance_exec({ original_particle => value }, &anim_proc) if anim_proc.is_a?(Proc)
    # we exec the callback bloc from :play
    play_proc = animation_atome.play_active_proc
    instance_exec({ @atome[particle_found] => value }, &play_proc) if play_proc.is_a?(Proc)
    # we animate:
    browser_object.style[particle_found] = value if browser_object
    # we update the atome property
    @atome[original_particle] = value
  end

  def play_start_callback(_particle_found, _start_value, animation_hash, original_particle, atome_found)
    value = animation_hash[:begin][original_particle]
    value = atome_found.atome[original_particle] if value == :self
    start_proc = @animation_start_proc
    @atome[original_particle] = value
    instance_exec({ original_particle => value }, &start_proc) if start_proc.is_a?(Proc)
  end

  def play_stop_callback(_particle_found, _end_value, animation_hash, original_particle, _atome_found)
    value = animation_hash[:end][original_particle]
    end_proc = @animation_stop_proc
    @atome[original_particle] = value
    instance_exec({ original_particle => value }, &end_proc) if end_proc.is_a?(Proc)
  end
end
