module HtmlHelpers
  def delete_html
    jq_get(atome_id).remove
  end
end