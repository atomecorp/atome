# module Color;end
#
# Color.define_method :top do |params = nil, &user_proc|
#   puts "top Color"
# end
#
# Color.define_method :hello do |params = nil, &user_proc|
#   puts "Hello from Color"
# end
#
# class Atome
#   def hello
#     puts "generic hello"
#   end
#
#   def top
#     puts 'generic top'
#   end
# end
#
# obj1 = Atome.new
# obj1.extend(Color)
#
# #######
#
# # module_to_extend = Object.const_get(element)
# #
# # # Étendre l'objet avec le module
# # new_atome.extend(module_to_extend)
#
#
# ####
#
# obj1.hello
# obj1.top
#
# # Redefine the methods in the singleton class
# # now we remove all module method to restore previous state
# class << obj1
#   methods = Atome.instance_methods
#   methods.each do |module_method|
#     original_method = Atome.instance_method(module_method)
#     define_method(module_method, original_method)
#   end
# end
#
# obj1.hello
# obj1.top
#
#
