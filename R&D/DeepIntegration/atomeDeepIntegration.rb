# # frozen_string_literal: true
#
# # main entry
# class Atome
#   def self.atomes(params = nil)
#     if params
#       @atomes ||= []
#       @atomes << params
#     else
#       @atomes
#     end
#   end
#
#   def initialize(params = {})
#     @id = params.delete(:id) if params[:id]
#     params.each do |atomes, particles|
#       send(atomes, particles)
#     end
#     Atome.atomes(self)
#   end
#
#   def id(params = nil)
#     if params
#       if @content
#         id_found = @content[:id]
#         container_found = grab(id_found)
#         parent_id_found = container_found.content[:parent]
#         parent_found = grab(parent_id_found)
#         parent_found.colors.instance_variable_set("@#{params}", container_found)
#         parent_found.colors.remove_instance_variable("@#{id_found}")
#         @content[:id]=params
#         parent_found.colors.class.send(:attr_accessor, params)
#       else
#         @id = params
#       end
#     elsif @content
#         @content[:id]
#     else
#         @id
#     end
#   end
#
#   def [](range, &proc)
#     if instance_variables[range].instance_of?(Array)
#       instance_variables[range].each do |id|
#         send(id.to_s.sub('@', ''))
#       end
#     else
#       send(instance_variables[range].to_s.sub('@', ''))
#     end
#   end
#
#   # def each(&proc)
#   #   instance_variables.each do |atome_found|
#   #     proc.call(atome_found)
#   #   end
#   # end
#
#   def read
#     content = []
#     instance_variables.each do |property_found|
#       content << send(property_found.to_s.gsub('@', ''))
#     end
#     content
#   end
#
#   def to_s
#     inspect
#   end
#
#   def content(params = nil)
#     if params
#       @content = params
#     else
#       @content
#     end
#   end
#
#
#   def parent(params = nil)
#     if params
#       @parent = params
#     else
#       @parent
#     end
#   end
#
#   def set(params = nil)
#     instance_variables.each do |atome_found|
#       new_content = send(atome_found.to_s.sub('@', '')).content.merge(params)
#       send(atome_found.to_s.sub('@', '')).content(new_content)
#     end
#   end
#
#   def add(params = nil)
#     if id
#       params.each do |atome, particle|
#         send(atome).add(particle)
#       end
#     else
#       params[:id] = "atome_#{instance_variables.length}" unless params[:id]
#       atome_id = params.delete(:id)
#       self.class.send(:attr_accessor, atome_id)
#       instance_variable_set("@#{atome_id}", params)
#     end
#
#   end
#
#   def replace_helper(targets, new_atome)
#     atome_found = send(targets)
#     new_content = atome_found.content
#     new_content = new_content.merge(new_atome)
#     atome_found.content(new_content)
#   end
#
#   def replace(targets, new_atome)
#     case targets
#     when Integer
#       atome_id_found = instance_variables[targets]
#       atome_to_replace = "#{atome_id_found}".sub('@', '')
#       replace_helper(atome_to_replace, new_atome)
#     when Array
#       targets.each do |target|
#         replace(target, new_atome)
#       end
#     else
#       replace_helper(targets, new_atome)
#     end
#   end
#
#   def render(params)
#     # puts "rendering : #{params}"
#   end
#
#   def grab(params)
#     Atome.atomes.each do |atome|
#       return atome if atome.id == params
#     end
#   end
#
#   def delete(params = nil)
#     case params
#
#     when Symbol
#       remove_instance_variable("@#{params}")
#     when Hash
#       params.each do |property, index|
#         atome_targeted = send(property)
#         if index.instance_of? Symbol || String
#           atome_targeted.remove_instance_variable("@#{index}")
#         else
#           property_targeted = atome_targeted.instance_variables[index]
#           atome_targeted.remove_instance_variable(property_targeted)
#         end
#
#       end
#     when Array
#       params.each do |param|
#         delete(param)
#       end
#     else
#       Atome.atomes.each_with_index do |atome_found, index|
#         Atome.atomes.delete_at(index) if atome_found.id == id
#       end
#     end
#   end
#
#   def colors(params = nil)
#     atome_type = :color
#     if params
#       pluralised_instance_variable = "@#{atome_type}s"
#       unless instance_variable_get(pluralised_instance_variable)
#         instance_variable_set(pluralised_instance_variable, Atome.new)
#       end
#       params.each do |atome_id, property|
#         if property.instance_of?(Hash)
#           property[:parent] = id
#           property[:type] = :color
#           property[:id] = atome_id
#         end
#         # TODO : check if we need to pass the id or not
#         # we only add id for the renderer
#         render({ atome_type => property })
#         send("#{atome_type}s").class.send(:attr_accessor, atome_id)
#         new_atome = Atome.new
#         new_atome.instance_variable_set('@content', property)
#         send("#{atome_type}s").instance_variable_set("@#{atome_id}", new_atome)
#       end
#     else
#       instance_variable_get("@#{atome_type}s")
#     end
#   end
#
#   def color(params = nil)
#     if params
#       if @colors
#         new_params = colors[0].content.merge(params)
#         colors[0].content(new_params)
#       else
#         # no colors found : we create it
#         new_atome_id = "a_color_#{Atome.atomes.length}"
#         colors({ new_atome_id => params })
#       end
#     else
#       colors.read[0]
#     end
#   end
#
#   def red(params = nil)
#     if params
#       @content[:red] = params
#     else
#       @content[:red]
#     end
#
#   end
#
#   def particle_setter_helper(params, particle_name)
#     if @content
#       @content[particle_name] = params
#     else
#       render({ particle_name => params })
#       instance_variable_set("@#{particle_name}", params)
#     end
#   end
#
#   def top(params = nil)
#     if params
#       particle_setter_helper(params, :top)
#     elsif @content
#       @content[:top]
#     else
#       @top
#     end
#   end
#
#   def green(params = nil)
#     if params
#       @content[:green] = params
#     else
#       @content[:green]
#     end
#   end
#
#   def blue(params = nil)
#     if params
#       @content[:blue] = params
#     else
#       @content[:blue]
#     end
#   end
#
#   def shapes(params = nil)
#     atome_type = :shape
#     if params
#       pluralised_instance_variable = "@#{atome_type}s"
#       unless instance_variable_get(pluralised_instance_variable)
#         instance_variable_set(pluralised_instance_variable, Atome.new)
#       end
#       params.each do |atome_id, property|
#         property[:parent] = id if property.instance_of?(Hash)
#         # TODO : check if we need to pass the id or not
#         # we only add id for the renderer
#         render({ atome_type => property.merge({ id: atome_id }) })
#         send("#{atome_type}s").class.send(:attr_accessor, atome_id)
#         new_atome = Atome.new
#         new_atome.instance_variable_set('@content', property)
#         send("#{atome_type}s").instance_variable_set("@#{atome_id}", new_atome)
#       end
#     else
#       instance_variable_get("@#{atome_type}s")
#     end
#
#   end
#
#   def shape(params = nil)
#     if params
#       new_params = shape[0].content.merge(params)
#       shapes[0].content(new_params)
#     else
#       shapes.read[0]
#     end
#   end
#
#   def drms(params = nil) end
#
#   def dnas(params = nil) end
#
# end
#
# # a = {
# #   id: :my_shapes_container,
# #   drms: {  id: :drm_id, color: :read },
# #   dnas: {  id: :dna_id, author: :jeezs, date: :a_10_06_33 },
# #   shapes: {id: :shape1_id, width: 33, height: 999 },
# #   colors: {id: :color1_id, red: 0.3, green: 0.1 }
# # }
#
# a = {
#   id: :my_shapes_container,
#   drms: { drm_id: { color: :read }, drm_id2: { red: :all } },
#   dnas: { dna_id: { author: :jeezs, date: :a_10_06_33 } },
#   shapes: { shape1_id: { width: 33, height: 999 }, shape2_id: { width: 666, height: 333 } },
#   colors: { color1_id: { red: 0.3, green: 0.1 }, color2_2: { red: 0.9, green: 0.39 } }
# }
#
# Atome.new()
#
# b = Atome.new(a)
# # p '------ Results ------'
# # b.color({red: 10})
# # b.color.green(:kool)
# # b.color.blue(:goood)
# # puts b.color
# # puts b.color.red
# # puts b.colors[1]
# # b.colors[1].red(99)
#
# # puts "*********"
#
# # b.delete(colors: 0)
# # b.delete(colors: :color2_2)
# b.delete(:colors)
# # b.delete(true)
# # b.delete([{ colors: 0 }, {colors: :color2_2}])
#
# # b.colors.set({ red: 939 })
# # b.colors.add({ red: 33 })
# # b.colors.add({ red: 66, id: :new_col })
# # b.colors.replace(1,{ red: 99 })
# # b.colors.replace(:color1_id, { red: 33 })
# # ------ make it works: ------
# # b.color.add({ red: 66 }) # irrelevant as color is uniq!
# # b.add(colors: { red: 999 })
#
# b.color({ blue: 9 })
# puts b.colors[0].id
#
# puts '---------'
# b.colors[0].id(:toto)
# puts "b.colors[0].id : #{b.colors[0].id}"
# puts '-----color 0----'
# puts "b.colors[0] : #{b.colors[0]}"
# puts '---------'
# b.top("99%")
# puts "b.top : #{b.top}"
# puts" b.colors : #{b.colors}"
# puts '---------'
# puts "b : #{b}"
# # puts b.shapes