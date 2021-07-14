module FabricProperty
  def render_fabric(value)
    # `add_fabric_object("canvas_id", #{val})`
    alert(inspect)
    if initialised_libraries(:fabric)
      `add_fabric_object(#{inspect[:atome_id]}, #{{type: :triangle,radius: 16, fill: 'red', id: "circle_id", left: 300, top: 100}})`
    else
      `fabric(#{inspect[:atome_id]}, #{{type: :triangle,radius: 16, fill: 'red', id: "circle_id", left: 300, top: 100}})`
    end
    # alert "super ok good!!"
    # # first in any case we remove the atome if it already exist
    # jq_get(atome_id).remove
    # # we also remove pseudo element: (the one created when using different rendering type : list, bloc, ...)
    # temp_list_obj_id = "#{atome_id}_temp_list_obj"
    # grab(temp_list_obj_id).delete
    # if value
    #   jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
    #   properties_found = self.properties
    #   properties_found.delete(:render)
    #   if value == true
    #     # we render the object in natural mode
    #     # fixme "attention the filter are re applied at each render : \n#{properties_found}"
    #     properties_found.each do |property, value_found|
    #       self.send(property, value_found)
    #     end
    #   elsif value.instance_of?(Hash)
    #     # the object will be render in other mode could be list , bloc , spoken , etc...
    #     case value[:mode]
    #     when :list
    #       render_list(value)
    #     when :bloc
    #       # todo
    #     else
    #       puts "no rendering"
    #     end
    #   end
    # end
  end
end