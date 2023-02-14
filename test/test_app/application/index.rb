# # # # frozen_string_literal: true
# #
# # # # # Done : when sanitizing property must respect the order else no browser
# # # object will be created, try to make it more flexible allowing any order
# # # TODO int8! : language
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
# # # TODO :  box().left(33).color(:red).smooth(8) doesn't work as atome try to smooth the color instead of the box
# # # TODO : atome have both 'set_particle' and 'particle' instance variable, eg 'set_color' and 'color' (make a choice)
# # # TODO : Markers
# # # TODO : matrix display mode
# # # TODO : make inheritance to avoid redundancy in Essentials/@default_params
# # # TODO : find a solution for the value unwanted complexity :  eg : for a.width = a.left.value
# # # FIXME : Monitor should be integrated as standard properties using 'generator' (eg : a.monitor doesn't return an atome)
# # # TODO : clones must update their original too when modified
# # # FIXME : try the add demo makers are totally fucked
# # # FIXME : URGENT  fix : 'element' tha crash but 'element({})' works beacuse the params is nil at 'def element(params = {}, &bloc)' in 'atome/preset.rb'
# # # DONE : create a build and guard for tauri
# # # TODO : 'add' particle  crash : modules=center.matrix({id: :modules,top: 0, left: 0,smooth: 0, columns: {count: 8}, rows: {count: 8}, color: {alpha: 0}})
# # # center.add(attach: [c.id])
# # # TODO : attach remove previously attached object : modules=center.matrix({id: :modules,top: 0, left: 0,smooth: 0, columns: {count: 8}, rows: {count: 8}, color: {alpha: 0}})
# # # center.attach([c.id,s.id])
# # #  TODO : when adding a children the parent get the child color: it may be related to : attach remove previously attached object
# # # FIXME : if in matrix particles shadow or other particles are not define it crash : { margin: 9, color: :blue } in table
# # #  TODO : self is the not the atome but BrowserHelper so the code below doesn't work :b=box
# # # b.touch(true) do
# # #   puts self
# # #   self.color(:red)
# # # end
# # # TODO : visual size define in % doesn't work  cell_1.text({data: :réalisation, center: :horizontal, top: 3, color: :lightgray, visual: {size: '10%'}})
# # # TODO : text position at the bottom in matrix cell, botytom position is lost when resizing the table
# # # TODO : size of image in matrix cell is reset when resizing
# # # TODO : add .columns and .rows to matrix
# # # TODO : grab(child).delete(true)  delete children from view but doesn't remove children from parent
# # # TODO : b.hide(true) can't be revealed , must add : @browser_object.style[:display] = "none"
# # # TODO : create a colorise method that attach a color to an object
# # # TODO : add the facility to create any css property and attach it to an object using css id ex left: :toto
# # # TODO : opacity to add
# # # TODO : URGENT thes a confusion in the framework between variables and id if the name is the same
# # # FIXME: touch is unreliable try touch demo some object are not affected

