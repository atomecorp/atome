def create(options = nil)

  if options.class== Atome
    self.insert(options)
    options.x=options.x[:content]+self.x[:content]
    options.y=options.y[:content]+self.y[:content]
  elsif options.class== Hash
    #here we can create properties for Atome on the fly unless it already exist
    #usefull to add some kind of personal properties or tag objects
    if  Atome.methods.include?(options[:property])
      alert "property #{options[:property]} already exist!!"
    else
        method_name=options[:property]
      create_property(method_name)
    end
  end
  options
end

def collector(options = nil)
  options ||= {content: Atome.presets[:batch][:content]}
  # refresh = if options[:render] == false || options[:render] == :false
  #             false
  #           else
  #             true
  #           end
  options&.instance_of?(Hash)
  options = {type: :collector, preset: :collector}.merge(options)
  # alert options
  Atome.new(options)
end

def box(options = nil)
  options ||= {content: Atome.presets[:box][:content]}
  refresh = if options[:render] == false || options[:render] == :false
              false
            else
    true
            end
  options&.instance_of?(Hash)
  options = {type: :shape, preset: :box}.merge(options)
  Atome.new(options, refresh)
end

def circle(options = nil)
  unless options
    options = {content: Atome.presets[:circle][:content]}
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
    options = {content: Atome.presets[:text][:content]}
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
    options = {content: Atome.presets[:image][:content]}
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
    options = {content: Atome.presets[:audio][:content]}
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
    options = {content: Atome.presets[:video][:content]}
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
    options = {content: Atome.presets[:web][:content]}
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
    options = {content: Atome.presets[:tool][:content]}
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
    options = {content: Atome.presets[:particle][:content]}
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
    options = {content: Atome.presets[:user][:content]}
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

def code(options = nil)
  unless options
    options = {content: Atome.presets[:code][:content]}
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
  options = {type: :code, preset: :code}.merge(options)
  Atome.new(options, refresh)
end

def effect(options = nil)
  unless options
    options = {content: Atome.presets[:text][:content]}
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
    options = {content: Atome.presets[:text][:content]}
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