module Processors
  def atome_id_pre_processor(value)
    # just to ensure atome_id uniqueness and prevent any identity change id set before
    uniqueness = true
    atome_id_found = false
    if @atome_id
      atome_id_found = true
    end
    # we look into atomes array to find if an atome already have this atome_id
    if Atome.atomes.key?(value)
      uniqueness = false
    end
    # if an atome already have this atome_id we wont set it with the current value but use a automatic identity
    @atome_id = if uniqueness
      atomise(:atome_id, value)
    else
      # an atome already have this atome_id, the new atome will be renamed
      atomise(:atome, identity)
    end
    # atome_id can't be changed we only set the atome_id if it hasn't been set before
    unless atome_id_found
      atome_id_html(@atome_id)
    end
  end

  def private_processor(value)
    puts "set #{value}"
  end

  def can_processor(value)
    puts "set #{value}"
  end

  def private_getter_processor(value)
    puts "get #{value}"
  end

  def can_getter_processor(value)
    puts "get #{value}"
  end
end