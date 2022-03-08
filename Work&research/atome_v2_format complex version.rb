# # frozen_string_literal: true
#
# # module Universe is user to test
# module Universe
#   def self.username
#     :jeezs
#   end
#
#   def self.atomes
#     []
#   end
#
#   def molecules
#     [:color]
#   end
# end
#
# # Class  Atome is user to test
# class Atome
#   include Universe
#
#   def identity
#     username = Universe.username
#     atomes = Universe.atomes
#     "a_#{object_id}_#{username}_#{Time.now.strftime('%Y%m%d%H%M%S')}_#{atomes.length}"
#   end
#
#   def atome_genesis(property, value)
#     a_id = identity
#     @atome << { a_id: {data:  a_id }, property => value }
#     atomes = Universe.atomes
#     atomes << a_id
#   end
#
#   def sanitizer(property, value)
#     if value.instance_of? Array
#       value.each do |val|
#         sanitizer property, val
#       end
#     elsif value.instance_of? Hash
#       atome_genesis property, value
#     else
#       atome_genesis property, { data: value }
#     end
#   end
#
#   def initialize(params)
#     @atome = []
#     default_values = { parent: :view }
#     params = default_values.merge(params)
#     params.each_pair do |property, value|
#       sanitizer(property, value)
#     end
#   end
#
#   def to_s
#     @atome.to_s
#   end
#
#   def get_property_content(property)
#     value_found = []
#     @atome.each do |property_content|
#       value_found << property_content[property] unless property_content[property].nil?
#     end
#     value_found
#   end
#
#   def color(value = nil)
#     if value
#       sanitizer(:color, value)
#     else
#       get_property_content :color
#     end
#   end
# end
#
# # Atome.class_variable_set('@@atomes', [])
# # Atome.class_variable_set('@@username', :jeezs)
#
# a = Atome.new({ type: :shape, preset: :box, color: %i[red yellow], x: 30, y: 66 })
# puts a.to_s
# puts '******'
# a.color({ data: :pink, add: true })
# puts a.color
#
# # b = Atome.new({ type: :shape, preset: :circle, color: :orange, x: 90, y: 9 })
# #
# # puts "######"
# # puts b.to_s
