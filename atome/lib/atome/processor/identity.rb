module IdentitiesProcessors
  def atome_id_processor(value)
    # just to ensure atome_id has not be set before, if yes it won't be changed
    unless @atome_id == ""
      @atome_id = atomise(value)
    end
  end
end