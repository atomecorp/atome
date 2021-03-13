module PropertylHtml
  def blur_html(value)
    value = value.read
    jq_get(atome_id).css("filter", "blur(" + value.to_s + "px)")
  end

  def smooth_html(value)
    value = value.read
    formated_params = case value
                      when Array
                        properties = []
                        value.each do |param|
                          properties << param.to_s + "px"
                        end
                        properties.join(" ").to_s
                      when Integer
                        value
                      else
                        value
                      end
    jq_get(atome_id).css("border-radius", formated_params)
  end
end