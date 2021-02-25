module IdentityHtml
  def atome_id_html(value)
    value = value.read
    # this method create the basic html object
    jq_get("user_device").append("<div class='atome' id='#{value}'></div>")
    value
  end

  def id_html(value)
    value.read
  end

  def type_html(value)
    value.read
  end
end