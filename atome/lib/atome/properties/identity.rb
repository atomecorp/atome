module IdentitiesProperties
  def atome_id=(value)
    atome_id_processor(value)
    atome_id_html(value)
  end

  def atome_id
    @atome_id
  end

  def id=(value)
    @id = value
  end

  def id
    @id
  end

  def type=(value)
    @type = value
  end

  def type
    @type
  end
end