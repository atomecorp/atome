class Atome

  def identity (params)
    @identity=params
  end
  def new(params)
    puts "add/new : #{params}"
  end

  def set(params)
    puts "set : #{params}"
  end

  def self.grab(val)
    Utilities.grab(val)
  end

  def add(params)
    puts "add : #{params}"
  end

  def update(params)
    puts "update : #{params}"
  end

  def refresh
    # delete the object in the view
    self.html_object&.remove
    particles_found = particles
    particles_found.delete(:html_type)
    particles_found.delete(:html_object)
    particles_found.delete(:id)
    particles_found.delete(:dna)
    atomes_to_re_attach = {}
    Utilities.atome_list.each do |atome_to_refresh|
      atome_found = particles_found.delete(atome_to_refresh)
      if atome_found
        particles_found.delete(atome_to_refresh)
        atomes_to_re_attach[atome_found.type] = atome_found
      end
    end
    particles_found.each do |particle_to_refresh, value|
      send(particle_to_refresh, value)
    end
    atomes_to_re_attach.each do |atome_to_attatch, content|
      instance_variable_set("@#{atome_to_attatch}", content)
      html_decision(content.html_type, id, content.id)
    end
  end


  def replace(params)
    puts "replace : #{params}"
  end

  def clear
    child.each do |child_found|
      grab(child_found).html_object&.remove
    end
    child([])
  end

  def delete(params)
    self.html_object&.remove
    Universe.delete(id)
  end

  def [](params)
    instance_variable_get(instance_variables[params])
  end

  def to_s
    inspect.to_s
  end

end

