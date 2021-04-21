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
    else
      value = default.merge(value)
    end
    @shadow = atomise(:shadow, value)
    shadow_html(value)
  end
end