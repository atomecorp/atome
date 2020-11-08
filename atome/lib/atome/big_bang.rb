# frozen_string_literal: true

# here stand  atome's methods to initiate the creation of atome environment
# add easier apis to create basic atome object

# the class below init the Atome class
#class Atome < Nucleon::Core::Nucleon
#  # S.A.G.E.D methods
#  #def set params = nil, refresh = true, &proc
#  #  if params.class == Hash
#  #    if params[:type] && params[:type] == :text
#  #      params = reorder_properties(params)
#  #      #we invert hash order but why?
#  #      params = params.to_a.reverse.to_h
#  #    end
#  #
#  #    params.each do |property, value|
#  #      send(property, value, refresh, false, &proc)
#  #    end
#  #  elsif params.class == Array
#  #    params.each do |param|
#  #      if param.class == Hash
#  #        param.keys.each do |key|
#  #          send(key, param[key], refresh, false, &proc)
#  #        end
#  #      elsif param.class == Array
#  #        puts "todo : create recursive treatment of prop's array"
#  #      end
#  #    end
#  #  else
#  #    property = params
#  #    send(property, nil, refresh, false, &proc)
#  #  end
#  #end
#  #
#  #def add params, refresh = true, &proc
#  #  if params.class == Hash
#  #    params.each do |property, value|
#  #      # send :  first is the function call, second is the value, third is to refresh the view fourth to add/stack the prop or replace, and last is the proc if present
#  #      send(property, value, refresh, true, &proc)
#  #    end
#  #  elsif params.class == String || Symbol
#  #    property = params
#  #    send(property, nil, refresh, true, &proc)
#  #  end
#  #end
#  #
#  #def get params = nil
#  #  if params
#  #    if params.class == String || params.class == Symbol
#  #      Object.get(params)
#  #    end # we check if user try to get the object by id
#  #  else
#  #    self
#  #  end
#  #end
#  #
#  #def enliven(params = nil, refresh = true)
#  #  @@black_hole.each do |atome_deleted|
#  #    if atome_deleted && (atome_deleted.atome_id.to_sym == atome_id.to_sym)
#  #      @@black_hole.delete(self)
#  #      if refresh
#  #        properties.each do |property|
#  #          property.each do |key, value|
#  #            key = key.to_sym
#  #            if key == :group
#  #              @group = value
#  #            elsif key == :parent
#  #              @parent = value
#  #            elsif key == :child
#  #              @child = value
#  #            elsif key == :atome_id
#  #            elsif key == :render
#  #              @render = value
#  #            else
#  #              if value.class == Array
#  #                value.each do |val|
#  #                  send(key, val)
#  #                end
#  #              else
#  #                send(key, value)
#  #              end
#  #            end
#  #          end
#  #        end
#  #      end
#  #      if @parent != nil &&  @parent != []
#  #        @parent.each do |parent_found|
#  #          if parent_found != nil
#  #            @@atomes << self
#  #            find({value: parent_found, property: :atome_id, scope: :view}).insert(self)
#  #          end
#  #        end
#  #      end
#  #
#  #      if @child && @child.length > 0
#  #        @child.each do |child_found|
#  #          alert "message :\n#{dig(child_found)}\n from : atome.rb : 173"
#  #          #find({value: child_found, property: :atome_id, scope: :all}).enliven(true)
#  #          dig(child_found).enliven(true)
#  #        end
#  #      end
#  #    end
#  #  end
#  #  #we re attach to parent #fixme the preset already attach to view so we can optimise to immediatly attach to parent instead
#  #end
#  #
#  #def delete params = nil, refresh = true
#  #  if id==:view
#  #    #alert "message :\n#{':couille dans le potage !!!'}\n from : atome.rb : 185"
#  #  else
#  #    #alert "message :\nparams:#{params},\n#{atome_id} : #{id}\nfrom : atome.rb : 187"
#  #    if params || params == false
#  #      if params.class == Atome # here we delete the whole atome
#  #        # the strategy is to delete all atomes then add them to the @atomes array except the deleted one
#  #        atomes = []
#  #        @@atomes.each do |atome_found|
#  #          if atome_found.id.to_sym == params.id.to_sym
#  #            # the line below insert into array or update/replace if already exit in array
#  #            @@black_hole |= [atome_found]
#  #            #@@atomes.delete(atome)
#  #            # now we delete all child
#  #            atome_found.child.each do |child_found|
#  #              child_found&.delete(true)
#  #            end
#  #          else
#  #            atomes << atome
#  #          end
#  #        end
#  #        alert "message :\n#{@@atomes}\n from : atome.rb : 205"
#  #        @@atomes = atomes
#  #      elsif params.class == Hash
#  #        property = params.keys[0]
#  #        new_prop_array = []
#  #        case property
#  #        when :selector
#  #          selector.each do |value|
#  #            new_prop_array << value if value != value_to_remove
#  #          end
#  #          @selector = new_prop_array
#  #        end
#  #      elsif params == false
#  #        alert "message is \n\n#{"sure?"} \n\nLocation: atome.rb, line 220"
#  #        get(:view).enliven(atome_id)
#  #      elsif params.class == Boolean || params.to_sym == :true
#  #        # now we delete all child
#  #        self.child&.each do |child_found|
#  #          child_found&.delete(true)
#  #        end
#  #
#  #        ## #we remove object from view(:child)
#  #        #grab(:view).child().each do |child_found|
#  #        #  if child_found
#  #        #    grab(:view).ungroup(child_found) if child_found.atome_id == self.atome_id
#  #        #  end
#  #        #end
#  #        # we delete all the dynamic actions :
#  #        # - first the dynamic actions centering object
#  #        grab(:actions).resize_actions[:center].delete(self)
#  #        # the line below insert into array or update/replace if already exit in array
#  #        # we add the deleted object to the blackhole
#  #        @@black_hole |= [self]
#  #        # we remove objet from the atomes list
#  #        @@atomes.delete(self)
#  #      end
#  #      Render.render_delete(self, params) if refresh
#  #    else
#  #      @@black_hole
#  #    end
#  #  end
#  #
#  #end
#
#end

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

def code(options = nil)
  unless options
    options={content: Atome.presets[:code][:content]}
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
