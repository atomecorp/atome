module HtmlEffect
  def blur_html(value)
    value = value.read
    jq_get(atome_id).css("filter", "blur(" + value.to_s + "px)")
  end
end