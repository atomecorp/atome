module Processors
  def drag_pre_processor(value)
    case value
    when true
      @drag = atomise(:drag, { drag: true })
    when :destroy
      @drag = atomise(:drag, { option: :destroy })
    when :disable
      @drag = atomise(:drag, { option: :disable })
    else
      @drag = atomise(:drag, value)
    end
  end

  def touch_pre_processor(value)
    if value.instance_of?(Array)
      value.each do |param|
        touch_pre_processor(param)
      end
    else
      @touch ||= atomise(:touch, [:remove])
      if value[:remove]
        @touch = atomise(:touch, [value])
      elsif @touch
        prev_content = @touch.q_read
        prev_content << value
        @touch = atomise(:touch, prev_content)
      else
        @touch = atomise(:touch, [value])
      end
      # alert @touch.q_read
      touch_html(@touch.q_read)

      # if @drag
      #   # alert :poi
      #   # alert @atome_id
      #   prev_drag=@drag.q_read
      #   drag(:destroy)
      #   drag(prev_drag)
      # #   # alert prev_drag
      #   drag(true)
      # end

    end


    # end
  end

  # def touch_pre_processor(value)
  #
  #   if value[:remove]
  #     @touch = atomise(:touch, [value])
  #   elsif @touch
  #     prev_content = @touch.q_read
  #     prev_content << value
  #     @touch = atomise(:touch, prev_content)
  #   else
  #     @touch = atomise(:touch, [value])
  #   end
  #   alert @touch.q_read
  #   touch_html(@touch.q_read)
  #   # if @drag
  #   #   drag(@drag.q_read)
  #   wait 1 do
  #     self.drag(true)
  #   end
  #
  #   # end
  # end

  # def touch_pre_processor(value)
  #   # @touch ||= atomise(:touch, [value])
  #   if value[:remove]
  #     alert :case1
  #     @touch = atomise(:touch, [value])
  #   else
  #     if @touch
  #       prev_content = @touch.q_read
  #       prev_content << value
  #       @touch = atomise(:touch, prev_content)
  #     else
  #       @touch ||= atomise(:touch, [value])
  #     end
  #   end
  #   touch_html(@touch.q_read)
  # end
end