# # # require 'src/medias/rubies/examples/_table2'
# # # require 'src/medias/rubies/examples/schedule'
# # # require 'src/medias/rubies/examples/time'
# # # require 'src/medias/rubies/examples/code'
# # # require 'src/medias/rubies/examples/text'
# # # require 'src/medias/rubies/examples/table'
# # # require 'src/medias/rubies/examples/web'
# # # require 'src/medias/rubies/examples/fullscreen'
# # # require 'src/medias/rubies/examples/video'
# # # require 'src/medias/rubies/examples/touch'
# # # require 'src/medias/rubies/examples/create_atome_in_atome'
# # # require 'src/medias/rubies/examples/color'
# # # require 'src/medias/rubies/examples/animation'
# # # require 'src/medias/rubies/examples/drag'
# # # require 'src/medias/rubies/examples/_dataset'
# # # require 'src/medias/rubies/examples/bottom'
# # # require 'src/medias/rubies/examples/attach'
# # # require 'src/medias/rubies/examples/parents'
# # # require 'src/medias/rubies/examples/markers'
# # # require 'src/medias/rubies/examples/add'
# # # require 'src/medias/rubies/examples/matrix'
# # # require 'src/medias/rubies/examples/color'
# # # require 'src/medias/rubies/examples/read'
# # # require 'src/medias/rubies/examples/drag'
# # # require 'src/medias/rubies/examples/clone'
# # # require 'src/medias/rubies/examples/monitoring'
# # # require 'src/medias/rubies/examples/delete'
# # # require 'src/medias/rubies/examples/_audio'
# # # a={"monitor0"=>{"left"=>{"blocs"=>[:pro_1]}}, "monitor1"=>{"width"=>{"blocs"=>[:pro_2]}}, "my_monitorer"=>{"left"=>{"blocs"=>[:pro_2]}}}
# #
# # # require 'src/medias/rubies/examples/_test'
# # # image(date: :boat)
# #
# # # `
# # # var helloWorld = new Wad({
# # #     source: './medias/audios/Binrpilot.mp3',
# # #
# # #     // add a key for each sprite
# # #     sprite: {
# # #         hello : [0, .4], // the start and end time, in seconds
# # #         world : [.4,1]
# # #     }
# # # });
# # #
# # # // for each key on the sprite object in the constructor above, the wad that is created will have a key of the same name, with a play() method.
# # # //helloWorld.hello.play();
# # # //helloWorld.world.play();
# # #
# # # // you can still play the entire clip normally, if you want.
# # # helloWorld.play();
# # #
# # # // if you hear clicks or pops from starting and stopping playback in the middle of the clip, you can try adding some attack and release to the envelope.
# # # //helloWorld.hello.play({env:{attack: .1, release:.02}})
# # #
# #
# # # generator = Genesis.generator
# # #
# # # generator.build_particle(:red) do
# # #   # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
# # #   self
# # # end
# # #
# # # generator.build_render(:red) do |value|
# # #   red = ((@atome[:red] = value) * 255)
# # #   green = @atome[:green] * 255
# # #   blue = @atome[:blue] * 255
# # #   alpha = @atome[:alpha]
# # #   color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
# # #   BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
# # #   # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
# # #   self
# # # end
# #
# # # Anime repair
# #
# # #
# # # bb = box({ id: :the_ref, width: 369 })
# # # bb.color(:red)
# # # box({ id: :my_box, drag: true })
# # # c = circle({ id: :the_circle, left: 222, drag: { move: true, inertia: true, lock: :start } })
# # # c.shadow({ renderers: [:browser], id: :shadow2, type: :shadow,
# # #            parents: [:the_circle], children: [],
# # #            left: 3, top: 9, blur: 19,
# # #            red: 0, green: 0, blue: 0, alpha: 1
# # #          })
# # #
# # # Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, children: [] })
# # # class Atome
# # #
# # #   def atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# # #     temp_default = Essentials.default_params[atome_type] || {}
# # #     temp_default[:id] = generated_id
# # #     temp_default[:parents] = generated_parents
# # #     temp_default[:clones] = []
# # #     temp_default[:renderers] = generated_render
# # #     temp_default[:children] = generated_children.concat(temp_default[:children])
# # #     temp_default.merge(params)
# # #   end
# # #   def animation(params = {}, &bloc)
# # #     default_renderer = Essentials.default_params[:render_engines]
# # #     atome_type = :animation
# # #     generated_render = params[:renderers] || default_renderer
# # #     generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
# # #     generated_parents = params[:parents] || []
# # #     generated_children = params[:children] || []
# # #     params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# # #     Atome.new({ atome_type => params }, &bloc)
# # #   end
# # # end
# # # aa = animation(
# # #   {
# # #                  targets: %i[my_box the_circle],
# # #                  begin: {
# # #                    left_add: 0,
# # #                    top: :self,
# # #                    smooth: 0,
# # #                    width: 3
# # #                  },
# # #                  end: {
# # #                    left_add: 333,
# # #                    top: 299,
# # #                    smooth: 33,
# # #                    width: :the_ref
# # #                  },
# # #                  duration: 800,
# # #                  mass: 1,
# # #                  damping: 1,
# # #                  stiffness: 1000,
# # #                  velocity: 1,
# # #                  repeat: 1,
# # #                  ease: 'spring'
# # #                }
# # # ) do |pa|
# # #   puts "animation say#{pa}"
# # # end
# #
# # # # video repair
# # #
# # # # frozen_string_literal: true
# # #
# # # my_video = Atome.new(
# # #   video: { renderers: [:browser], id: :video1, type: :video, parents: [:view], path: './medias/videos/superman.mp4',
# # #            left: 333, top: 112, width: 199, height: 99
# # #   }
# # # ) do |params|
# # #   # puts "video callback time is  #{params}, id is : #{id}"
# # #   puts "video callback time is  #{params}, id is : #{id}"
# # # end
# # # wait 2 do
# # #   my_video.left(33)
# # #   my_video.width(444)
# # #   my_video.height(444)
# # #
# # # end
# # #
# # # my_video.touch(true) do
# # #   my_video.play(true) do |currentTime|
# # #     puts "play callback time is : #{currentTime}"
# # #   end
# # # end
# # # # #############
# # # # my_video2 = Atome.new(
# # # #   video: { renderers: [:browser], id: :video9, type: :video, parents: [:view], path: './medias/videos/madmax.mp4',
# # # #            left: 666, top: 333, width: 199, height: 99,
# # # #   }) do |params|
# # # #   puts "2- video callback time is  #{params}, id is : #{id}"
# # # # end
# # # # my_video2.top(33)
# # # # my_video2.left(333)
# # # #
# # # # my_video2.touch(true) do
# # # #   my_video2.play(true) do |currentTime|
# # # #     puts "2 - play callback time is : #{currentTime}, id is : #{id}"
# # # #   end
# # # # end
# # # #
# # # # #############
# # # # my_video3 = video({ path: './medias/videos/avengers.mp4', id: :video16 }) do |params|
# # # #   puts "3 - video callback here #{params}, id is : #{id}"
# # # # end
# # # # my_video3.width = my_video3.height = 333
# # # # my_video3.left(555)
# # # # grab(:video16).on(:pause) do |_event|
# # # #   puts "id is : #{id}"
# # # # end
# # # # my_video3.touch(true) do
# # # #   grab(:video16).time(15)
# # # #   my_video3.play(true) do |currentTime|
# # # #     puts "3- play callback time is : #{currentTime}, id is : #{id}"
# # # #   end
# # # #   wait 3 do
# # # #     puts "time is :#{my_video3.time}"
# # # #   end
# # # #   wait 6 do
# # # #     grab(:video16).pause(true) do |time|
# # # #       puts "paused at #{time} id is : #{id}"
# # # #     end
# # # #   end
# # # # end
# #
# # # generator=Genesis.generator
# # # generator.build_particle(:hook) do |targets|
# # #   targets.each do |target|
# # #     grab(target).attach([atome[:id]])
# # #   end
# # # end
# # # #########################
# # # e=element(data: :hello_world)
# #
# # # ###########################
# # triple_b=box
# # circle(color: :red)
# # text({data: :hello})
# # generator=Genesis.generator
# # generator.build_atome(:poil)
# # generator.build_particle(:opacity, {render: false})
# # # p=box({opacity: 55})
# # #TODO: if poil has no render it crash!!
# # # pp=poil({renderers: []})
# # # pp=triple_b.poil
# # class Atome
# #   def dum(poil)
# #
# #   end
# # end
# # pp=poil
# # # pp.dum(:poilu)
# # pp.renderers([:browser])
# # # pp.opacity(3)
# # # alert pp.opacity
# # # pp.opacity(22)
# # #TODO: if element has no data particle it crash!!
# # # element
# # ########################
# # # alert :good
# # # b=box
# # # c=b.box({color: :red, left: 99})
# # # d=c.box({color: :cyan, left: 99})
# # # d.box({color: :green, left: 99})
# # # d.text({data: "Comme <br>une image développe la production de documentaires en privilégiant la maîtrise technique au service de la sensibilité et de l’humilité. En quête d’ouverture d’esprit sur le monde et d’une vision singulière , nos créations concernent aujourd’hui autant la télévision que le cinéma.
# # # " })
# # #
#
# #############
# # generator = Genesis.generator
# # generator.build_sanitizer(:shape) do |params|
# #   # alert params
# #   # parent_found = found_parents_and_renderers[:parent]
# #   # render_found = found_parents_and_renderers[:renderers]
# #   # default_params = { renderers: render_found, id: "video_#{Universe.atomes.length}", type: :video,
# #   #                    parents: parent_found }
# #   # default_params.merge!(params)
# #   params
# # end
#
# # class Atome
# #   # def element(params = { data: :ok }, &bloc)
# #   #   atome_type = :element
# #   #   generated_render = params[:renderers] || []
# #   #
# #   #   generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
# #   #   generated_parents = params[:parents] || [id.value]
# #   #   generated_children = params[:children] || []
# #   #
# #   #   generated_data = ""
# #   #   params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# #   #   # FIXME: do not merge generated_data like this but change the atomecommon
# #   #   params.merge(generated_data)
# #   #
# #   #   Atome.new({ atome_type => params }, &bloc)
# #   # end
# #
# # end
#
# #######  will replace all corrupted methods
# # generator.build_sanitizer(:web) do |params, &bloc|
# #   default_renderer = Essentials.default_params[:render_engines]
# #
# #   generated_id = params[:id] || "web_#{Universe.atomes.length}"
# #   generated_render = params[:renderers] || default_renderer
# #   generated_parents = params[:parents] || id.value
# #   # TODO : the line below should get the value from default params Essentials
# #   temp_default = { renderers: generated_render, id: generated_id, type: :web, parents: [generated_parents],
# #                    children: [], width: 120, height: 120, path: 'https://www.youtube.com/embed/usQDazZKWAk' }
# #   params = temp_default.merge(params)
# #   Atome.new({ image: params }, &bloc)
# #   params
# # end
# #
# # generator.build_sanitizer(:animation) do |params, &bloc|
# #   default_renderer = Essentials.default_params[:render_engines]
# #   atome_type = :animation
# #   generated_render = params[:renderers] || default_renderer
# #   generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
# #   generated_parents = params[:parents] || []
# #   generated_children = params[:children] || []
# #   params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# #   Atome.new({ atome_type => params }, &bloc)
# #   params
# #
# # end
# #
# # generator.build_sanitizer(:image) do |params, &bloc|
# #   unless params.instance_of? Hash
# #     # TODO : we have to convert all image to png or maintain a database with extension
# #     params = { path: "./medias/images/#{params}" }
# #   end
# #   default_renderer = Essentials.default_params[:render_engines]
# #   generated_id = params[:id] || "image_#{Universe.atomes.length}"
# #   generated_render = params[:renderers] || default_renderer
# #   generated_parents = params[:parents] || id.value
# #   # TODO : the line below should get the value from default params Essentials
# #   temp_default = { renderers: generated_render, id: generated_id, type: :image, parents: [generated_parents],
# #                    children: [], width: 99, height: 99, path: './medias/images/atome.svg' }
# #   params = temp_default.merge(params)
# #   Atome.new({ image: params }, &bloc)
# #   params
# # end
# # generator.build_sanitizer(:text) do |params, &bloc|
# #   default_renderer = Essentials.default_params[:render_engines]
# #   atome_type = :text
# #   generated_render = params[:renderers] || default_renderer
# #   generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
# #   generated_parents = params[:parents] || [id.value]
# #   generated_children = params[:children] || []
# #   params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# #   Atome.new({ atome_type => params }, &bloc)
# #   params
# # end
#
# b = box
# image("boat.png")
#
# # `
# # async function getImages() {
# #   const response = await fetch('/medias/images/');
# #   const data = await response.json();
# #   let images = []
# #   data.forEach(image => {
# #     images.push(image.url)
# #   });
# #   return images;
# # }
# #
# # const images = getImages();
# # console.log(images);
# # `
#
# a = box({id: :the_box})
#
# def svg_fetch(svg_name,width=33, height= 33,svg_color=:lightgray)
#   `
#  fetch("./medias/images/icons/" +#{svg_name} +".svg")
#     .then(response => response.text())
#    .then(svgText => {
#         let svgContainer = document.getElementById("the_box");
#         let parser = new DOMParser();
#         let svgDoc = parser.parseFromString(svgText, "image/svg+xml");
#         let importedSVG = svgDoc.getElementsByTagName("svg")[0];
#         importedSVG.style.width = #{width} + "px";
#         importedSVG.style.height = #{height} + "px";
#         let elements = importedSVG.getElementsByTagName("path");
#         Array.from(elements).forEach(el => {
#             el.setAttribute("fill", #{svg_color});
#         });
#         svgContainer.appendChild(importedSVG);
#     });
# `
# end
#
# svg_color=:cyan
# adress='stop'
# svg_fetch(adress,61,61,svg_color)
#
#
# # a.read('rubies/examples/') do |params|
# #   # alert params
# #   text({ data: params, visual: { size: 9 } })
# # end
# # i = b.image({ path: "./medias/images/moto.png", left: 33, top: 33 })
# #
# # b.text({ data: :hello })
# #
# # alert b.color.inspect
# # alert b
#
# # alert Universe.particle_list
# # c=b.element
# # e=element
# # alert e.inspect
# # c.renderers([:headless])
# # puts c.id(:toto)
# # puts e.id(:toto)
# #############
#
# # m = matrix
# # cell1 = m.cell(1)
# # cell2 = m.cell(2)
# # cell1.color(:orange)
# # cell1.image({ path: :boat })
# # cell1.touch(true) do
# #   alert :poil
# #   # cell1.color(:red)
# # end
# #
# #
# # cell2.touch(true) do
# #   cell1.unbind(:touch)
# #   cell1.delete(:children)
# #   cell1.touch(true) do
# #     alert :kool
# #     # cell1.color(:red)
# #   end
# # end
# #
# # b=box({top: :auto, bottom: 33})
# #
# # b.touch(true) do
# #   alert :no
# # end
# #
# # # m[1].color(:red)
#
# ##################
#
# class Atome
#   def webobject
#     web_object = `document.getElementById(#{id.value})`
#     WebObject.new(web_object)
#   end
# end
#
# def new(params, &bloc)
#   generator = Genesis.generator
#   if params.key?(:particle)
#     generator.build_particle(params[:particle], { render: params[:render], store: params[:store] }, &bloc)
#   elsif params.key?(:atome)
#     generator.build_atome(params[:atome], &bloc)
#   elsif params.key?(:sanitizer)
#     generator.build_sanitizer(params[:sanitizer], &bloc)
#   elsif params.key?(:browser)
#     generator.build_render("browser_#{params[:browser]}", &bloc)
#   end
# end
#
# # new({atome: :pol, render: false, store: true  })
# # new({particle: :poila, render: false, store: true  })
# # p=pol({poil: 33})
# # alert p.class

