module PropertylHtml
  def atome_id_html(value)
    value = value.read
    # this method create the basic html object

    value
  end

  def id_html(value)
    value.read
  end

  #def type_html(value)
  #  value=value.read
  #  alert value
  #  #if render
  #  #  #alert 'pol'
  #  #  #render_html(atomise(:render, true))
  #  #  jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
  #  #end
  #  #unless @type == :particle
  # #render_html(atomise(:value,true))
  #  #alert("msg from propertyhtml line 16 :#{atome_id} #{value}")
  #  #end
  #end
end

#def type(value = nil, &proc)
#  if value.nil? && !proc
#    @type&.read
#  else
#    value = properties_common(value, &proc)
#    #type_pre_processor(value, &proc)
#    @type = atomise(:type,value)
#    type_html(@type)
#    self
#  end
#end