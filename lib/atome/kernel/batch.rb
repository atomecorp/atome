# # frozen_string_literal: true
#
# # this class is used to allow batch treatment
# class Batch
#   def each(&proc)
#     @data.each do |val|
#       atome_found = grab(val)
#       instance_exec(atome_found, &proc) if proc.is_a?(Proc)
#     end
#   end
#
#   def initialize(params)
#
#     @data = params
#     grab(params)
#   end
#   def length
#     @data.length
#   end
#   def dispatch(method, args, &block)
#     return_atome = false
#     @data.each do |atome_found|
#       args.each do |arg|
#         # if no arg the we return the atome so we get the particle instead of a batch so we can get the value
#         # TODO : Check when try to get the particle value from a batch (multiple atomes)
#         if arg.nil?
#           return_atome = grab(atome_found).send(method, arg, &block)
#         else
#           grab(atome_found).send(method, arg, &block)
#         end
#
#       end
#     end
#     # we return self to allow method chaining or
#     return_atome || self
#   end
#
#   def to_s
#    instance_variable_get("@data").to_s
#   end
# end
