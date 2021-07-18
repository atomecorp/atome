module Processors

  def say_pre_processor(value, password = nil)
    @say = atomise(:say, value)
      say_html(value, password)
  end
end
