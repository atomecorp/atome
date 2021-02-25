module HierarchyHtml
  def parent_html(value)
    value = value.read
    # parent.append(child)
    jq_get(value).append(jq_get(atome_id))
  end
end