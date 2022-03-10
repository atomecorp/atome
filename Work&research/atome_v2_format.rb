# frozen_string_literal: true
# module is used for data conversion
class Quark

  def q_read

  end

end

# module is used for data conversion
module Converter
  def to_rgb(value)
    case value
    when :red
      { red: 0.6, green: 0.33, blue: 0.66, alpha: 1 }
    when :yellow
      { red: 0.3, green: 0.1, blue: 0.9, alpha: 1 }
    else
      { red: 0.9, green: 1, blue: 0.3, alpha: 1 }
    end
  end
end

# module Universe contain basic elements
module Universe
  def self.identity
    username = Universe.username
    atomes = Universe.atomes
    "a_#{object_id}_#{username}_#{Time.now.strftime('%Y%m%d%H%M%S')}_#{atomes.length}"
  end

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

  # def self.molecules(new_molecule = nil)
  #   @molecules ||= []
  #   if new_molecule
  #     @molecules << new_molecule
  #     # cells(@molecules)
  #   else
  #     @molecules
  #   end
  # end
  #
  # def self.cells(new_cell = nil)
  #   @cells ||= []
  #   # if new_cell
  #   #   # puts identity
  #   #   puts ({ identity => new_cell })
  #   #   @cells << new_cell
  #   # else
  #   #   @cells
  #   # end
  # end
end

# handle all operations for complexes molecules (molecules)
module MoleculeHelper
  # handle all operations for complexes molecules (molecules)
  def molecules_list
    { color: { red: 0, green: 0, blue: 0, alpha: 1, left: 0, top: 0, bottom: nil, right: nil, radiation: :linear } }
  end

  def particle_sanitizer(properties, values)
    # puts 'I may create an uniq method to iterate on array before sanitizing'
    # puts 'by so it may also catch when an atome is passed'
    # puts "values: #{values} "
    if values.instance_of? Array
      values.each do |value|
        particle_sanitizer(properties, { add: value })
      end
    else
      values = to_rgb(values)
      values.each do |property, value|
        send(property, value)
      end
    end
  end
end

# this module contains all available molecules
module Molecule
  def color(value = nil)
    getter_setter(:type, value) do
      particle_sanitizer(:color, value)
    end
  end
end

