# # # frozen_string_literal: true
# encoding: utf-8
# alert Dir.entries("src/medias/rubies/")
# a=File.read("src/medias/rubies/text_read.rb")
# require_relative "src/medias/rubies/new_html_renderer"
# a= File.read("src/medias/rubies/new_html_renderer.rb")
# require 'src/medias/rubies/new_html_renderer.rb'
# require '../src/medias/rubies/new_html_renderer.rb'

# require 'temp/opal/new_html_renderer'
# require 'test_app/test'
# alert :strange
# require 'src/new_html_renderer.rb'

# # # Done : when sanitizing property must respect the order else no browser
# # # object will be created, try to make it more flexible allowing any order
# # # FIXME Urgent : delete method doesnt work properly
# # # DONE : fasten method doesnt work properly,
# # # TODO : add pluralize ro atome methods (the method will retrieve all atome eg: grab(:view).shapes will retrieve all
# # # fasten shapes to the view) then we can allow a=shape to create a shape ( for now it must be : a=shape({}))
# # # TODO : IMPORTANT : when assigning a color using b.color(:red) then b.color(:blue)then b.color(:red),
# # # the third "color(:red)" should be the same otome as the first red not generate a new atome
# # # TODO : Machine builder : new({machine: tool}) => grab(:intuition).tool; def tool .....
# # # TODO : allow automatic multiple addition of image, text, video, shape, etc.. except color , shadow...
# # # TODO : history
# # # TODO : local and distant storage
# # # TODO : user account
# # # TODO : int8! : language
# # # TODO : add a global sanitizer
# # # TODO : look why get_particle(:children) return an atome not the value
# # # Done : create color JS for Opal?
# # # TODO : box callback doesnt work
# # # TODO : User application is minimized all the time, we must try to condition it
# # # TODO : A new atome is created each time Genesis.generator is call, we better always use the same atome
# # # Done : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# # # DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
# # # DONE : server crash, it try to use opal_browser_method
# # # TODO : Check server mode there's a problem with color
# # # TODO : the function "jsReader" in atome.js cause an error in uglifier when using production mode
# # # Done : add edit method
# # # TODO : add add method to add children /parents/colors
# # # TODO : when drag update the atome's position of all children
# # # TODO : analysis on Bidirectional code and drag callback
# # # TODO : create shadow presets
# # # TODO : analysis on presets sanitizer confusion
# # # TODO : optimize the use of 'generator = Genesis.generator' it should be at one place only
# # # TODO : Create a demo test of all apis
# # # TODO : animate from actual position to another given position
# # # TODO : keep complex property when animating (cf shadows)
# # # TODO : 'at' method is bugged : my_video.at accumulate at each video play
# # # TODO : 'at' method only accept one instance
# # # Done : check the possibility of creation an instance variable for any particle proc eg : a.left do ... => @left_code
# # # Done : color, shadow, ... must be add as 'attach' not children
# # # TODO : box().left(33).color(:red).smooth(8) doesn't work as atome try to smooth the color instead of the box
# # # TODO : atome have both 'set_particle' and 'particle' instance variable, eg 'set_color' and 'color' (make a choice)
# # # TODO : Markers
# # # TODO : matrix display mode
# # # TODO : make inheritance to avoid redundancy in Essentials/@default_params
# # # TODO : find a solution for the value unwanted complexity : eg : for a.width = a.left.value
# # # FIXME : Monitor should be integrated as standard properties using 'generator' (eg : a.monitor doesn't return an atome)
# # # TODO : clones must update their original too when modified
# # # FIXME : try the add demo makers are totally fucked
# # # FIXME : URGENT fix : 'element' tha crash but 'element({})' works beacuse the params is nil at 'def element(params = {}, &bloc)' in 'atome/preset.rb'
# # # DONE : create a build and guard for tauri
# # # TODO : 'add' particle crash : modules=center.matrix({id: :modules,top: 0, left: 0,smooth: 0, columns: {count: 8}, rows: {count: 8}, color: {alpha: 0}})
# # # TODO : attach remove previously fasten object : modules=center.matrix({id: :modules,top: 0, left: 0,smooth: 0, columns: {count: 8}, rows: {count: 8}, color: {alpha: 0}})
# # # TODO : when adding a children the parent get the child color: it may be related to : attach remove previously fasten object
# # # FIXME : if in matrix particles shadow or other particles are not define it crash : { margin: 9, color: :blue } in table
# # # TODO : self is the not the atome but BrowserHelper so the code below doesn't work :b=box
# # # TODO : visual size define in % doesn't work cell_1.text({data: :realisation, center: :horizontal, top: 3, color: :lightgray, visual: {size: '10%'}})
# # # TODO : text position at the bottom in matrix cell, bottom position is lost when resizing the table
# # # TODO : size of image in matrix cell is reset when resizing
# # # TODO : add .columns and .rows to matrix
# # # TODO : grab(child).delete(true) delete children from view but doesn't remove children from parent
# # # TODO : b.hide(true) can't be revealed , must add : @browser_object.style[:display] = "none"
# # # TODO : create a colorise method that attach a color to an object
# # # TODO : add the facility to create any css property and attach it to an object using css id ex left: :toto
# # # TODO : opacity to add
# # # TODO : URGENT there's a confusion in the framework between variables and id if the name is the same
# # # FIXME: touch is unreliable try touch demo some object are not affected
# #
# # ################################# 'to add' error capture ##################
# # `window.addEventListener('error', function(e) {
# # console.log("---> Now we can log error in a file if needed : " + e.message);
# # });`
#
# ##### to test :
# # require 'src/medias/rubies/examples/batch.rb'
# # require 'src/medias/rubies/examples/group.rb'
# # require 'src/medias/rubies/examples/detached.rb'
# # require 'src/medias/rubies/examples/blur.rb'


