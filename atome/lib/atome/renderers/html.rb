# render methods
module RenderHtml
  include HtmlAudio
  include HtmlCommunication
  include HtmlEffect
  include HtmlEvent
  include HtmlGeometry
  include HtmlHelper
  include HtmlHierarchy
  include HtmlIdentity
  include HtmlMedia
  include HtmlSpatial
  include HtmlUtility
  include HtmlVisual
  include JSUtils

  def self.jq_get(atome_id)
    Element.find("#" + atome_id[:value])
  end
end