# require 'src/medias/rubies/examples/vie'

# TODO: classes must be an array or we wont be able to add multiple classes to the atome ex:
# b=box
# b.classes([:new_class])
# # b.classes << :other_class
#
# c=circle
# c.classes([:new_class])
# c.classes([:new_class])
# c.classes([:new_class])
# # must accept once
#
# puts Universe.classes
# b.remove({classes: :new_class})
#
#
# puts Universe.classes

# #####################
#
#
# new({ sanitizer: :color }) do |params|
#   parent_found = found_parents_and_renderers[:parent]
#   parent_found = [:black_matter] if parent_found == [:view]
#   render_found = found_parents_and_renderers[:renderers]
#   # we delete any previous color if there's one
#   if parent_found[0] == :black_matter
#     alert :hool
#   end
#   default_params = { renderers: render_found, id: "color_#{Universe.atomes.length}", type: :color,
#                      attach: parent_found,
#                      red: 0, green: 0, blue: 0, alpha: 1 }
#   params = create_color_hash(params) unless params.instance_of? Hash
#   new_params = default_params.merge!(params)
#   atome[:color] = new_params
#   new_params
# end
#
# b=box
# # alert b
# color(:red)
# # bb=b.browser_object
# # alert b

# #####################
#

# e.data.each do |dt|
#   alert dt
# end
# def insert_module(module_id)
#   grab(:selected).data.each do |module_id_found|
#     module_found = grab(module_id_found)
#     # alert module_id_found.class
#
#     # module_found.children.each do |child_found|
#     #   grab(child_found).delete(true) if grab(child_found)
#     # end
#     # tool_found = tool_list[module_id][:icon]
#     # tool_color= :orange
#     # module_found.box({id: "#{module_found.id.value}_svg_support", width: module_found.width.value/2, height: module_found.height.value/2, center: true, attached: :invisible_color})
#     # svg_fetch(tool_found, tool_color, "#{module_found.id.value}_svg_support")
#   end
#
# end
#
# insert_module(:toto)
#

