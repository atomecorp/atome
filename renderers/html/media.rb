class MediaHtmlRenderer < IdentityHtmlRenderer
  def self.render_content(atome_id, params)
    "#{atome_id} #{params}"
  end
end