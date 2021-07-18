module Processors

  def say_pre_processor(value, password = nil)

    @say = atomise(:say, value)
    # if value.instance_of?(String)
    #   value = { content: value }
    # end
    #
    # unless value[:voice]
    #   value[:voice] = get_language
    # end
    # if $default_renderer.nil?
      say_html(value, password)
    # elsif $default_renderer.instance_of?(Array)
    #   $default_renderer.each do |renderer|
    #     send_to_renderer(renderer, value, password)
    #   end
    # else
    #   send_to_renderer($default_renderer, value, password)
    # end

  end
end
