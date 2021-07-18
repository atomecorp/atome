module Processors

  def say_pre_processor(value, password = nil)
    if value.instance_of?(String)
      value = { content: value }
    end

    unless value[:voice]
      value[:voice] = get_language
    end
    @say = atomise(:say, value)
    # def send_to_renderer(renderer, value, password)
    #   case renderer
    #   when :html
    #     say_html(value, password)
    #   when :fabric
    #     say_fabric(value, password)
    #   when :headless
    #     say_headless(value, password)
    #   when :speech
    #     say_speech(value, password)
    #   when :three
    #     say_three(value, password)
    #   when :zim
    #     say_zim(value, password)
    #   else
    #     nil
    #   end
    # end

    if $default_renderer.nil?
      say_html(value, password)
    elsif $default_renderer.instance_of?(Array)
      $default_renderer.each do |renderer|
        send_to_renderer(renderer, value, password)
      end
    else
      send_to_renderer($default_renderer, value, password)
    end

  end
end