# ############# tests verifs nd checks ###############
# current_path = File.expand_path(__FILE__)
# puts "Chemin courant du script : #{current_path}"
# root_directory = Dir.pwd
# puts "Répertoire de travail actuel (racine du projet) : #{root_directory}"
# root_directory = Dir.pwd
#
# # Obtient la liste des fichiers et dossiers dans la racine du projet
# files_in_root = Dir.entries(root_directory)
#
# # Filtrer pour n'afficher que les fichiers (et non les dossiers spéciaux '.' et '..')
# # files_in_root = files_in_root.reject { |file| File.directory?(file) }
# puts "Fichiers présents dans la racine du projet :#{files_in_root}"
# ###
# files_in_src = Dir.entries(root_directory)
# # files_in_src = files_in_src.reject { |fi le| File.directory?(file) }
# puts "Fichiers présents dans SRC :#{files_in_src}"
# ###

# File.open('application/index.rb', 'r') do |file|
# content = file.read
# puts content
# end
# require 'application/medias/rubies/new_html_renderer'
# ######
# require 'medias/rubies/new_html_renderer'

# # works below
# require 'src/medias/rubies/new_html_renderer'
# tests below

# require "temp/opal/new_html_renderer"
# puts "so cool"


# # ##########''####################### Demos ##################
# # require 'src/medias/rubies/demos.rb'
# # require 'src/medias/rubies/examples/universe.rb'
# # require 'src/medias/rubies/examples/batch.rb'
# # require 'src/medias/rubies/examples/vector.rb'
# # require 'src/medias/rubies/examples/group.rb'
# # require 'src/medias/rubies/examples/repeat.rb'
# # require 'src/medias/rubies/examples/edit.rb'
# # require 'src/medias/rubies/examples/delete.rb'
# # require 'src/medias/rubies/examples/fasten.rb'
# # require 'src/medias/rubies/examples/attach.rb'
# # require 'src/medias/rubies/examples/detached.rb'
# # require 'src/medias/rubies/examples/empty_atome.rb'
# # require 'src/medias/rubies/examples/physical.rb'
# # require 'src/medias/rubies/examples/vector.rb'
# # require 'src/medias/rubies/examples/matrix_simple.rb'
# # require 'src/medias/rubies/examples/matrix.rb'
# # require 'src/medias/rubies/examples/over.rb'
# # require 'src/medias/rubies/examples/add.rb'
# # require 'src/medias/rubies/examples/atome_new.rb'
# # require 'src/medias/rubies/examples/physical.rb'
# # require 'src/medias/rubies/examples/vector.rb'
# # require 'src/medias/rubies/examples/shadow.rb'
# # require 'src/medias/rubies/examples/drag.rb'
# # require 'src/medias/rubies/examples/clone.rb'
# # #
# # # problem :
# # # - empty atome
# # # - repeat
# # # - refresh.rb
# # # # template
# # ################################# to add 'base64' ##################
# # # ### base 64 test
# # # # require 'base64'
# # # #
# # # # encoded_string = "SGVsbG8gV29ybGQh"
# # # # decoded_string = Base64.decode64(encoded_string)
# # # #
# # # # puts decoded_string
# # # #
# # # # string_to_encode = "Hello World!"
# # # # encoded_string = Base64.encode64(string_to_encode)
# # # #
# # # # puts encoded_string
# #
# # ################ end encoding
# #
# # # # ############################# # spot test
# # # # frozen_string_literal: true
# # # box({ id: :b1 })
# # # box({ id: :b2, left: 220 })
# # # box({ id: :b3, left: 340 })
# # #
# # # new({ atome: :spot, type: :hash, return: :query })
# # # new ({ sanitizer: :spot }) do |params|
# # # if params.instance_of?(Array)
# # # params = { query: params }
# # # end
# # # params
# # # end
# # #
# # # class Atome
# # #
# # # def query_analysis(condition, operator, type, scope, values, target)
# # # # pretenders_atomes = []
# # # # all_fasten_atome = grab(scope).fasten
# # # # # we must exclude itself from the atomes found
# # # # atome_found = all_fasten_atome.reject { |element| element == id }
# # # #
# # # # atome_queries_in_parent = grab(scope).query
# # # # # now we add atome found in the query particle in case of find filtering
# # # # atome_found = atome_found.concat(atome_queries_in_parent) if atome_queries_in_parent
# # # # # puts "atome found => #{atome_found}"
# # # # # puts "scope query : #{atome_queries_in_parent}"
# # # # # puts "------"
# # #
# # # case condition
# # # when :force
# # # case target
# # # when :id
# # # atome_requested = values
# # # else
# # # end
# # # puts "#{atome_requested} : forced"
# # # @atome_forced = @atome_forced | atome_requested
# # # when :add
# # #
# # # when :subtract
# # #
# # # else
# # #
# # # end
# # #
# # # # TODO : scope should get all atomes fasten to it and all atomes found in the query particle
# # # if !@atome_requested.include?(@atome_forced)
# # # @atome_requested = @atome_requested | @atome_forced
# # # end
# # # end
# # # end
# # #
# # # new({ particle: :query, render: false })
# # # # new({ particle: :result, render: false })
# # # new({ sanitizer: :query }) do |params|
# # # unless @atome_requested
# # # @atome_requested = []
# # # @atome_forced = []
# # # end
# # # params.each do |param|
# # # condition = param.keys[0]
# # # operator = param[condition][:operator] || :equal
# # # type = param[condition][:type] || :static
# # # scope = param[condition][:scope] || attach[0]
# # # values = param[condition][:values]
# # # target = param[condition][:target]
# # #
# # # # cleanup_query = { condition => { operator: operator, type: type, scope: scope,
# # # values: values, target: target } }
# # # cleanup_query = query_analysis(condition, operator, type, scope, values, target)
# # # # puts cleanup_query
# # # # @atome_requested << cleanup_query
# # # end
# # # # puts "atome_requested: #{@atome_requested}"
# # # @atome_requested
# # #
# # # end
# # #
# # # # query particle is optional but when specified it must be an array, each queries are added to the results
# # # # not excluded
# # # # # 2 possible syntax
# # # # # a = spot([{target: [:b1, :b3]} ])
# # # # # a = spot({ query: [target: [:b5, :b9]]})
# # # # # a = grab(:view).spot({ query: {target: [:b5, :b9]}})
# # # # parameters are :
# # # # - target (particle targeted), target type is Symbol
# # # # - operator (:equal, not, force, superior, inferior), operator type is Symbol
# # # # - values(particle value that must match the operator), values is an array, each can be string, symbol, int, ...
# # # # optional parameters are :
# # # # - scope (parent if not specified), scope type is Symbol
# # # # - type (dynamic, static), type type is Symbol (dynamic means that each neww atomes that meets the criteria is
# # # # added to the list)
# # # # spot atomes must be chained to to filter results
# # #
# # # # Example
# # # # a = spot([{target: :id, values: [:b1, :b3], operator: :equal} ])
# # # a = grab(:view).spot({ query:
# # # [
# # # { add: {
# # # operator: :equal,
# # # part: :id,
# # # values: [:b1, :b2],
# # # type: :static,
# # # } },
# # # { force: {
# # # target: :id,
# # # values: [:b1],
# # # type: :static,
# # # } },
# # # { add: {
# # # operator: :superior,
# # # target: :left,
# # # values: 30, # non sense!! as only value is possible
# # # type: :static,
# # # method: :filter
# # # } },
# # # { subtract: {
# # # operator: :equal,
# # # target: :left,
# # # values: 30, # non sense!! as only value is possible
# # # type: :static,
# # # method: :filter
# # # } },
# # #
# # # { subtract: {
# # # operator: :equal,
# # # scope: :b2,
# # # target: :color,
# # # values: [:red],
# # # type: :dynamic,
# # # method: :filter
# # # } }
# # #
# # # ], id: :first_find }
# # # )
# # # # puts '----+++++++++----'
# # # # puts "a content : #{a}"
# # # b = a.spot({ query: [{ force: {
# # # target: :id,
# # # values: [:b2],
# # # type: :static,
# # # } }], id: :second_find })
# # #
# # # # alert b.fasten
# # #
# # # puts "spot content for a is : #{a}"
# # # puts "spot content for b is : #{b}"
# # #
# # # # puts "a find is : #{a.spot}"
# # # # puts "query msg : #{a.query}"
# # # # puts "result msg : #{a.result}"
# # # # TODO : we may remove the collector
# # # # a.collector({id: :batch1, data: [:b1, :b2]})
# # # # puts '-----'
# # # # grab(:b1).color(:red)
# # #
# # # # c=circle(left: 333)
# # # # c.top(c.left)
# # # # wait 2 do
# # # # c.top(333)
# # # # end
# # #
# # # # TODO : finish atome must return a particular particle instead of itself
# # # # add batch and monitoring
# #
# # # # ### batch tests ####
# # # def batch(atomes)
# # # grab(:black_matter).batch(atomes)
# # # grab(:black_matter).batch
# # # end
# # #
# # # b=box({ id: :b0, color: :black , drag: true})
# # # b.box({ id: :b2, left: 220 })
# # # b.box({ id: :b1, left: 340 })
# # # batch([:b1, :b2]).color(:white).rotate(33)
# #
# # ##### group experiment
# # new({ atome: :group , id: :the_big_group})
# #
# # new({ sanitizer: :group }) do |params|
# # # params= {data: params}
# # {}
# # end
# #
# # g = group([:b1, :b2])
# #
# # # # recursive example
# # # b=box
# # #
# # # col=color(:red)
# # # b.touch(true) do
# # # b.box({fasten: col.id})
# # # c=b.circle
# # # c.text(:hello)
# # #
# # # wait 2 do
# # # b.physical.each do |fasten_atome_id|
# # # b.delete({id: fasten_atome_id, recursive: true})
# # # end
# # # end
# # # puts Universe.atomes.length
# # # end
# #
# # # # gradient
# # #
# # # b=box
# # # c=color(:red)
# # # c2=color({ blue: 1, alpha: 1, left: 33, id: :cc_col })
# # # # `console.clear()`
# # # # b.fasten(c.id)
# # # puts '----+++---'
# # # c.attach(b.id)
# # # puts '-------'
# # # b.fasten(c2.id)
# # #
# # # wait 2 do
# # # c2.red(1)
# # # end
# # # #
# # # # # alert b
# # # # c=circle
# # # # new({ particle: :red }) do
# # # # alert 'so cool!'
# # # # # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
# # # # self
# # # # end
# # # # c.red("lkjh")
# #
# # # ##########################################################
# # # undo = <<~STR
# # # <svg xmlns="http://www.w3.org/2000/svg"
# # # viewBox="0 0 512 512"><!-- Font Awesome Free 5.15.4 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) -->
# # # <path d="M 514.58,7 C 380.84,7.24 259.41,59.94 169.76,145.62 L 97.69,73.54 C 67.17,43.03 15,64.64 15,107.79 L 15,378.34 C 15,405.09 36.68,426.77 63.44,426.77 L 333.99,426.77 C 377.14,426.77 398.75,374.6 368.24,344.09 L 283.98,259.83 C 346.27,201.51 426.87,169.2 512.49,168.46 698.97,166.85 856.15,317.76 854.54,510.42 853.01,693.19 704.83,846.55 515.5,846.55 432.5,846.55 354.05,816.93 292.23,762.68 282.66,754.28 268.2,754.8 259.2,763.8 L 179.16,843.84 C 169.32,853.67 169.81,869.7 180.13,879.02 268.88,959.19 386.49,1008 515.5,1008 791.92,1008 1016,783.92 1016,507.5 1016,231.4 790.68,6.51 514.58,7 Z M 514.58,7" />
# # # </svg>
# # # STR
# # #
# # #
# # #
# # #
# # # ################################# 24 05 2023 ########################
# # # # class Atome
# # # # def definition(*var)
# # # #
# # # # end
# # # # end
# # # edition = <<~STR
# # # <path id="p1" d="M257.7 752c2 0 4-0.2 6-0.5L431.9 722c2-0.4 3.9-1.3 5.3-2.8l423.9-423.9c3.9-3.9 3.9-10.2 0-14.1L694.9 114.9c-1.9-1.9-4.4-2.9-7.1-2.9s-5.2 1-7.1 2.9L256.8 538.8c-1.5 1.5-2.4 3.3-2.8 5.3l-29.5 168.2c-1.9 11.1 1.5 21.9 9.4 29.8 6.6 6.4 14.9 9.9 23.8 9.9z m67.4-174.4L687.8 215l73.3 73.3-362.7 362.6-88.9 15.7 15.6-89zM880 836H144c-17.7 0-32 14.3-32 32v36c0 4.4 3.6 8 8 8h784c4.4 0 8-3.6 8-8v-36c0-17.7-14.3-32-32-32z"/>
# # # STR
# # #
# # # c1 = color({ id: :c1, red: 1 })
# # # c2 = color({ id: :c2, green: 1 })
# # # c3 = color({ id: :c3, blue: 1 })
# # # c4 = color({ id: :c4, alpha: 0.3 })
# # # # b=box
# # # v = vector({ id: :the_vector , definition: edition})
# # # b = v.box({ id: :the_box })
# # # v.box({ left: 500, id: :the_box2 })
# # # v.box({ top: 500, id: :the_box3 })
# # # v.circle({ left: 330, top: 230, id: :the_circle })
# # # b.circle({ id: :the_circle2 })
# # # alert "#{v.fasten} : #{v.materials}\n\n#{v}"
# # #
# # # # # v=box({definition: edition})
# # # # # v=shape({"type"=>"shape", "width"=>99, "height"=>99, "fasten"=>"box_color", "attach"=>["view"], "left"=>100, "top"=>100, "clones"=>[], "preset"=>"box", "renderers"=>["browser"], "id"=>"user_view_box_16"})
# # # # # v=shape({"type"=>"shape", "width"=>99, "height"=>99, "fasten"=>"box_color", "attach"=>["view"], "left"=>100, "top"=>100, "clones"=>[], "preset"=>"box", "renderers"=>["browser"], "id"=>"user_view_box_16"})
# # # # # v=shape({})
# # # # # alert grab(:view).shape
# # # # # v.definition(edition)
# # # # v=vector({definition: edition,id: :v1})
# # # wait 0.3 do
# # # v.fasten(:c1)
# # # # c1.attach(:v1)
# # # wait 2 do
# # # v.detached(:c1)
# # # # c1.detach(:the_vector)
# # # # v.fasten(c2.id)
# # # # # v.detached(c.id)
# # # # # wait 1 do
# # # # # v.color(:yellow)
# # # # # end
# # # # # wait 1 do
# # # # # v.fasten(c3.id)
# # # # # # v.color(:violet)
# # # # # wait 1 do
# # # # # v.fasten(c2.id)
# # # # # wait 1 do
# # # # # v.fasten(c4.id)
# # # # # end
# # # # # end
# # # # # end
# # # end
# # # end
# # #
# # # # a=box
# # # # a.definition(edition)
# # # # wait 3 do
# # # # ccc=a.color({id: :theBigColor, red: 1})
# # # #
# # # # wait 2 do
# # # # ccc.red(0.2)
# # # # # ccc.red
# # # # # alert "#{ccc.red}, #{ccc.red.class}"
# # # # grab(:theBigColor).green(0.3)
# # # # end
# # # # end
# # # #
# # # #
# # # # #
# # # # # a.color(:green)
# # # # # # alert grab(:violet)
# # # # # c2=color(:brown)
# # # # # c2.id(:brown)
# # # # # c=color(:violet)
# # # # # c.id(:violet)
# # # # # wait 1 do
# # # # # a.fasten(:brown)
# # # # # wait 1 do
# # # # # a.fasten(:violet)
# # # # # end
# # # # # end
# # # #
# # # #
# # # #
# # # # # alert a.color
# # # # # c=color(:orange)
# # # # # b=box
# # # # # v=b.vector({left: 0, top: 0, definition: undo})
# # # # # c=color(:pink)
# # # # # # color(:white)
# # # # # color({ id: :toto, red: 1 })
# # # # # # v.fasten(c.id)
# # # # # wait 1 do
# # # # # wait 1 do
# # # # # # # alert :should_be_now
# # # # # v.fasten(c.id)
# # # # # end
# # # # # end
# # # # #
# # # # #
# # # # # logo_color ={ red: 0.38, green: 1, blue: 0}
# # # # # logo = <<~STR
# # # # # <path id="vieCanvas-bezier" stroke="rgb(0, 0, 0)" stroke-width="1" stroke-miterlimit="10" fill="rgb(255, 0, 0)" d="M 73.04,26.41 C 50.57,12.14 15.77,53.39 15.81,85.33 15.83,107.68 23.49,124.45 35.37,139.38 97.06,203.55 73.1,232.52 109.61,231.71 134.09,231.16 181.15,134.57 220.5,138.31 232.63,123.3 240.52,106.7 240.5,85.07 240.5,84.51 240.49,83.95 240.47,83.4 211.52,29.92 146.74,182.8 114.45,179.38 69.64,174.65 90.68,37.61 73.04,26.41 Z M 172.32,76.13 C 172.32,94.63 157.34,109.64 138.85,109.64 120.36,109.64 105.37,94.63 105.37,76.13 105.37,57.62 120.36,42.62 138.85,42.62 157.34,42.62 172.32,57.62 172.32,76.13 Z M 172.32,76.13" />
# # # # # STR
# # # # #
# # # # # vector({ width: 133, height: 133, left: :auto, top: 7, right: 15,id: :logo, definition: logo, color: logo_color})
# # # # #
# # # #
# #
# # # Color gradients
# #
#
# # ######### # ############ # ### ######### # ###
# # # TODO : Find solution 1: color is fasten to the wrong object
# # b=box({ id: :the_box, drag: true })
# # b.color(:red)
# # color(:green)
# # b.image('red_planet.png')
# # b.image('green_planet.png')
# # b.color(({id: :c1, red: 1}))
# # b.color(({id: :c2, blue: 1}))
# # b.text({ id: :the_text1, drag: true , data: :hello})
# # b.text({ id: :the_text_2, drag: true ,data: :kool, left: 333})
# # b.circle
# # b.circle
# # # color(:green)
# # # alert "here is the good result: #{b}"
# # # b.color(:red)
# # # wait 1 do
# # # # alert "=> b was : #{b}"
# # # b.color(({id: :c2, blue: 1, attach: [:the_box]}))
# # # #
# # #
# # # b.color(({id: :c3, green: 1}))
# # # alert grab(:view)
# # # alert "=> b is : #{b}"
# # wait 1 do
# # b.text.left(333)
# # # alert "b.text : #{b.text}, #{b.text.class}"
# # b.text.each do |text_found|
# # puts text_found.id
# # end
# #
# # end
# # ######### # ############ # ### ######### # ###
#
# # end
# # circle({ id: :the_circle, drag: true })
#
# # grab(:view).color({ id: :color_1, red: 1})
# # wait 2 do
# # grab(:view).color({ id: :color_2, blue: 0.6 })
# # alert grab(:view)
# # end
# # alert "message after will reveal the solution"
# # col=b.color({id: :the_blue, blue: 1})
# # # alert "col is #{col}"
# # grab(:view).color({ red: 1, id: :red_col })
# # alert '------'
# # b.circle
# # color({id: :the_yellow, green: 1 , red: 1})
# # alert "b is : #{b}"
# #
# # DONE : Find solution 2 colors are not stacked
# # b=box({ id: :the_box, drag: true })
# # grab(:view).color({id: :the_test, blue: 0.3})
# # b.color({id: :the_red, red: 1})
# # b.color({id: :the_blue, blue: 1})
# # b.color({id: :the_green, green: 1 })
# # b.color({id: :the_yellow, green: 1 , red: 1})
# # b.fasten(:the_test)
# # b.fasten(:the_green)
# # alert b
#
# #
# #
# # Find solution 3 : above the color is not rendered because of the order
# # m=matrix
# # 'DONE : find a way to avoid color accumulation'
# # puts 'create a cell type'
# # # alert m.type
#
# ##### Done correct green bug
# # circle({ top: 66, id: :the_circle, color: :green })
#
# # Find solution for text not added to the array
# # b=box
# # b.text({left: 20, top: 30, data: :hello, id: :txt1})
# # b.text({left: 50 , top: 50, data: :kool, id: :txt2})
# # b.text({left: 0, top: 0,data: :ok, id: :txt3})
# # alert " texts are missing : #{b.text}"
#
# # working
#
# # b=box
# #
# # color({ red: 1, id: :the_red })
# #
# # color({ green: 1, id: :the_green })
# # color({ blue: 1, id: :the_blue })
# #
# # b.fasten(:the_red)
# # b.fasten(:the_green)
# # b.fasten(:the_blue)
# # alert b.fasten
# # require 'src/medias/rubies/examples/batch.rb'
# # win = Native(`window`)
# # alert win
#
# #
# ########### browser_less rendering############
#
# # class Atome
# # particle_list_found = Universe.particle_list.keys
# # particle_list_found.each do |the_particle|
# # define_method("inspect_#{the_particle}") do |params, &bloc|
# # puts "=> inspect element: #{the_particle}\nparams : #{params}\nbloc: #{bloc}\n"
# # end
# # end
# # end
# #
# # class HTML
# # def initialize(id)
# # @html_object = `document.getElementById(#{id})`
# # end
# #
# # def style(property, value)
# # `#{@html_object}.style[#{property}] = #{value}` if property
# # self
# # end
# #
# # def filter= values
# # property = values[0]
# # value = values[1]
# # `#{@html_object}.style.filter = #{property}+'('+#{value}+')'`
# # end
# # end
# #
# # class Atome
# # def html
# # @html_accessor = HTML.new(id)
# # end
# #
# # end
# #
# # def html_test(val)
# # html.style.filter = "blur", "#{val / 10}px"
# # html.style(:left, "#{val}px")
# # end
# #
# # a = box
# # # a.blur(6)
# #
# # # wait 5 do
# # a.html_test(300)
# # # end
# #
# # ## group check
# # # box(width: 33, height: 66, color: :cyan, top: 0,left: 555, id: :cyan_box)
# # # box({id: :titi, drag: true})
# # # c = circle({ id: :toto, renderers: [:inspect, :browser] })
# # # # puts '----------'
# # # c.color({ blue: 1 })
# # # # puts '++++++++++'
# # # # # text(:data)
# # # # # `console.clear()`
# # # c.text({ data: :hello, left: 120 })
# # #
# # # g = group([:toto, :cyan_box])
# # # # alert g
# # # g.rotate(33)
# # # g.attach(:titi)
# # # g.color(:red)
# # # g.shape({id: :the_shape, left: 333, color: :green})
# # # g.text(:hi)
# # # # c.atome.delete(:shapes)
# # # # alert c
# # # # alert Universe.user_atomes
# # # # g.type(:image)
# # #
# # # # g.box
# # #
# # # # b=box({renderers: [:browser], id: :titi})
# # # # t=text({data: :hello , id: :hello_id})
# # # # g=group([:toto,:titi])

