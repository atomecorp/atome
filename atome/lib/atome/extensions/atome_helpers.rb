# here stand some atome's function to allow atome's objects manipulation

def identity
  "a_" + object_id.to_s + "_" + Atome.atomes.length.to_s + "_" + Time.now.strftime("%Y%m%d%H%M%S")
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

def tactile
  false
end

def lorem
  <<~STRDELIM
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
  STRDELIM
end

def version
  "v:0.010"
end