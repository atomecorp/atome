class HelperHtmlRenderer < GeometryHtmlRenderer
  def self.render_tactile(atome_id, params)
    "#{atome_id} #{params}"
  end
end