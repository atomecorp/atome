module HierarchyHtml
  def parent_html(value)
    value = value.read
    # parent.append(child)
    jq_get(value).append(jq_get(atome_id))
  end

  def child_html(value)
    value = value.read
    # child.append_to(parent)
    jq_get(atome_id).append_to(jq_get(value))
  end
end