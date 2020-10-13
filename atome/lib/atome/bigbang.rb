# here stand  atome's methods to initiate the creation of atome environment and also add asier apis to create basic atome object

# the class below init the Atome class
class Atome < Nucleon::Core::Nucleon

end

def box(options = nil)
  unless options
    options={content: Atome.presets[:box][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  options && options.class == Hash
  options = {type: :shape, preset: :box}.merge(options)
  Atome.new(options, refresh)
end

def circle(options = nil)
  unless options
    options={content: Atome.presets[:circle][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  options && options.class == Hash
  options = {type: :shape, preset: :circle}.merge(options)
  Atome.new(options, refresh)
end

def text(options = nil)
  unless options
    options={content: Atome.presets[:text][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :text, preset: :text}.merge(options)
  Atome.new(options, refresh)
end

def image(options = nil)
  unless options
    options={content: Atome.presets[:image][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :image, preset: :image}.merge(options)
  Atome.new(options, refresh)
end

def audio(options = nil)
  unless options
    options={content: Atome.presets[:audio][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :audio, preset: :audio}.merge(options)
  Atome.new(options, refresh)
end

def video(options = nil)
  unless options
    options={content: Atome.presets[:video][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :video, preset: :video}.merge(options)
  atome = Atome.new(options, refresh)
  options = options.merge({type: :audio, preset: :audio})
  atome_a = Atome.new(options, refresh)
  atome.insert(atome_a)
  atome
end

def web(options = nil)
  unless options
    options={content: Atome.presets[:web][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :web, preset: :web}.merge(options)
  Atome.new(options, refresh)
end

def tool(options = nil)

  unless options
    options={content: Atome.presets[:tool][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :tool, preset: :tool}.merge(options)
  Atome.new(options, refresh)
end

def particle(options = nil)
  unless options
    options={content: Atome.presets[:particle][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :particle, preset: :particle}.merge(options)
    # todo : set parent :  view from preset instead of below
  Atome.new(options.merge({parent: :view}), refresh)
end

def user(options = nil)
  unless options
    options={content: Atome.presets[:user][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :user, preset: :user}.merge(options)
  Atome.new(options, refresh)
end

def effect(options = nil)
  unless options
    options={content: Atome.presets[:text][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :effect, preset: :effect}.merge(options)
  Atome.new(options, refresh)
end

def constraint(options = nil)
  unless options
    options={content: Atome.presets[:text][:content]}
  end
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
              true
            end
  if options.class == Symbol || options.class == String
    content = {content: options}
    options = content
  end
  options && options.class == Hash
  options = {type: :constraint, preset: :constraint}.merge(options)
  Atome.new(options, refresh)
end
class Device
  def initialize
    # do not change the order of object creation below as the atome_id of those system object is based on their respective order
    # todo : allow the system to assign atome_id using internal password system
    blackhole = Atome.new({type: :particle, id: :blackhole, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden, color: :transparent})
    dark_matter = Atome.new({type: :particle, id: :dark_matter, width: 0, height: 0, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :hidden, color: :transparent})
    device = Atome.new({type: :particle, id: :device, width: "100%", height: "100%", x: 0, xx: 0, y: 0, yy: 0, z: 1, overflow: :hidden, color: :transparent})
    intuition = Atome.new({type: :particle,  id: :intuition, x: 0, xx: 0, y: 0, yy: 0, z: 3, overflow: :hidden, color: :transparent})
    view = Atome.new({type: :particle, id: :view, x: 0, xx: 0, y: 0, yy: 0, z: 0, overflow: :auto, parent: :intuition, color: :transparent})
# The lines below creat a special atome that holds all resize_actions stored in the @@resize_actionsvariable
    actions = Atome.new
    actions.id(:actions)
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


