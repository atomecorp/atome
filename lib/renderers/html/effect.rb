# frozen_string_literal: true

new({ renderer: :html, method: :smooth, type: :string }) do |value, _user_proc|
  format_params = case value
                  when Array
                    data_collected = []
                    value.each do |param|
                      data_collected << "#{param}px"
                    end
                    data_collected.join(' ')
                  when Integer
                    "#{value}px"
                  else
                    if value.is_a?(String) && value.end_with?('%')
                      value
                    else
                      "#{value}px"
                    end
                  end
  html.style('border-radius', format_params)
end

new({ renderer: :html, method: :blur, type: :integer }) do |params, _user_proc|
    if params[:affect] == :back || params[:affect] == :back
      html.backdropFilter(:blur, "#{params[:value]}px")
    else
      html.filter(:blur, "#{params[:value]}px")
    end
  end


new({ renderer: :html, method: :blur, type: :integer, specific: :shadow }) do |params, _user_proc|
  if params[:affect] == :back || params[:affect] == :back
    html.backdropFilter(:blur, "#{params[:value]}px")
  else
    html.filter(:blur, "#{params[:value]}px")
  end
  # now we refresh if needed for dynamic refresh od affected atomes
   affect(affect)
end

# new({ particle: :blur, category: :effect, type: :int , specific: :shadow}) do |params|
#   alert :cool
#   if affect.nil?
#     affect_to = affect
#   else
#     affect_to = [:self]
#   end
#   val= { value: params, affect: affect_to } unless params.instance_of?(Hash)
#   val
# end