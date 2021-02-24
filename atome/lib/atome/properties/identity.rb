module IdentitiesProperties
  def atome_id=(value)
    atome_id_processor(value)
    atome_id_html(@atome_id)
  end

  def atome_id
    @atome_id.read
  end

  def id=(value)
    @id = Quark.new(value)
  end

  def id
    @id.read
  end

  def type=(value)
    @type = Quark.new(value)
  end

  def type
    @type.read
  end
end