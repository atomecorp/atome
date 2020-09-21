# here stand  atome's methods to initiate the creation of atome environment and also add asier apis to create basic atome object

def version
  return "v:0.007ba"
end

# the class below init the Atome class
class Atome < Nucleon::Core::Nucleon

end

def box(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:box, refresh)
  #we attach the new object to the view to make it visible
  #grab(:view).insert(atome)
  options&.each_key do |param|
    value = options[param]
    atome.send(param, value)
  end
  return atome
end

def circle(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:circle, refresh)
  #we attach the new object to the view to make it visible
  #grab(:view).insert(atome)
  options&.each_key do |param|
    value = options[param]
    atome.send(param, value)
  end
  return atome
end

def text(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:text, refresh)
  #we attach the new object to the view to make it visible
  #grab(:view).insert(atome)
  if options
    if options.class == Hash
      options.each_key do |param|
        value = options[param]
        atome.send(param, value)
      end
    elsif options.class == String || options.class == Symbol
      atome.send(:content, options)
    else
      atome.send(:content, options.to_s)
    end
  end
  return atome
end

def image(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:image, refresh)
  #we attach the new object to the view to make it visible
  #grab(:view).insert(atome)
  if options && (options.class == Symbol || options.class == String)
    atome.send(:content, options)
  elsif options && options.class == Hash
    options.each_key do |param|
      value = options[param]
      atome.send(param, value)
    end
  end
  return atome
end

def audio(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:audio, refresh)
  #we attach the new object to the view to make it visible
  #grab(:view).insert(atome)
  if options && (options.class == Symbol || options.class == String)
    atome.send(:content, options)
  elsif options && options.class == Hash
    options.each_key do |param|
      value = options[param]
      atome.send(param, value)
    end
  end
  return atome
end

def video(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:video, refresh)
  #we attach the new object to the view to make it visible
  #grab(:view).insert(atome)
  atome_a = Atome.new(:audio, refresh)
  #we attach the new object to the view to make it visible
  #grab(:view).insert(atome_a)
  if options && (options.class == Symbol || options.class == String)
    atome.send(:content, options)
    atome_a.send(:content, options)
  elsif options && options.class == Hash
    options.each_key do |param|
      value = options[param]
      atome.send(param, value)
      atome_a.send(param, value)
    end
  end
  atome.insert(atome_a)
  return atome
end

def web(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:web, refresh)
  #grab(:view).insert(atome)
  if options && (options.class == Symbol || options.class == String)
    atome.send(:content, options)
  elsif options && options.class == Hash
    options.each_key do |param|
      value = options[param]
      atome.send(param, value)
    end
  end
  return atome
end

def tool(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:tool, refresh)
  grab(:intuition).insert(atome)


  if options && (options.class == Symbol || options.class == String)
    atome.send(:content, options)
  elsif options && options.class == Hash
    options.each_key do |param|
      value = options[param]
      atome.send(param, value)
    end
  end
  return atome
end

def particle(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:particle)
  options&.each_key do |param|
    value = options[param]
    atome.send(param, value)
  end
  return atome
end

def user(options = nil)
  refresh = if options && (options[:render] == false || options[:render] == :false)
              false
            else
              true
            end
  atome = Atome.new(:user)
  if options && (options.class == Symbol || options.class == String)
    atome.send(:content, options)
  elsif options && options.class == Hash
    options.each_key do |param|
      value = options[param]
      atome.send(param, value)
    end
  end
  return atome
end


class Device
  def initialize
    # do not change the order of object creation below as the atome_id of those system object is based on their respective order
    # todo : allow the system to assign atome_id using internal password system
    blackhole = Atome.new({type: :shape, id: :blackhole, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden})
    dark_matter = Atome.new({type: :shape, id: :dark_matter, width: 0, height: 0, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden})
    device = Atome.new({type: :shape, id: :device, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 1, overflow: :hidden})
    intuition = Atome.new({type: :shape,  id: :intuition, x: 0, xx: 0, y: 0, yy: 0, z: 3, overflow: :hidden})
    view = Atome.new({type: :shape, id: :view, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :auto, parent: :intuition})
# The lines below creat a special atome that holds all resize_actions stored in the @@resize_actionsvariable
    actions=Atome.new
    actions.viewer_actions
    device.language(:english)
    Render.initialize

  end


end

# class Help
#   def self.color
#     ["a=box()\na.color(:red)"]
#   end
#   @example={}
#   @help={}
#   @usage={}
# end
# alert Help.color
 Device.new


