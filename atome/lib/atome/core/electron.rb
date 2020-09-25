# here stand some atome's function to allow atome's objects manipulation
#

def select selector
  grab(:view).child.each do |atome|
    collected_atomes = []
    if atome.selector && atome.selector.include?(:validated)
      collected_atomes << atome
    end
  end

end

def get_proc_content(proc)
  #proc_parser allow to parse a proc
  lines = `String(#{proc})`
  value_found = ""
  proc_content = []
  lines = lines.split("\n")
  lines.shift
  lines.each_with_index do |line|
    line = line.gsub(".$", ".").gsub(";", "")
    unless line.include?('$writer[$rb_minus($writer["length"], 1)]')
      if line.include?("$writer = [")
        value_found = line.sub('$writer = [', "").sub(/]/i, '')
      elsif line.include?("$send(")
        content = line.sub("$send(", "").sub("Opal.to_a($writer))", "")
        content = content.split(",")
        variable = content[0].gsub(" ", "")
        property = content[1].gsub("'", "").gsub(" ", "")
        line = variable + "." + property + value_found
        proc_content << line
      else
        proc_content << line
      end
    end
  end
  return proc_content.join("\n")
end


def to_px(obj = nil, property = :top)
  if obj.class != Atome
    obj = get(obj)
  end
  Render.render_to_px(obj, property)
end

def grab(atome_id)
  atomes = Atome.atomes
  atomes.each do |atome|
    if atome.atome_id == atome_id
      return atome
    end
  end
  return nil
end

def delete params, refresh = true
  alert "message is \n\n#{params} \n\nLocation: electron.rb, line 60"
end


def get(params)
  #todo get should allow to get object by its property/value (ex : get(color: :red) => return all atome with the property color set to red)
  atomes = Atome.atomes
  if params.class == Hash
    collected_atomes = []
    params.keys.each do |property|
      case property
      when :selector
        value = params[:selector]
        atomes.each do |atome|
          if atome.selector.class == Array && atome.selector.include?(value.to_s)
            collected_atomes << atome
          end
        end
      else
        collected_atomes = []
        get(:view).child.each do |atome|
          if atome.send(params.keys[0].to_sym) && (atome.send(params.keys[0].to_sym).to_sym == params.values[0].to_sym)
            collected_atomes << atome
          end
        end
        return collected_atomes
      end
    end
    return collected_atomes
  else
    atomes.each do |atome|
      if atome.id.to_s == params.to_s
        return atome
      end
    end
    return false
  end
end

def clear params = :console
  atome = grab(:view)
  # now we call the clear methods in neutron
  atome.clear(params)
end

def http url
  Render.render_http(url)
end

def read filename, action = :run, code = :ruby #  read local file
  Render.render_reader filename, action, code
end

def lorem
  lorem = <<Strdelilm
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
Strdelilm
end

################## utilities  ##############
def batch atomes, properties
  atomes.each do |atome|
    properties.each do |property, value|
      atome.send(property, value)
    end
  end
end

def find_atome_from_params params
  if params.class == Atome
    supposed_atome = params
  else
    supposed_atome = grab(params) if params.class == String || params.class == Symbol
    #if the first condition return nil now we check if an id exist
    supposed_atome = get(params) unless supposed_atome
  end

  return supposed_atome
end

################## time operation  ##############

def wait(seconds, &proc)
  Render.render_wait(seconds) do
    yield
  end
end

def every(delay = 3, times = 5, &proc)
  Render.render_every(delay, times, &proc)
end


def stop params
  Render.render_stop(params)
end

