# frozen_string_literal: true

# this class is to allow property treatment
class Atome
  def initialize(value)
    @value = value
  end

  def self.atomise(property, value)
    # this method create a quark object from atome properties for further processing
    # typically this method is used to change an object without displaying the changes
    unless @monitor.nil? || @monitor == false
      # if the atome is monitored it broadcast the changes
      broadcast(property, value)
    end
    Atome.new(value)
  end

  def q_read
    @value
  end

  def to_s
    @value.values[0].to_s
  end

  def each(&proc)
    @value.each do |property, value|
      proc.call(Atome.new({ property => value })) if proc.is_a?(Proc)
    end
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
    :"a_#{object_id}_#{username}_#{Time.now.strftime('%Y%m%d%H%M%S')}_#{atomes.length}"
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
end

# handle all operations for complexes molecules (molecules)
module MoleculeHelper
  # handle all operations for complexes molecules (molecules)
  def molecules_types_atomes
    { color: { red: 0, green: 0, blue: 0, alpha: 1, left: 0, top: 0, bottom: nil, right: nil, radiation: :linear },
      position: { left: 0, top: 0, right: 0, bottom: 0, back: 0, front: 0 },
      dimension: { width: 100, height: 100, depth: 1 } }
  end

  def get_molecule_atomes(molecule_type)
    molecules_types_atomes[molecule_type]
  end

  def molecule_sanitizer(properties, values)
    #   # puts 'I may create an uniq method to iterate on array before sanitizing'
    #   # puts 'by so it may also catch when an atome is passed'
    if values.instance_of? Array
      values.each do |value|
        molecule_sanitizer(properties, { add: value })
      end
    else
      molecule_id = @molecule.keys[0]
      molecule_to_insert = get_molecule_atomes(properties).merge({ params: values, parent: molecule_id})
      # puts "****** : #{self.inspect}, molecule : #{@molecule.values}"
      @molecule[molecule_id][properties] = molecule_to_insert
      puts "******  molecule : #{@molecule}"
      # Molecule.new(molecule_to_insert)

      # puts "molecule_to_insert: #{molecule_to_insert}"
      # values = to_rgb(values)
      # values.each do |property, value|
      #   send(property, value)
      # end
    end
  end
end

# this module contains all available molecules
module MoleculeMethods
  def color(value = nil)
    getter_setter(:color, value) do
      molecule_sanitizer(:color, value)
    end
  end
end

# Keep all spatial methods
module Spatial
  # test methods below
  def left(value = nil, stack_property = nil)
    current_property = :left
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def top(value = nil, stack_property = nil)
    current_property = :top
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def bottom(value = nil, stack_property = nil)
    current_property = :bottom
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def right(value = nil, stack_property = nil)
    current_property = :right
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end
end

# this module hold material
module Material
  def child(value = nil, stack_property = nil)
    current_property = :child
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def type(value = nil, stack_property = nil)
    current_property = :type
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def preset(value = nil, stack_property = nil)
    current_property = :preset
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def parent(value = nil, stack_property = nil)
    current_property = :parent
    optional_processor = { pre_process: true, post_process: true }
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def red(value = nil, stack_property = nil)
    current_property = :red
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def green(value = nil, stack_property = nil)
    current_property = :green
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def blue(value = nil, stack_property = nil)
    current_property = :blue
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def alpha(value = nil, stack_property = nil)
    current_property = :alpha
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end

  def radiation(value = nil, stack_property = nil)
    current_property = :radiation
    optional_processor = {}
    properties_common(value, current_property, stack_property, optional_processor)
  end
end

# this module ....
module Electron
  def properties_router(property, value, options, stack_property)
    value = send("#{property}_pre_processor", value) if options[:pre_process]
    # if the pre_processor decide that the value shouldn't be store and render it return nil
    atome_creation(property, value, stack_property) if options[:store_property]
    send_to_render_engine(property, value) if options[:render_property]
    value = send("#{property}_post_processor", value) if options[:post_process]
    method_return value
  end

  def properties_common(value, current_property, stack_property, optional_processor)
    getter_setter(current_property, value) do
      atome_sanitizer(current_property, value) do |sanitized_value, options|
        options = options.merge(optional_processor)
        properties_router(current_property, sanitized_value, options, stack_property)
      end
    end
  end

  def parent_pre_processor(params)
    # here we can decide to render or not the property setting store render_property to false
    # we can also decide to store or not the atome setting store_property property to false
    # puts '- Parent pre processing applied!'
    params
  end

  def parent_post_processor(params)
    # puts '- Parent post processing applied!'
    params
  end

  def method_return(params)
    params
  end
