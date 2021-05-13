module Processors

  def drag_pre_processor(value)
    case value
    when true
      @drag = atomise(:drag,{ drag: true})
    when :destroy
      @drag = atomise(:drag,{ option: :destroy})
    when :disable
      @drag = atomise(:drag,{ option: :disable})
    else
       @drag = atomise(:drag,value)
    end


  end

end