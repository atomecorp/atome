module PropertyHtml
  def parent_html(value)
    jq_get(value).append(jq_get(atome_id))
  end

  def child_html(value)
    jq_get(atome_id).append(jq_get(value))
  end
end