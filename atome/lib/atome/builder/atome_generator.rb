# this class is used to define newly created atomes
class Atome
  include DefaultValues
  include Properties
  include Processors
  include RenderHtml
  include RenderFabric
  include RenderHeadless
  include RenderSpeech
  include RenderThree
  include RenderZim
  include InternalHelpers
  include AtomeHelpers

  # the method below initialize the creation of atome properties
  def self.sparkle
    # the line create a space to hold new created atomes
    Quark.space
  end

  # atome creation
  def initialize(properties = {})
    unless properties == {}
      # the hash below add the missing properties without creating a condition
      sanitizer = { atome_id: identity, render: true, type: :particle, content: {}, selector: {}, id: "a_#{object_id}" }.merge(properties)
      # below we reorder the atome properties before treatment
      sanitized_atome_id = { atome_id: sanitizer.delete(:atome_id) }
      sanitized_type = { type: sanitizer.delete(:type) }
      sanitized_language = if sanitizer[:language]
                             { language: sanitizer.delete(:language) }
                           else
                             {}
                           end
      sanitized_engine = if sanitizer[:engine]
                           { engine: sanitizer.delete(:engine) }
                         else
                           {}
                         end
      sanitized_color = if sanitizer[:color]
                          { color: sanitizer.delete(:color) }
                        else
                          {}
                        end
      sanitized_preset = if sanitizer[:preset]
                           { preset: sanitizer.delete(:preset) }
                         else
                           {}
                         end
      sanitized_render = if sanitizer[:render]
                           { render: sanitizer.delete(:render) }
                         else
                           {}
                         end
      sanitized_content = if sanitizer[:content]
                            { content: sanitizer.delete(:content) }
                          else
                            {}
                          end
      sanitized_center = if sanitizer[:center]
                           { center: sanitizer.delete(:center) }
                         else
                           {}
                         end
      sanitized_exec = if sanitizer[:exec]
                         { exec: sanitizer.delete(:exec) }
                       else
                         {}
                       end
      essential = sanitized_atome_id.merge(sanitized_type).merge(sanitized_language).merge(sanitized_engine).merge(sanitized_preset).merge(sanitized_render)
      #  we create the essential properties of the atome
      create(essential)
      # now the basic atome is created we can set all others properties
      # id theres an id we put it at the start of the hash
      # we change sanitizer hash order so the content property that trigger the rendering is placed at the end
      # and finally the center that must know the  content to be able to the center the object
      sanitizer = sanitizer.merge(sanitized_content).merge(sanitized_exec).merge(sanitized_center).merge(sanitized_color)
      set sanitizer
    end

  end

  def create(properties)
    atome_id = properties.delete(:atome_id)
    self.atome_id(atome_id)
    register_atome
    set properties
  end

  def add(value)
    prev_value = self.send(value.keys[0])
    # alert prev_value
    # alert value.keys[0]
    # alert value[value.keys[0]]
    self.send(value.keys[0], [prev_value, value[value.keys[0]]])
    # alert :kool
  end

  def get(property)
    send(property)
  end

  def set(properties)
    properties.each do |property, value|
      send(property.to_s, value)
    end

  end

  def register_atome
    # now we add the new atome to the atomes's list
    Atome.class_variable_get("@@atomes")[atome_id] = self
  end

  def self.atomes
    # this method return all created atomes
    Atome.class_variable_get("@@atomes") # allow access without offense
  end

  def self.atomes=(atome_list)
    # refresh atome list
    Atome.class_variable_set("@@atomes", atome_list)
  end

  def [](query = nil)
    if query
      self.properties[query]
    else
      self.properties
    end
  end
end