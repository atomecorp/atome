# # # # # # frozen_string_literal: true

# Done : when sanitizing property must respect the order else no browser
# object will be created, try to make it more flexible allowing any order
# todo : IMPORTANT : when assigning a color using   b.color(:red) then   b.color(:blue)then  b.color(:red),
# the third "color(:red)" should be the same otome as the first red not generate a new atome
# TODO : Machine builder : new({machine: tool}) => grab(:intuition).tool; def tool .....
# TODO : allow automatic multiple addition of image, text, video, shape, etc.. except color , shadow...
# TODO : history
# TODO : local and distant storage
# TODO : user account
# TODO : int8! : language
# TODO : add a global sanitizer
# TODO : look why get_particle(:children) return an atome not the value
# Done : create color JS for Opal?
# TODO : box callback doesnt work
# TODO : User application is minimized all the time, we must try to condition it
# TODO : A new atome is created each time Genesis.generator is call, we better always use the same atome
# Done : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
# DONE : server crash, it try to use opal_browser_method
# TODO : Check server mode there's a problem with color
# TODO : the function "jsReader" in atome.js cause an error in uglifier when using production mode
# Done : add edit method
# TODO : add add method to add children /parents/colors
# TODO : when drag update the atome's position of all children
# TODO : analysis on Bidirectional code and drag callback
# TODO : create shadow presets
# TODO : analysis on presets sanitizer confusion
# TODO : optimize the use of 'generator = Genesis.generator' it should be at one place only
# TODO : Create a demo test of all apis
# TODO : animate from actual position to another given position
# TODO : keep complex property when animating (cf shadows)
# TODO : 'at' method is bugged : my_video.at accumulate at each video play
# TODO : 'at' method only accept one instance
# Done : check the possibility of creation an instance variable for any particle proc eg : a.left do ... => @left_code
# Done : color, shadow, ... must be add as 'attach' not children
# TODO :  box().left(33).color(:red).smooth(8) doesn't work as atome try to smooth the color instead of the box
# TODO : atome have both 'set_particle' and 'particle' instance variable, eg 'set_color' and 'color' (make a choice)
# TODO : Markers
# TODO : matrix display mode
# TODO : make inheritance to avoid redundancy in Essentials/@default_params
# TODO : find a solution for the value unwanted complexity :  eg : for a.width = a.left.value
# FIXME : Monitor should be integrated as standard properties using 'generator' (eg : a.monitor doesn't return an atome)
# TODO : clones must update their original too when modified
# FIXME : try the add demo makers are totally fucked
# FIXME : URGENT  fix : 'element' tha crash but 'element({})' works beacuse the params is nil at 'def element(params = {}, &bloc)' in 'atome/preset.rb'
# DONE : create a build and guard for tauri
# TODO : 'add' particle  crash : modules=center.matrix({id: :modules,top: 0, left: 0,smooth: 0, columns: {count: 8}, rows: {count: 8}, color: {alpha: 0}})
# TODO : attach remove previously attached object : modules=center.matrix({id: :modules,top: 0, left: 0,smooth: 0, columns: {count: 8}, rows: {count: 8}, color: {alpha: 0}})
#  TODO : when adding a children the parent get the child color: it may be related to : attach remove previously attached object
# FIXME : if in matrix particles shadow or other particles are not define it crash : { margin: 9, color: :blue } in table
#  TODO : self is the not the atome but BrowserHelper so the code below doesn't work :b=box
# TODO : visual size define in % doesn't work  cell_1.text({data: :réalisation, center: :horizontal, top: 3, color: :lightgray, visual: {size: '10%'}})
# TODO : text position at the bottom in matrix cell, botytom position is lost when resizing the table
# TODO : size of image in matrix cell is reset when resizing
# TODO : add .columns and .rows to matrix
# TODO : grab(child).delete(true)  delete children from view but doesn't remove children from parent
# TODO : b.hide(true) can't be revealed , must add : @browser_object.style[:display] = "none"
# TODO : create a colorise method that attach a color to an object
# TODO : add the facility to create any css property and attach it to an object using css id ex left: :toto
# TODO : opacity to add
# TODO : URGENT there's a confusion in the framework between variables and id if the name is the same
# FIXME: touch is unreliable try touch demo some object are not affected

################################# 'to add' error capture  ##################
`window.addEventListener('error', function(e) {
  console.log("---> Now we can log error in a file if needed : " + e.message);
});`
################################# Demos ##################
# require 'src/medias/rubies/demos.rb'
require 'src/medias/rubies/examples/matrix_simple.rb'
# require 'src/medias/rubies/examples/over.rb'


# problem :
#  - empty atome
# - repeat
# - refresh.rb
# # template
################################# to add 'base64' ##################
# ### base 64 test
# # require 'base64'
# #
# # encoded_string = "SGVsbG8gV29ybGQh"
# # decoded_string = Base64.decode64(encoded_string)
# #
# # puts decoded_string
# #
# # string_to_encode = "Hello World!"
# # encoded_string = Base64.encode64(string_to_encode)
# #
# # puts encoded_string

################ end encoding

