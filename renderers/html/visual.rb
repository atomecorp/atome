class VisualHtmlRenderer < UtilityHtmlRenderer
  def self.color(atome_id, params)
    alert "render #{atome_id} #{params}"
  end

  def self.opacity(atome_id, params)
    alert "render #{atome_id} #{params}"
  end

  def self.border(atome_id, params)
    alert "render #{atome_id} #{params}"
  end

  def self.overflow(atome_id, params)
    "#{atome_id} #{params}"
  end
end