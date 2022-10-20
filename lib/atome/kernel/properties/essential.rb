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
    puts "replace : #{params}"
  end

  def [](params)
    instance_variable_get(instance_variables[params])
  end

  def to_s
    inspect.to_s
  end

end

