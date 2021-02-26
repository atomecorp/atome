# here stand some atome's function to allow atome's objects manipulation

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

def every(delay = 3, repeat = 5, &proc)
  every_html(delay, repeat, &proc)
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

def version
  "v:0.015"
end

def notification(message, duration)
  notification = text({content: message, color: :orange, x: 69, y: 69})
  ATOME.wait duration do
    notification.delete
  end
end