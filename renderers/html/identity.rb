module IdentityHtmlRenderer
  def self.render_atome_id(atome_id, params)
    "#{atome_id} #{params}"
  end

  def self.render_id(atome_id, params)
    "#{atome_id} #{params}"
  end

  def self.type(atome_id, params)
    "#{atome_id} #{params}"
  end
end