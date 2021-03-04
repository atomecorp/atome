# here stand some atome's function to allow atome's objects manipulation

def eden_search(query)
  case query[:type]
  when :image
    Universe.images[query[:name]]
  when :video
    Universe.videos[query[:name]]
  when :audio
    Universe.audios[query[:name]]
  else
    query
  end
end

def find(query)
  if query[:scope] == :eden
    eden_search(query)
  else
    "a look at eDen"
  end
end

def identity
  "a_" + object_id.to_s + "_" + Atome.atomes.length.to_s + "_" + Time.now.strftime("%Y%m%d%H%M%S")
end

def get(id)
  Atome.atomes.values.each do |atome|
    if atome.id == id
      return atome
    end
  end
  nil
end

def grab(atome_id)
  if Atome.atomes.key?(atome_id)
    return Atome.atomes[atome_id]
  end
  nil
end

def batch(objects)
  batched_atomes = []
  objects.each do |atome_id|
    batched_atomes << atome_id.atome_id
  end
  ATOME.atomise(:batch, batched_atomes)
end

def tactile
  # check if user's device is a tactile device
  false
end

def lorem
  <<~STRDELIM
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
  STRDELIM
end

def wait(seconds)
  wait_html(seconds) do
    yield
  end
end

def repeat(delay = 3, repeat = 5, &proc)
  repeat_html(delay, repeat, &proc)
end

def clear(value)
  case value.keys[0]
  when :wait
    clear_interval_html(value[:wait])
  when :repeat
    clear_repeat_html(value[:repeat])
  else
    value
  end
end

def compile(code)
  if JSUtils.opal_parser_ready
    Opal.eval(code)
  else
    ATOME.wait 0.01 do
      compile(code)
    end
  end
end

def read(filename, &proc) #  read local file
  JSUtils.reader(filename, &proc)
end

def version
  "v:0.015"
end

def notification(message, duration)
  notification = text({content: message, color: :orange, x: 69, y: 69})
  ATOME.wait duration do
    notification.delete
  end
end