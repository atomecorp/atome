# render methods
module RenderHtml
  include AudioHtmlRenderer
  include CommunicationHtmlRenderer
  include EffectHtmlRenderer
  include EventHtmlRenderer
  include GeometryHtmlRenderer
  include HelperHtmlRenderer
  include HierarchyHtmlRenderer
  include IdentityHtmlRenderer
  include MediaHtmlRenderer
  include SpatialHtmlRenderer
  include UtilityHtmlRenderer
  include VisualHtmlRenderer

  def self.jq_get(atome_id)
    Element.find("#" + atome_id[:value])
  end

end