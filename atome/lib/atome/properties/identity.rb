module IdentitiesProperties
  def atome_id=(value)
    atome_id_processor(value)
    atome_id_html(@atome_id)
  end

  def atome_id
    @atome_id.read
  end

  def id=(value)
    @id = atomise(value)
  end

  def id
    @id.read
  end

  def type=(value)
    @type = atomise(value)
  end

  def type
    @type.read
  end

  def language=(value)
    @language = atomise(value)
  end

  def language
    @language.read
  end
end