end

# Class  Molecule
class Molecule
  include Universe
  include Electron
  include Spatial
  include Material
  include MoleculeHelper
  include MoleculeMethods
  include Converter

  def initialize(params = {})
    @molecule = {}
    default_values = { parent: :view }
    params = default_values.merge(params)
    params.each_pair do |property, value|
      send(property, value)
    end
  end

  def atome_creation(property, value, stack_property)
    check_stack_property property, stack_property
    a_id = Universe.identity
    @molecule[a_id] = { property => value }
    Universe.atomes(a_id)
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
      # below we set the render_property at true because the property should be rendered as deafulat
      instance_exec(values, { render_property: true, store_property: true }, &block)
    end
  end

  def get_property_content(property)
    value_found = []
    find_property(property) do |property_found|
      value_found << @molecule[property_found][property]
    end
    value_found
  end

  def getter_setter(property, value)
    if value.nil?
      values_found = get_property_content property
      Atome.new({ property => values_found })
      # {  property => values_found }
    else
      yield value
    end
  end

  def check_stack_property(property, stack_property)
    delete_property(property) unless stack_property
  end

  def find_property(property)
    @molecule.each do |a_id_found, atome_found|
      yield a_id_found if atome_found[property]
    end
  end

  def delete_property(property)
    find_property(property) do |properties_found|
      @molecule.delete(properties_found)
    end
  end

  def send_to_render_engine(property, value)
    render_engines = @molecule[:render] || [:html]
    render_engines.each do |render_engine|
      puts "rendering prop: '#{property}'  value:  '#{value}, with engine : #{render_engine}'"
    end
  end

  def add(atome)
    send(atome.keys[0], atome.values[0], :add)
  end

  def inspect
    molecule_content = []
    @molecule.each_value do |atome_found|
      molecule_content << atome_found
    end
    molecule_content.to_s
  end
end

a = Molecule.new({ type: :shape, parent: :view, preset: :box, child: %i[sphere circle],
                   color: %i[red yellow], left: 30, top: 66 })
a.color({ add: :green })
# a = Molecule.new({ type: :shape, parent: :view, top: 33 })
# puts a.inspect

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
# a = Atome.new({ type: :shape, preset: :box, color: %i[red yellow], left: [30,55], top: 66 })
# c = Molecule.new({ type: :shape, child: :toto, preset: :box, color: %i[red yellow], left: [30, 55], top: 66 })
# a = Molecule.new({ type: :shape, child: :toto, preset: :box, color: %i[red yellow], left: [30, 55], top: 66 })
# a= Atome.new({left: [77, 99]})
# a = Molecule.new({ parent: %i[hello super], top: 33 })
# a.add({ parent: :the_father })
# a.left(66)

# ################ start tests
# puts "### property ###"
# # puts a.child
# # puts a.preset
# # puts a.color
# # puts a.left
# # puts "******"
# puts a.parent
# puts a.parent.class
# puts "--- each ---"
# a.parent.each do |prop|
#   puts prop
#   puts prop.class
# end
# ################ end tests

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
#                               :type=>:shape}, {:a_id=>"a_1820_jeezs_20220310163458_2", :preset=>:box},
# {:a_id=>"a_1820_jeezs_20220310163458_3", :red=>0.9}, {:a_id=>"a_1820_jeezs_20220310163458_4", :green=>1},
# {:a_id=>"a_1820_jeezs_20220310163458_5", :blue=>0.3}, {:a_id=>"a_1820_jeezs_20220310163458_6", :alpha=>1},
# {:a_id=>"a_1820_jeezs_20220310163458_7", :red=>0.9}, {:a_id=>"a_1820_jeezs_20220310163458_8", :green=>1},
# {:a_id=>"a_1820_jeezs_20220310163458_9", :blue=>0.3}, {:a_id=>"a_1820_jeezs_20220310163458_10", :alpha=>1},
# {:a_id=>"a_1820_jeezs_20220310163458_11", :left=>30}, {:a_id=>"a_1820_jeezs_20220310163458_12", :top=>66}]
#

# @molecule = { a_1820_jeezs_20220310163458_0: { type: :shape }, a_1820_jeezs_20220310163458_1: { type: :molecule } }

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