# def alert(val)
# JS.eval("alert('#{val}')")
# end




# require 'js'
#
#
# JS.eval("return 1 + 2") # => 3
# JS.global[:document].write("Hello, world!")
# div = JS.global[:document].createElement("div")
# div[:innerText] = "clické2 me"
# div[:innerText] = "ici aussi me"
# JS.global[:document][:body].appendChild(div)
# div[:style][:backgroundColor] = "orange"
# div[:style][:color] = "white"
# div.addEventListener("click") do |event|
# puts event # => # [object MouseEvent]
# puts event[:detail] # => 1
# div[:innerText] = "clicked!#{event[:detail]}"
# end
# ######################
#
# def hello_ruby(val=:poil)
# puts "=====*> message from hello_ruby method: #{val} !!"
# end
#
# hello_ruby('kjhkjhkj')
# # var2=JS.eval("var toto= 'big jeezs'; return toto" )
# kooll="super"
# my_str =<<STRD
# var toto= 'first big jeezs'; alert('#{kooll}');return toto
# STRD
#
#
# var2=JS.eval(my_str)
# puts "----------> var2 is #{var2}"
# sec_str=<<str
#
# rubyVM.eval('def hello_ruby(val);puts val;end')
#
#
#
# var toto= 'temp solution for big jeezs';rubyVM.eval('hello_ruby(\"#{var2}\")')
# str
#
# JS.eval(sec_str)
# # JS.eval("var toto= 'big jeezs';rubyVM.eval('hello_ruby(\"jeezs\")')");
# # JS.eval("var result='hello_ruby(\"Gigantic jeezs\")';rubyVM.eval(result)");
# # JS.eval("diamond('ruby method call')");
#
# a=Atome.new()
# puts Universe.atomes
