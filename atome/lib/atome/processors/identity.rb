module Processors
  def atome_id_pre_processor(value)
    # just to ensure atome_id uniqueness and prevent any identity change id set before
    uniqueness = true
    if @atome_id
      # if the object already have an idea it keeps it
      value = @atome_id
    end
    # we look into atomes array to find if an atome already have this atome_id
    if Atome.atomes.key?(value)
      uniqueness = false
    end
    # if an atome already have this atome_id we wont set it with the current value but use a automatic identity
    unless uniqueness
      # an atome already have this atome_id, the new atome will be renamed
      value = identity
    end
    # atome_id can't be changed we only set the atome_id if it hasn't been set before
    @atome_id = atomise(:atome_id, value)
  end

  def private_processor(value)
    "set #{value}"
  end

  def can_processor(value)
    "set #{value}"
  end

  def private_getter_processor(value)
    "get #{value}"
  end

  def can_getter_processor(value)
    "get #{value}"
  end
end