# frozen_string_literal: true

# module Universe is user to test
module Universe
  def self.username
    :jeezs
  end

  def self.atomes(new_atome = nil)
    @atomes ||= []
    if new_atome
      @atomes << new_atome
    else
      @atomes
    end
  end

  def molecules
    [:color]
  end
end

# Keep all properties methods
module Electron
  # test methods below
  # def left(value = nil)
  #   if value.nil?
  #     get_property_content :left
  #   elsif value.instance_of? Hash
  #     value = value[:add]
  #     sanitizer(:left, value)
  #     render_property(:left)
  #   else
  #     delete_property(:left)
  #     sanitizer(:left, value)
  #     render_property(:left)
  #   end
  # end

  def left(value = nil)
    if value.nil?
      get_property_content :left
    # elsif value.instance_of? Hash
    #   value = value[:add]
    #   sanitizer(:left, value)
    #   render_property(:left)
    else
      delete_property(:left)
      sanitizer(:left, value)
      render_property(:left)
    end
  end

  def top(value = nil)
    if value.instance_of? Hash
      value = value[:add]
    elsif !value.nil?
      delete_property(:top)
    end
    sanitizer(:top, value)
    # if no value found is a getter
    get_property_content :top unless value
  end

  def type(value = nil)
    if value.instance_of? Hash
      value = value[:add]
    elsif !value.nil?
      delete_property(:type)
    end
    sanitizer(:type, value)
    # if no value found is a getter
    get_property_content :type unless value
  end

  def preset(value = nil)
    if value.instance_of? Hash
      value = value[:add]
    elsif !value.nil?
      delete_property(:preset)
    end
    sanitizer(:preset, value)
    # if no value found is a getter
    get_property_content :preset unless value
  end

  def parent(value = nil)
    if value.instance_of? Hash
      value = value[:add]
    elsif !value.nil?
      delete_property(:parent)
    end
    sanitizer(:parent, value)
    # if no value found is a getter
    get_property_content :parent unless value
  end

  def color(value = nil)
    if value.instance_of? Hash
      value = value[:add]
    elsif !value.nil?
      delete_property(:color)
    end
    sanitizer(:color, value)
    # if no value found is a getter
    get_property_content :color unless value
  end
end

# Class  Atome is user to test
class Atome
  include Universe
  include Electron

  def initialize(params)
    @atome = []
    default_values = { parent: :view }
    params = default_values.merge(params)
    params.each_pair do |property, value|
      send(property, value)
    end
  end

  def identity
    username = Universe.username
    atomes = Universe.atomes
    "a_#{object_id}_#{username}_#{Time.now.strftime('%Y%m%d%H%M%S')}_#{atomes.length}"
  end

  def atome_genesis(property, value)
    a_id = identity
    @atome << { a_id: a_id, property => value }
    atomes = Universe.atomes
    atomes << a_id
  end

  def sanitizer(property, value)
    if value.instance_of? Array
      value.each do |val|
        sanitizer property, val
      end
    elsif value.instance_of? Hash
      atome_genesis property, value
    else
      atome_genesis property, value
    end
  end

  def to_s
    @atome.to_s
  end

  def find_property(property)
    @atome.each do |atome_found|
      yield atome_found[property] unless atome_found[property].nil?
    end
  end

  def get_property_content(property)
    value_found = []
    find_property(property) do |properties_found|
      value_found << properties_found
    end
    value_found
  end

  def delete_property(property)
    find_property(property) do |properties_found|
      @atome.delete(properties_found)
    end
  end

  def send_to_render_engine(atome_to_render)
    puts "send to render engine : #{atome_to_render}"
  end

  def render_property(property)
    a_id_found = []
    find_property(:a_id) do |a_id|
      a_id_found << a_id
    end
    find_property(property) do |properties_found|
      puts " rendering: (#{property}=#{properties_found}), parent: #{a_id_found[0]}"
    end
  end

  # send_to_render_engine atome_found
  def render; end
end

# Atome.class_variable_set('@@atomes', [])
# Atome.class_variable_set('@@username', :jeezs)

a = Atome.new({ type: :shape, preset: :box, color: %i[red yellow], left: 30, top: 66 })
# puts a.to_s
# a.color({ data: :pink, add: true, left: 33, y: 22 })
# puts a.color
puts '------ new value ------'
a.left(55)
puts '------ other  value ------'

a.left({ add: 20 })

# puts a.to_s
puts '------ left property ------'
# a.render
puts a.left.to_s
# puts
# puts a.to_s
# b = Atome.new({ type: :shape, preset: :circle, color: :orange, left: 90, y: 9 })
#
# puts "######"
# puts b.to_s
# puts a.to_s
