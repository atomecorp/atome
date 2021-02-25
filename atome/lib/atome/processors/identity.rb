module IdentitiesProcessors
  def atome_id_processor(value)
    # just to ensure atome_id uniqueness and prevent any identity change id set before
    uniqueness = true
    atome_id_found = false
    if @atome_id
      atome_id_found = true
    end
    # we look into atomes array to find if an atome already have this atome_id
    Atome.atomes.each do |atome|
      if atome.atome_id == value
        uniqueness = false
      end
    end
    # if an atome already have this atome_id we wont set it with the current value but use a automatic identity
    @atome_id = if uniqueness
      atomise(value)
    else
      # an atome already have this atome_id, the new atome will be renamed
      atomise(identity)
    end
    # atome_id can't be changed we only set the atome_id if it hasn't been set before
    unless atome_id_found
      atome_id_html(@atome_id)
    end
  end
end