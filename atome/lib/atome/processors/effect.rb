module Processors
  def shadow_pre_processor(value)
    default = { x: 0, y: 0, thickness: 0, blur: 6, color: { red: 0, green: 0, blue: 0, alpha: 0.6 } }
    if value == true
      value = default
    end
    if value.instance_of?(Array)
      collected_values=[]
      value.each do |value_found|
        collected_values << default.merge(value_found)
      end
      value = collected_values
    elsif value ==false || value ==:delete
      value = :delete
    else
      value = default.merge(value)
    end
    @shadow = atomise(:shadow, value)
    shadow_html(value)
  end

  def noise_pre_processor(value)
     if value== true
       value={}
     end
    default_value={intensity:50, opacity: 0.3,width: self.width,height: self.height, color: false}
    value=default_value.merge(value)
    @noise = atomise(:noise, value)
    noise_html(value)
  end
end