# require 'src/medias/rubies/examples/table'

# new({ sanitizer: :color }) do |params|
#   if  color.value
#     grab(color.value[:id]).delete(true)
#   end
#   parent_found = found_parents_and_renderers[:parent]
#   parent_found = [:black_matter] if parent_found == [:view]
#   render_found = found_parents_and_renderers[:renderers]
#   # we delete any previous color if there's one
#   # alert
#   default_params = { renderers: render_found, id: "color_#{Universe.atomes.length}", type: :color,
#                      attach: parent_found,
#                      red: 0, green: 0, blue: 0, alpha: 1 }
#   params = create_color_hash(params) unless params.instance_of? Hash
#   new_params = default_params.merge!(params)
#   atome[:color] = new_params
#   new_params
# end
#
#
# new({ sanitizer: :shadow }) do |params|
#   # we delete any previous shadow if there's one
#
#   grab(shadow.value[:id]).delete(true) if shadow.value
#   parent_found = found_parents_and_renderers[:parent]
#   parent_found = [:user_view] if parent_found == [:view]
#   render_found = found_parents_and_renderers[:renderers]
#   default_params = { renderers: render_found, id: "shadow_#{Universe.atomes.length}", type: :shadow,
#                      attach: parent_found,
#                      red: 0, green: 0, blue: 0, alpha: 1, blur: 3, left: 3, top: 3 }
#   # default_params.merge!(params)
#     params = create_shadow_hash(params) unless params.instance_of? Hash
#     new_params = default_params.merge!(params)
#     atome[:shadow] = new_params
#     new_params
#
# end

