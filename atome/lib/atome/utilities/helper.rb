# here stand some atome's function to allow atome's objects manipulation

def batch(*params)
  buffer = []
  params.each do |atome|
    buffer << atome
  end
  drag(:buffer).content(buffer)
end

def get(id)
  Atome.atomes.each do |atome|
    if atome.id[:value] == id
      return atome
    end
  end
  nil
end

def grab(atome_id)
  Atome.atomes.each do |atome|
    if atome.atome_id[:value] == atome_id
      return atome
    end
  end
  nil
end

def filter_system_object
  atomes = Atome.atomes
  filtered_atomes = []
  atomes.each do |atome|
    if atome.id != :dark_matter && atome.id != :device && atome.id != :intuition && atome.id != :view && atome.id != :actions
      filtered_atomes << atome
    end
  end
  filtered_atomes
end

def found_child_recursively(params)
  params.each do |child_found|
    if child_found.instance_of?(Atome)
      @children_found << child_found
      if child_found.child && child_found.child.length > 0
        found_child_recursively child_found.child
      end
    end
  end
end

def filter_atome
  @children_found = []
  found_child_recursively(child)
  @children_found
end

def find_atome_from_params(params)
  supposed_atome = ""
  # this function all to return the atome either send and is an atome_id or the atome itself
  if params.instance_of?(Atome)
    supposed_atome = params
  else
    if params.instance_of?(Hash)
      params = params[:content]
    end
    supposed_atome = grab(params) if params.instance_of?(String) || params.instance_of?(Symbol)
    # if the first condition return nil now we check if an id exist
    supposed_atome ||= get(params)
  end
  # we return the atome itself
  supposed_atome
end

def find(params)
  if params == :all
    formated_params = {}
    formated_params[:scope] = :all
    params = formated_params
  end
  unless params[:property]
    params[:property] = :all
  end
  if params[:scope] == :all
    filtered_atomes = filter_system_object
  elsif params[:recursive]
    filtered_atomes = filter_atome
  else
    filtered_atomes = []
    child.each do |atome|
      if atome.instance_of?(Atome)
        filtered_atomes << atome
      end
    end
  end
  if params[:itself]
    filtered_atomes << self
  end
  atomes_found = []
  if params[:property] == :all
    atomes_found = filtered_atomes
  else
    filtered_atomes.each do |atome|
      if params[:value]
        if atome && atome.send(params[:property])[:content] == params[:value]
          atomes_found << atome
        end
      elsif atome&.send(params[:property])
        atomes_found << atome
      end
    end
  end
  atomes_found
end

def clear(params = :console)
  atome = grab(:device)
  # now we call the clear methods in neutron
  atome.clear(params)
end

def http(url)
  Render.render_http(url)
end

def read(filename, action = :run, code = :ruby)
  # read local file
  Render.render_reader filename, action, code
end

def lorem
  <<~STRDELIM
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
  STRDELIM
end

# fixme : put whole code in Atome context to be able to remove the method below
def to_px(obj = nil, property = :top)
  Atome.to_px(obj, property)
end

# time operation

def wait(seconds)
  Render.render_wait(seconds) do
    yield
  end
end

def every(delay = 3, times = 5, &proc)
  Render.render_every(delay, times, &proc)
end

def stop(params)
  Render.render_stop(params)
end