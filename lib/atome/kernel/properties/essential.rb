class Atome
  def new(params)
    puts "add/new : #{params}"
  end

  def set(params)
    puts "set : #{params}"
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

  def delete(params)
    puts "replace : #{params}"
  end

  def render(property, value)
    puts "render : #{property}, #{value}"
  end

  def broadcaster(property, value)
    puts "broadcast : #{property}, #{value}"
  end
  def historize(property, value)
    puts "historize : #{property}, #{value}"
  end
end