# new({particle: :touch , store: true })
# new({sanitizer: :touch  }) do |params, bloc|
#   # alert bloc
#   # @touch='lkjl'
#   # alert bloc
#   # if params.instance_of? Hash
#   #   sanitized_params=params
#   # else
#   sanitized_params={}
#     sanitized_params[params]=bloc
#     # sanitized_params=params
#   # end
#   # alert sanitized_params
#   sanitized_params
# end
#
# new({ post: :touch }) do |params, user_bloc|
#   @touch = {} if @touch == nil
#   @touch[params] = user_bloc
#   # as store for touch is set to false we have to manually save the instance variable
#   store_value(:touch)
# end
######################### works below
# b = box()
# b.color(:red)
# b.color(:black)
# b.color(:yellow)
# c=b.circle
#
# c.color(:blue)
# c.color(:pink)
#
# # alert b.attached
# b.detached("box_color")

# require 'src/medias/rubies/examples/_table2'
# require 'src/medias/rubies/examples/schedule'
# require 'src/medias/rubies/examples/time'
# require 'src/medias/rubies/examples/code'
# require 'src/medias/rubies/examples/text'
# require 'src/medias/rubies/examples/table'
# require 'src/medias/rubies/examples/web'
# require 'src/medias/rubies/examples/fullscreen'
# require 'src/medias/rubies/examples/video'
 require 'src/medias/rubies/examples/touch'
