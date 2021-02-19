class VisualHtmlRenderer < UtilityHtmlRenderer
  def self.render_color(atome_id, params)
    "#{atome_id} #{params}"
  end

  def self.render_overflow(atome_id, params)
    "#{atome_id} #{params}"
  end
end