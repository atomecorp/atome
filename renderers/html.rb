# render methods
class RenderHtml < VisualHtmlRenderer

  def self.jq_get(atome_id)
    Element.find("#" + atome_id[:value])
  end

end