# require 'src/medias/rubies/examples/create_atome_in_atome'
# require 'src/medias/rubies/examples/color'
# require 'src/medias/rubies/examples/animation'
# require 'src/medias/rubies/examples/drag'
# require 'src/medias/rubies/examples/_dataset'
# require 'src/medias/rubies/examples/bottom'
# require 'src/medias/rubies/examples/attached'
# require 'src/medias/rubies/examples/parents'
# require 'src/medias/rubies/examples/markers'
# require 'src/medias/rubies/examples/add'
# require 'src/medias/rubies/examples/matrix'
# require 'src/medias/rubies/examples/color'
# require 'src/medias/rubies/examples/read'
# require 'src/medias/rubies/examples/drag'
# require 'src/medias/rubies/examples/clone'
# require 'src/medias/rubies/examples/monitoring'
# require 'src/medias/rubies/examples/delete'
# require 'src/medias/rubies/examples/_audio'

# frozen_string_literal: true

############################# problems here ###########################################################################################################################################################################################################
# b=box({color: :blue })
# b.color(:red)
# alert "col is : #{b.color.value}"
# grab(b.color.value[:id]).delete(true)
############################# problems here ###########################################################################################################################################################################################################



#############################*********************######################################@



# alert b.attached
# alert c
# # alert b.color.value.class
# b.color(:blue)
# b.shadow({ blur: 33 })
#
# b.shadow({ blur: 44 })
# # alert b.color.value.class
# b.color(:orange)
# b.color(:violet)
# # c=color(:green)
# # b.attached(c.id)
# # alert b.color
# b.touch(:up) do
#   color(:blue)
# end
#
# b.touch(:long) do
#   color(:yellow)
# end
#
# # alert :goodyob
# puts "=> #{b.touch}"
#
# # alert b.color

# t=text({ data: "hello guys!!", color: :orange })
# # t=text({ data: :hello_you_all, id: :the_text})
# wait 1 do
#   t.color(:red)
#   wait 1 do
#     t.color(:green)
#     wait 1 do
#       t.color(:yellow)
#     end
#   end
# end

# frozen_string_literal: true