# # ############################# # spot  test
# # frozen_string_literal: true
# box({ id: :b1 })
# box({ id: :b2, left: 220 })
# box({ id: :b3, left: 340 })
#
# new({ atome: :spot, type: :hash, return: :query })
# new ({ sanitizer: :spot }) do |params|
#   if params.instance_of?(Array)
#     params = { query: params }
#   end
#   params
# end
#
# class Atome
#
#   def query_analysis(condition, operator, type, scope, values, target)
#     # pretenders_atomes = []
#     # all_attached_atome = grab(scope).attached
#     # # we must exclude itself from the atomes found
#     # atome_found = all_attached_atome.reject { |element| element == id }
#     #
#     # atome_queries_in_parent = grab(scope).query
#     # # now we add atome found in the query particle in case of find filtering
#     # atome_found = atome_found.concat(atome_queries_in_parent) if atome_queries_in_parent
#     # # puts "atome found => #{atome_found}"
#     # # puts "scope query : #{atome_queries_in_parent}"
#     # # puts "------"
#
#     case condition
#     when :force
#       case target
#       when :id
#         atome_requested = values
#       else
#       end
#       puts "#{atome_requested} : forced"
#       @atome_forced = @atome_forced | atome_requested
#     when :add
#
#     when :subtract
#
#     else
#
#     end
#
#     # TODO : scope should get all atomes attached to it and all atomes found in the query particle
#     if !@atome_requested.include?(@atome_forced)
#       @atome_requested = @atome_requested | @atome_forced
#     end
#   end
# end
#
# new({ particle: :query, render: false })
# # new({ particle: :result, render: false })
# new({ sanitizer: :query }) do |params|
#   unless @atome_requested
#     @atome_requested = []
#     @atome_forced = []
#   end
#   params.each do |param|
#     condition = param.keys[0]
#     operator = param[condition][:operator] || :equal
#     type = param[condition][:type] || :static
#     scope = param[condition][:scope] || attach[0]
#     values = param[condition][:values]
#     target = param[condition][:target]
#
#     # cleanup_query = { condition => { operator: operator, type: type, scope: scope, values: values, target: target } }
#     cleanup_query = query_analysis(condition, operator, type, scope, values, target)
#     # puts cleanup_query
#     # @atome_requested << cleanup_query
#   end
#   # puts "atome_requested: #{@atome_requested}"
#   @atome_requested
#
# end
#
# # query particle is optional but when specified it must be an array, each queries are added to the results not excluded
# # # 2 possible syntax
# # # a = spot([{target: [:b1, :b3]} ])
# # # a = spot({ query: [target: [:b5, :b9]]})
# # # a = grab(:view).spot({ query: {target: [:b5, :b9]}})
# # parameters are :
# # - target (particle targeted), target type is Symbol
# # - operator (:equal, not, force, superior, inferior), operator type is Symbol
# # - values(particle value that must match the operator), values is an array, each can be string, symbol, int, ...
# # optional parameters are :
# # - scope (parent if not specified), scope type is Symbol
# # - type (dynamic, static), type type is Symbol (dynamic means that each neww atomes that meets the criteria is added to the list)
# # spot atomes must be chained to to filter results
#
# # Example
# # a = spot([{target: :id, values: [:b1, :b3], operator: :equal} ])
# a = grab(:view).spot({ query:
#                          [
#                            { add: {
#                              operator: :equal,
#                              part: :id,
#                              values: [:b1, :b2],
#                              type: :static,
#                            } },
#                            { force: {
#                              target: :id,
#                              values: [:b1],
#                              type: :static,
#                            } },
#                            { add: {
#                              operator: :superior,
#                              target: :left,
#                              values: 30, # non sense!! as only value is possible
#                              type: :static,
#                              method: :filter
#                            } },
#                            { subtract: {
#                              operator: :equal,
#                              target: :left,
#                              values: 30, # non sense!! as only value is possible
#                              type: :static,
#                              method: :filter
#                            } },
#
#                            { subtract: {
#                              operator: :equal,
#                              scope: :b2,
#                              target: :color,
#                              values: [:red],
#                              type: :dynamic,
#                              method: :filter
#                            } }
#
#                          ], id: :first_find }
# )
# # puts '----+++++++++----'
# # puts "a content : #{a}"
# b = a.spot({ query: [{ force: {
#   target: :id,
#   values: [:b2],
#   type: :static,
# } }], id: :second_find })
#
# # alert b.attached
#
# puts "spot content for a is : #{a}"
# puts "spot content for b is : #{b}"
#
# # puts "a find is : #{a.spot}"
# # puts "query msg : #{a.query}"
# # puts "result msg : #{a.result}"
# # TODO : we may remove the collector
# # a.collector({id: :batch1, data: [:b1, :b2]})
# # puts '-----'
# #  grab(:b1).color(:red)
#
# # c=circle(left: 333)
# # c.top(c.left)
# # wait 2 do
# #   c.top(333)
# # end
#
# # TODO : finish atome must return a particular particle instead of itself
# # add batch and monitoring



# # ### batch tests ####
# def batch(atomes)
#   grab(:black_matter).batch(atomes)
#   grab(:black_matter).batch
# end
#
# b=box({ id: :b0, color: :black , drag: true})
# b.box({ id: :b2, left: 220 })
# b.box({ id: :b1, left: 340 })
# batch([:b1, :b2]).color(:white).rotate(33)





##### group experiment
new({atome: :group})

new({sanitizer: :group}) do |params|
  # params= {data: params}
  {}
end

g=group([:b1,:b2])