# Keep all spatial methods
module Spatial
  # test methods below
  def left(value = nil, add = nil)
    getter_setter(:left, value) do
      atome_sanitizer(:left, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add(:top, add)
        atome_creation treated_val
        render_property(:left)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end

  def top(value = nil, add = nil)
    getter_setter(:top, value) do
      atome_sanitizer(:top, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add(:top, add)
        atome_creation treated_val
        render_property(:top)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end
end

# this module hold material
module Material
  def child(value = nil, add=nil)
    getter_setter(:child, value) do
      atome_sanitizer(:child, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add :child, add
        atome_creation treated_val
        render_property(:child)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end

  def type(value = nil)
    getter_setter(:type, value) do
      atome_sanitizer(:type, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add :type, treated_val[:type]
        atome_creation treated_val
        render_property(:type)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end

  def preset(value = nil)
    getter_setter(:preset, value) do
      atome_sanitizer(:preset, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add :preset, treated_val[:preset]
        atome_creation treated_val
        render_property(:preset)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end

  def parent(value = nil)
    getter_setter(:parent, value) do
      atome_sanitizer(:parent, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add :parent, treated_val[:parent]
        atome_creation treated_val
        render_property(:parent)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end

  def red(value = nil)
    getter_setter(:red, value) do
      atome_sanitizer(:red, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add :red, treated_val[:red]
        atome_creation treated_val
        render_property(:red)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end

  def green(value = nil)
    getter_setter(:green, value) do
      atome_sanitizer(:green, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add :green, treated_val[:green]
        atome_creation treated_val
        render_property(:green)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end

  def blue(value = nil)
    getter_setter(:blue, value) do
      atome_sanitizer(:blue, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add :blue, treated_val[:blue]
        atome_creation treated_val
        render_property(:blue)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end

  def alpha(value = nil)
    getter_setter(:alpha, value) do
      atome_sanitizer(:alpha, value) do |treated_val|
        treated_val = pre_processor treated_val
        check_add :alpha, treated_val[:alpha]
        atome_creation treated_val
        render_property(:alpha)
        post_processor treated_val
        return method_return treated_val
      end
    end
  end
end

# this module ....
module Electron
  def pre_processor(params)
    params
  end

  def post_processor(params)
    params
  end

  def method_return(params)
    params
  end
end

# Class  Atome
class Atome
  include Universe
  include Electron
  include Spatial
  include Material
  include MoleculeHelper
  include Molecule
  include Converter

  def initialize(params)
    @molecule = []
    # puts "***********"
    # puts @molecule
    # a_id = Universe.identity
    # Universe.molecules(a_id)
    default_values = { parent: :view }
    params = default_values.merge(params)
    params.each_pair do |property, value|
      send(property, value)
    end
  end

  def atome_creation(atome)
    a_id = Universe.identity
    # @molecule << { a_id: a_id }.merge(atome)
    @molecule << { a_id => atome }
    # Universe.atomes(a_id)
    # molecules << a_id
  end

  def check_hash_content(property, values_to_parse, &block)
    values_to_parse.delete(:a_id)
    if values_to_parse[:add].instance_of?(Array)
      # we must check the added content in case it comes from another atome (if it contains an array )
      values_to_parse[:add].each do |value|
        value.delete(:a_id)
        # we extract the value from the atome passed
        value = value.values[0]
        # we send the added value to the current atome
        # send(property, { add: value })
        add({ property => value })
      end
    else
      instance_exec(property => values_to_parse, &block)
    end
  end

  def atome_sanitizer(property, values, &block)
    if values.instance_of? Hash
      check_hash_content(property, values, &block)
    elsif values.instance_of? Array
      values.each do |value|
        add({ property => value })
      end
    else
      instance_exec(property => values, &block)
    end
  end

  def getter_setter(property, value)
    if value.nil?
      get_property_content property
    else
      yield value
    end
  end

  def check_add(property, add)
    delete_property(property) unless add
  end

  def find_property(property)
    @molecule.each do |atome_found|
      yield atome_found if atome_found.values[0][property]
    end
  end

  def get_property_content(property)
    value_found = []
    find_property(property) do |properties_found|
      value_found << properties_found.values[0][property]
    end
    value_found
  end

  def delete_property(property)
    @molecule.delete_if { |atome_found| atome_found[property] }
  end

  # send_to_render_engine atome_found
  def send_to_render_engine(atome_to_render)
    puts "send to render engine : #{atome_to_render}"
  end

  def render_property(property)
    a_id_found = []
    find_property(:a_id) do |a_id|
      a_id_found << a_id
    end
    find_property(property) do |properties_found|
      "rendering: (#{property}=#{properties_found}), parent: #{a_id_found[0]}"
    end
  end

  def add(atome)
    # send(atome, :add)
    send(atome.keys[0], atome.values[0], :add)
  end

  def inspect
    @molecule.to_s
  end
end

a = Atome.new({ type: :shape, preset: :box, child: %i[sphere circle], color: %i[red yellow], left: 30, top: 66 })
# a.color({ add: :green })
# a.color(:pink)
# a=Atome.new({})

# b = Atome.new({ type: :shape, preset: :circle, color: :black, left: 15, top: 99 })
# c = Atome.new({ type: :text,  color: { red: 0, green: 1, x: 33 }, left: 15, top: 99 })
# d = Atome.new({ type: :text,  color: [{ red: 0, green: 1, x: 33 }, :green], left: 15, top: 99 })

# puts a.inspect
# puts b.preset
# a.left([88, 44, 22, 11])
# a.left({ add: 120 })
# a.left(add: b.top)
# # a.left(55)
# a = Atome.new({})
# a.color(:red)
# a.top(3)
# a.top([9, 33])
# a.add({ top: 66 })
# a.add({ top: 69 })
# puts "a.top1 : #{a.top}"
# a.top(66)
# a.left(a.top)

# puts a.color

# puts "--- all items must be count atome/molecules/cells----"
# # puts "molecules list = #{Universe.molecules}\n #{Universe.molecules.length}"
# puts "atomes list = #{Universe.atomes}\n #{Universe.atomes.length}"
# puts a.inspect

# puts "a.top : #{a.top}"
# a.color(a.left)
# puts '--- results ---'
# puts a.red
# puts a.color
# puts a.inspect
# puts a.color
# puts a.left.to_s
# puts c.color
# puts d.color
# puts a.color
# puts '------ new value ------'
# a.left(55)
# a.left(77)
#
# # # puts '------ other  value ------'
# a.left([33, 99]) # should work
# # a.left({ add: 66 })
# # a.left({ add: 20 })
#
# puts '######### now I have to catch the case when an atome is send cf : color #########'
# # puts a.check.join("\n")
# # puts a.to_s
# # puts '------ left property ------'
# # # a.render
# puts a.left
# # puts
# puts a.check
# # b = Atome.new({ type: :shape, preset: :circle, color: :orange, left: 90, y: 9 })
# a = Atome.new({ type: :shape, preset: :box, color: %i[red yellow], left: 30, top: 66 })

puts "######"
# puts a.child
# puts a.preset
puts a.color
# puts a.inspect

# a_9879879 = { color: :a_87687687687 }

# devrait etre :

# a_9879879 = { molecule: [{  a_9878768768: { type: :color }  },
#                          {a_9878768768: { data: :red }},
#                          {:a_id=>"a_1820_jeezs_20220310163458_3", red: 1},
#                          {:a_id=>"a_1820_jeezs_20220310163458_4", :green=>1},
#                          {:a_id=>"a_1820_jeezs_20220310163458_5", :blue=>0.3}]

# @molecule=[{:a_id=>"a_1820_jeezs_20220310163458_0",
#             :parent=>:view},
#            {:a_id=>"a_1820_jeezs_20220310163458_1",
#                               :type=>:shape}, {:a_id=>"a_1820_jeezs_20220310163458_2", :preset=>:box}, {:a_id=>"a_1820_jeezs_20220310163458_3", :red=>0.9}, {:a_id=>"a_1820_jeezs_20220310163458_4", :green=>1}, {:a_id=>"a_1820_jeezs_20220310163458_5", :blue=>0.3}, {:a_id=>"a_1820_jeezs_20220310163458_6", :alpha=>1}, {:a_id=>"a_1820_jeezs_20220310163458_7", :red=>0.9}, {:a_id=>"a_1820_jeezs_20220310163458_8", :green=>1}, {:a_id=>"a_1820_jeezs_20220310163458_9", :blue=>0.3}, {:a_id=>"a_1820_jeezs_20220310163458_10", :alpha=>1}, {:a_id=>"a_1820_jeezs_20220310163458_11", :left=>30}, {:a_id=>"a_1820_jeezs_20220310163458_12", :top=>66}]
#

@molecule = { a_1820_jeezs_20220310163458_0: { type: :shape }, a_1820_jeezs_20220310163458_1: { type: :molecule } }

# comment savoir qu'on a faire a une molecule et connaître son type?

# # puts b.to_s
# # puts a.to_s
# module Encryption
#   private
#
#   def encrypt(string)
#     "hello : #{string}"
#   end
# end
# class Person
#   include Encryption
#   def initialize val
#     @val=val
#   end
# end
# person = Person.new("Ada")
# p person.encrypt("some other secret")