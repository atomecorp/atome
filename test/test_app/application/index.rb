# # # # # # frozen_string_literal: true
# # # #
# # # # # # # Done : when sanitizing property must respect the order else no browser
# # # # # object will be created, try to make it more flexible allowing any order
# # # # # TODO : history
# # # # # TODO : local and distant storage
# # # # # TODO : user account
# # # # # TODO : int8! : language
# # # # # TODO : add a global sanitizer
# # # # # TODO : look why get_particle(:children) return an atome not the value
# # # # # Done : create color JS for Opal?
# # # # # TODO : box callback doesnt work
# # # # # TODO : User application is minimized all the time, we must try to condition it
# # # # # TODO : A new atome is created each time Genesis.generator is call, we better always use the same atome
# # # # # Done : Decide with Regis if we create a new css, an inline style on object or alter the css as describe above
# # # # # DOME: when applying atome.atome ( box.color), color should be added to the list of box's children
# # # # # DONE : server crash, it try to use opal_browser_method
# # # # # TODO : Check server mode there's a problem with color
# # # # # TODO : the function "jsReader" in atome.js cause an error in uglifier when using production mode
# # # # # Done : add edit method
# # # # # TODO : add add method to add children /parents/colors
# # # # # TODO : when drag update the atome's position of all children
# # # # # TODO : analysis on Bidirectional code and drag callback
# # # # # TODO : create shadow presets
# # # # # TODO : analysis on presets sanitizer confusion
# # # # # TODO : optimize the use of 'generator = Genesis.generator' it should be at one place only
# # # # # TODO : Create a demo test of all apis
# # # # # TODO : animate from actual position to another given position
# # # # # TODO : keep complex property when animating (cf shadows)
# # # # # TODO : 'at' method is bugged : my_video.at accumulate at each video play
# # # # # TODO : 'at' method only accept one instance
# # # # # Done : check the possibility of creation an instance variable for any particle proc eg : a.left do ... => @left_code
# # # # # Done : color, shadow, ... must be add as 'attach' not children
# # # # # TODO :  box().left(33).color(:red).smooth(8) doesn't work as atome try to smooth the color instead of the box
# # # # # TODO : atome have both 'set_particle' and 'particle' instance variable, eg 'set_color' and 'color' (make a choice)
# # # # # TODO : Markers
# # # # # TODO : matrix display mode
# # # # # TODO : make inheritance to avoid redundancy in Essentials/@default_params
# # # # # TODO : find a solution for the value unwanted complexity :  eg : for a.width = a.left.value
# # # # # FIXME : Monitor should be integrated as standard properties using 'generator' (eg : a.monitor doesn't return an atome)
# # # # # TODO : clones must update their original too when modified
# # # # # FIXME : try the add demo makers are totally fucked
# # # # # FIXME : URGENT  fix : 'element' tha crash but 'element({})' works beacuse the params is nil at 'def element(params = {}, &bloc)' in 'atome/preset.rb'
# # # # # DONE : create a build and guard for tauri
# # # # # TODO : 'add' particle  crash : modules=center.matrix({id: :modules,top: 0, left: 0,smooth: 0, columns: {count: 8}, rows: {count: 8}, color: {alpha: 0}})
# # # # # center.add(attach: [c.id])
# # # # # TODO : attach remove previously attached object : modules=center.matrix({id: :modules,top: 0, left: 0,smooth: 0, columns: {count: 8}, rows: {count: 8}, color: {alpha: 0}})
# # # # # center.attach([c.id,s.id])
# # # # #  TODO : when adding a children the parent get the child color: it may be related to : attach remove previously attached object
# # # # # FIXME : if in matrix particles shadow or other particles are not define it crash : { margin: 9, color: :blue } in table
# # # # #  TODO : self is the not the atome but BrowserHelper so the code below doesn't work :b=box
# # # # # b.touch(true) do
# # # # #   puts self
# # # # #   self.color(:red)
# # # # # end
# # # # # TODO : visual size define in % doesn't work  cell_1.text({data: :réalisation, center: :horizontal, top: 3, color: :lightgray, visual: {size: '10%'}})
# # # # # TODO : text position at the bottom in matrix cell, botytom position is lost when resizing the table
# # # # # TODO : size of image in matrix cell is reset when resizing
# # # # # TODO : add .columns and .rows to matrix
# # # # # TODO : grab(child).delete(true)  delete children from view but doesn't remove children from parent
# # # # # TODO : b.hide(true) can't be revealed , must add : @browser_object.style[:display] = "none"
# # # # # TODO : create a colorise method that attach a color to an object
# # # # # TODO : add the facility to create any css property and attach it to an object using css id ex left: :toto
# # # # # TODO : opacity to add
# # # # # TODO : URGENT thes a confusion in the framework between variables and id if the name is the same
# # # # # FIXME: touch is unreliable try touch demo some object are not affected
# #
# # # # # require 'src/medias/rubies/examples/_table2'
# # # # # require 'src/medias/rubies/examples/schedule'
# # # # # require 'src/medias/rubies/examples/time'
# # # # # require 'src/medias/rubies/examples/code'
# # # # # require 'src/medias/rubies/examples/text'
# # # # # require 'src/medias/rubies/examples/table'
# # # # # require 'src/medias/rubies/examples/web'
# # # # # require 'src/medias/rubies/examples/fullscreen'
# # # # # require 'src/medias/rubies/examples/video'
# # # # # require 'src/medias/rubies/examples/touch'
# # # # # require 'src/medias/rubies/examples/create_atome_in_atome'
# # # # # require 'src/medias/rubies/examples/color'
# # # # # require 'src/medias/rubies/examples/animation'
# # # # # require 'src/medias/rubies/examples/drag'
# # # # # require 'src/medias/rubies/examples/_dataset'
# # # # # require 'src/medias/rubies/examples/bottom'
# # # # # require 'src/medias/rubies/examples/attach'
# # # # # require 'src/medias/rubies/examples/parents'
# # # # # require 'src/medias/rubies/examples/markers'
# # # # # require 'src/medias/rubies/examples/add'
# # # # # require 'src/medias/rubies/examples/matrix'
# # # # # require 'src/medias/rubies/examples/color'
# # # # # require 'src/medias/rubies/examples/read'
# # # # # require 'src/medias/rubies/examples/drag'
# # # # # require 'src/medias/rubies/examples/clone'
# # # # # require 'src/medias/rubies/examples/monitoring'
# # # # # require 'src/medias/rubies/examples/delete'
# # # # # require 'src/medias/rubies/examples/_audio'
# # # # # a={"monitor0"=>{"left"=>{"blocs"=>[:pro_1]}}, "monitor1"=>{"width"=>{"blocs"=>[:pro_2]}}, "my_monitorer"=>{"left"=>{"blocs"=>[:pro_2]}}}
# # # #
# # # # # require 'src/medias/rubies/examples/_test'
# # # # # image(date: :boat)
# # # #
# # # # # `
# # # # # var helloWorld = new Wad({
# # # # #     source: './medias/audios/Binrpilot.mp3',
# # # # #
# # # # #     // add a key for each sprite
# # # # #     sprite: {
# # # # #         hello : [0, .4], // the start and end time, in seconds
# # # # #         world : [.4,1]
# # # # #     }
# # # # # });
# # # # #
# # # # # // for each key on the sprite object in the constructor above, the wad that is created will have a key of the same name, with a play() method.
# # # # # //helloWorld.hello.play();
# # # # # //helloWorld.world.play();
# # # # #
# # # # # // you can still play the entire clip normally, if you want.
# # # # # helloWorld.play();
# # # # #
# # # # # // if you hear clicks or pops from starting and stopping playback in the middle of the clip, you can try adding some attack and release to the envelope.
# # # # # //helloWorld.hello.play({env:{attack: .1, release:.02}})
# # # # #
# # # #
# # # # # generator = Genesis.generator
# # # # #
# # # # # generator.build_particle(:red) do
# # # # #   # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
# # # # #   self
# # # # # end
# # # # #
# # # # # generator.build_render(:red) do |value|
# # # # #   red = ((@atome[:red] = value) * 255)
# # # # #   green = @atome[:green] * 255
# # # # #   blue = @atome[:blue] * 255
# # # # #   alpha = @atome[:alpha]
# # # # #   color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
# # # # #   BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
# # # # #   # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
# # # # #   self
# # # # # end
# # # #
# # # # # Anime repair
# # # #
# # # # #
# # # # # bb = box({ id: :the_ref, width: 369 })
# # # # # bb.color(:red)
# # # # # box({ id: :my_box, drag: true })
# # # # # c = circle({ id: :the_circle, left: 222, drag: { move: true, inertia: true, lock: :start } })
# # # # # c.shadow({ renderers: [:browser], id: :shadow2, type: :shadow,
# # # # #            parents: [:the_circle], children: [],
# # # # #            left: 3, top: 9, blur: 19,
# # # # #            red: 0, green: 0, blue: 0, alpha: 1
# # # # #          })
# # # # #
# # # # # Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, children: [] })
# # # # # class Atome
# # # # #
# # # # #   def atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# # # # #     temp_default = Essentials.default_params[atome_type] || {}
# # # # #     temp_default[:id] = generated_id
# # # # #     temp_default[:parents] = generated_parents
# # # # #     temp_default[:clones] = []
# # # # #     temp_default[:renderers] = generated_render
# # # # #     temp_default[:children] = generated_children.concat(temp_default[:children])
# # # # #     temp_default.merge(params)
# # # # #   end
# # # # #   def animation(params = {}, &bloc)
# # # # #     default_renderer = Essentials.default_params[:render_engines]
# # # # #     atome_type = :animation
# # # # #     generated_render = params[:renderers] || default_renderer
# # # # #     generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
# # # # #     generated_parents = params[:parents] || []
# # # # #     generated_children = params[:children] || []
# # # # #     params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# # # # #     Atome.new({ atome_type => params }, &bloc)
# # # # #   end
# # # # # end
# # # # # aa = animation(
# # # # #   {
# # # # #                  targets: %i[my_box the_circle],
# # # # #                  begin: {
# # # # #                    left_add: 0,
# # # # #                    top: :self,
# # # # #                    smooth: 0,
# # # # #                    width: 3
# # # # #                  },
# # # # #                  end: {
# # # # #                    left_add: 333,
# # # # #                    top: 299,
# # # # #                    smooth: 33,
# # # # #                    width: :the_ref
# # # # #                  },
# # # # #                  duration: 800,
# # # # #                  mass: 1,
# # # # #                  damping: 1,
# # # # #                  stiffness: 1000,
# # # # #                  velocity: 1,
# # # # #                  repeat: 1,
# # # # #                  ease: 'spring'
# # # # #                }
# # # # # ) do |pa|
# # # # #   puts "animation say#{pa}"
# # # # # end
# # # #
# # # # # # video repair
# # # # #
# # # # # # frozen_string_literal: true
# # # # #
# # # # # my_video = Atome.new(
# # # # #   video: { renderers: [:browser], id: :video1, type: :video, parents: [:view], path: './medias/videos/superman.mp4',
# # # # #            left: 333, top: 112, width: 199, height: 99
# # # # #   }
# # # # # ) do |params|
# # # # #   # puts "video callback time is  #{params}, id is : #{id}"
# # # # #   puts "video callback time is  #{params}, id is : #{id}"
# # # # # end
# # # # # wait 2 do
# # # # #   my_video.left(33)
# # # # #   my_video.width(444)
# # # # #   my_video.height(444)
# # # # #
# # # # # end
# # # # #
# # # # # my_video.touch(true) do
# # # # #   my_video.play(true) do |currentTime|
# # # # #     puts "play callback time is : #{currentTime}"
# # # # #   end
# # # # # end
# # # # # # #############
# # # # # # my_video2 = Atome.new(
# # # # # #   video: { renderers: [:browser], id: :video9, type: :video, parents: [:view], path: './medias/videos/madmax.mp4',
# # # # # #            left: 666, top: 333, width: 199, height: 99,
# # # # # #   }) do |params|
# # # # # #   puts "2- video callback time is  #{params}, id is : #{id}"
# # # # # # end
# # # # # # my_video2.top(33)
# # # # # # my_video2.left(333)
# # # # # #
# # # # # # my_video2.touch(true) do
# # # # # #   my_video2.play(true) do |currentTime|
# # # # # #     puts "2 - play callback time is : #{currentTime}, id is : #{id}"
# # # # # #   end
# # # # # # end
# # # # # #
# # # # # # #############
# # # # # # my_video3 = video({ path: './medias/videos/avengers.mp4', id: :video16 }) do |params|
# # # # # #   puts "3 - video callback here #{params}, id is : #{id}"
# # # # # # end
# # # # # # my_video3.width = my_video3.height = 333
# # # # # # my_video3.left(555)
# # # # # # grab(:video16).on(:pause) do |_event|
# # # # # #   puts "id is : #{id}"
# # # # # # end
# # # # # # my_video3.touch(true) do
# # # # # #   grab(:video16).time(15)
# # # # # #   my_video3.play(true) do |currentTime|
# # # # # #     puts "3- play callback time is : #{currentTime}, id is : #{id}"
# # # # # #   end
# # # # # #   wait 3 do
# # # # # #     puts "time is :#{my_video3.time}"
# # # # # #   end
# # # # # #   wait 6 do
# # # # # #     grab(:video16).pause(true) do |time|
# # # # # #       puts "paused at #{time} id is : #{id}"
# # # # # #     end
# # # # # #   end
# # # # # # end
# # # #
# # # # # generator=Genesis.generator
# # # # # generator.build_particle(:hook) do |targets|
# # # # #   targets.each do |target|
# # # # #     grab(target).attach([atome[:id]])
# # # # #   end
# # # # # end
# # # # # #########################
# # # # # e=element(data: :hello_world)
# # # #
# # # # # ###########################
# # # # triple_b=box
# # # # circle(color: :red)
# # # # text({data: :hello})
# # # # generator=Genesis.generator
# # # # generator.build_atome(:poil)
# # # # generator.build_particle(:opacity, {render: false})
# # # # # p=box({opacity: 55})
# # # # #TODO: if poil has no render it crash!!
# # # # # pp=poil({renderers: []})
# # # # # pp=triple_b.poil
# # # # class Atome
# # # #   def dum(poil)
# # # #
# # # #   end
# # # # end
# # # # pp=poil
# # # # # pp.dum(:poilu)
# # # # pp.renderers([:browser])
# # # # # pp.opacity(3)
# # # # # alert pp.opacity
# # # # # pp.opacity(22)
# # # # #TODO: if element has no data particle it crash!!
# # # # # element
# # # # ########################
# # # # # alert :good
# # # # # b=box
# # # # # c=b.box({color: :red, left: 99})
# # # # # d=c.box({color: :cyan, left: 99})
# # # # # d.box({color: :green, left: 99})
# # # # # d.text({data: "Comme <br>une image développe la production de documentaires en privilégiant la maîtrise technique au service de la sensibilité et de l’humilité. En quête d’ouverture d’esprit sur le monde et d’une vision singulière , nos créations concernent aujourd’hui autant la télévision que le cinéma.
# # # # # " })
# # # # #
# # #
# # # #############
# # # # generator = Genesis.generator
# # # # generator.build_sanitizer(:shape) do |params|
# # # #   # alert params
# # # #   # parent_found = found_parents_and_renderers[:parent]
# # # #   # render_found = found_parents_and_renderers[:renderers]
# # # #   # default_params = { renderers: render_found, id: "video_#{Universe.atomes.length}", type: :video,
# # # #   #                    parents: parent_found }
# # # #   # default_params.merge!(params)
# # # #   params
# # # # end
# # #
# # # # class Atome
# # # #   # def element(params = { data: :ok }, &bloc)
# # # #   #   atome_type = :element
# # # #   #   generated_render = params[:renderers] || []
# # # #   #
# # # #   #   generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
# # # #   #   generated_parents = params[:parents] || [id.value]
# # # #   #   generated_children = params[:children] || []
# # # #   #
# # # #   #   generated_data = ""
# # # #   #   params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# # # #   #   # FIXME: do not merge generated_data like this but change the atomecommon
# # # #   #   params.merge(generated_data)
# # # #   #
# # # #   #   Atome.new({ atome_type => params }, &bloc)
# # # #   # end
# # # #
# # # # end
# # #
# # # #######  will replace all corrupted methods
# # # # generator.build_sanitizer(:web) do |params, &bloc|
# # # #   default_renderer = Essentials.default_params[:render_engines]
# # # #
# # # #   generated_id = params[:id] || "web_#{Universe.atomes.length}"
# # # #   generated_render = params[:renderers] || default_renderer
# # # #   generated_parents = params[:parents] || id.value
# # # #   # TODO : the line below should get the value from default params Essentials
# # # #   temp_default = { renderers: generated_render, id: generated_id, type: :web, parents: [generated_parents],
# # # #                    children: [], width: 120, height: 120, path: 'https://www.youtube.com/embed/usQDazZKWAk' }
# # # #   params = temp_default.merge(params)
# # # #   Atome.new({ image: params }, &bloc)
# # # #   params
# # # # end
# # # #
# # # # generator.build_sanitizer(:animation) do |params, &bloc|
# # # #   default_renderer = Essentials.default_params[:render_engines]
# # # #   atome_type = :animation
# # # #   generated_render = params[:renderers] || default_renderer
# # # #   generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
# # # #   generated_parents = params[:parents] || []
# # # #   generated_children = params[:children] || []
# # # #   params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# # # #   Atome.new({ atome_type => params }, &bloc)
# # # #   params
# # # #
# # # # end
# # # #
# # # # generator.build_sanitizer(:image) do |params, &bloc|
# # # #   unless params.instance_of? Hash
# # # #     # TODO : we have to convert all image to png or maintain a database with extension
# # # #     params = { path: "./medias/images/#{params}" }
# # # #   end
# # # #   default_renderer = Essentials.default_params[:render_engines]
# # # #   generated_id = params[:id] || "image_#{Universe.atomes.length}"
# # # #   generated_render = params[:renderers] || default_renderer
# # # #   generated_parents = params[:parents] || id.value
# # # #   # TODO : the line below should get the value from default params Essentials
# # # #   temp_default = { renderers: generated_render, id: generated_id, type: :image, parents: [generated_parents],
# # # #                    children: [], width: 99, height: 99, path: './medias/images/atome.svg' }
# # # #   params = temp_default.merge(params)
# # # #   Atome.new({ image: params }, &bloc)
# # # #   params
# # # # end
# # # # generator.build_sanitizer(:text) do |params, &bloc|
# # # #   default_renderer = Essentials.default_params[:render_engines]
# # # #   atome_type = :text
# # # #   generated_render = params[:renderers] || default_renderer
# # # #   generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
# # # #   generated_parents = params[:parents] || [id.value]
# # # #   generated_children = params[:children] || []
# # # #   params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
# # # #   Atome.new({ atome_type => params }, &bloc)
# # # #   params
# # # # end
# # #
# # # b = box
# # # image("boat.png")
# # #
# # # # `
# # # # async function getImages() {
# # # #   const response = await fetch('/medias/images/');
# # # #   const data = await response.json();
# # # #   let images = []
# # # #   data.forEach(image => {
# # # #     images.push(image.url)
# # # #   });
# # # #   return images;
# # # # }
# # # #
# # # # const images = getImages();
# # # # console.log(images);
# # # # `
# # #
# # # a = box({id: :the_box})
# # #
# # # def svg_fetch(svg_name,width=33, height= 33,svg_color=:lightgray)
# # #   `
# # #  fetch("./medias/images/icons/" +#{svg_name} +".svg")
# # #     .then(response => response.text())
# # #    .then(svgText => {
# # #         let svgContainer = document.getElementById("the_box");
# # #         let parser = new DOMParser();
# # #         let svgDoc = parser.parseFromString(svgText, "image/svg+xml");
# # #         let importedSVG = svgDoc.getElementsByTagName("svg")[0];
# # #         importedSVG.style.width = #{width} + "px";
# # #         importedSVG.style.height = #{height} + "px";
# # #         let elements = importedSVG.getElementsByTagName("path");
# # #         Array.from(elements).forEach(el => {
# # #             el.setAttribute("fill", #{svg_color});
# # #         });
# # #         svgContainer.appendChild(importedSVG);
# # #     });
# # # `
# # # end
# # #
# # # svg_color=:cyan
# # # adress='stop'
# # # svg_fetch(adress,61,61,svg_color)
# # #
# # #
# # # # a.read('rubies/examples/') do |params|
# # # #   # alert params
# # # #   text({ data: params, visual: { size: 9 } })
# # # # end
# # # # i = b.image({ path: "./medias/images/moto.png", left: 33, top: 33 })
# # # #
# # # # b.text({ data: :hello })
# # # #
# # # # alert b.color.inspect
# # # # alert b
# # #
# # # # alert Universe.particle_list
# # # # c=b.element
# # # # e=element
# # # # alert e.inspect
# # # # c.renderers([:headless])
# # # # puts c.id(:toto)
# # # # puts e.id(:toto)
# # # #############
# # #
# # # # m = matrix
# # # # cell1 = m.cell(1)
# # # # cell2 = m.cell(2)
# # # # cell1.color(:orange)
# # # # cell1.image({ path: :boat })
# # # # cell1.touch(true) do
# # # #   alert :poil
# # # #   # cell1.color(:red)
# # # # end
# # # #
# # # #
# # # # cell2.touch(true) do
# # # #   cell1.unbind(:touch)
# # # #   cell1.delete(:children)
# # # #   cell1.touch(true) do
# # # #     alert :kool
# # # #     # cell1.color(:red)
# # # #   end
# # # # end
# # # #
# # # # b=box({top: :auto, bottom: 33})
# # # #
# # # # b.touch(true) do
# # # #   alert :no
# # # # end
# # # #
# # # # # m[1].color(:red)
# # #
# # # ##################
# # #
# # # class Atome
# # #   def webobject
# # #     web_object = `document.getElementById(#{id.value})`
# # #     WebObject.new(web_object)
# # #   end
# # # end
# # #
# # # def new(params, &bloc)
# # #   generator = Genesis.generator
# # #   if params.key?(:particle)
# # #     generator.build_particle(params[:particle], { render: params[:render], store: params[:store] }, &bloc)
# # #   elsif params.key?(:atome)
# # #     generator.build_atome(params[:atome], &bloc)
# # #   elsif params.key?(:sanitizer)
# # #     generator.build_sanitizer(params[:sanitizer], &bloc)
# # #   elsif params.key?(:browser)
# # #     generator.build_render("browser_#{params[:browser]}", &bloc)
# # #   end
# # # end
# # #
# # # # new({atome: :pol, render: false, store: true  })
# # # # new({particle: :poila, render: false, store: true  })
# # # # p=pol({poil: 33})
# # # # alert p.class
# #
# # # require 'src/medias/rubies/examples/vie'
# #
# # # TODO: classes must be an array or we wont be able to add multiple classes to the atome ex:
# # # b=box
# # # b.classes([:new_class])
# # # # b.classes << :other_class
# # #
# # # c=circle
# # # c.classes([:new_class])
# # # c.classes([:new_class])
# # # c.classes([:new_class])
# # # # must accept once
# # #
# # # puts Universe.classes
# # # b.remove({classes: :new_class})
# # #
# # #
# # # puts Universe.classes
# #
# # # #####################
# # #
# # #
# # # new({ sanitizer: :color }) do |params|
# # #   parent_found = found_parents_and_renderers[:parent]
# # #   parent_found = [:black_matter] if parent_found == [:view]
# # #   render_found = found_parents_and_renderers[:renderers]
# # #   # we delete any previous color if there's one
# # #   if parent_found[0] == :black_matter
# # #     alert :hool
# # #   end
# # #   default_params = { renderers: render_found, id: "color_#{Universe.atomes.length}", type: :color,
# # #                      attach: parent_found,
# # #                      red: 0, green: 0, blue: 0, alpha: 1 }
# # #   params = create_color_hash(params) unless params.instance_of? Hash
# # #   new_params = default_params.merge!(params)
# # #   atome[:color] = new_params
# # #   new_params
# # # end
# # #
# # # b=box
# # # # alert b
# # # color(:red)
# # # # bb=b.browser_object
# # # # alert b
# #
# # # #####################
# # #
# #
# # # e.data.each do |dt|
# # #   alert dt
# # # end
# # # def insert_module(module_id)
# # #   grab(:selected).data.each do |module_id_found|
# # #     module_found = grab(module_id_found)
# # #     # alert module_id_found.class
# # #
# # #     # module_found.children.each do |child_found|
# # #     #   grab(child_found).delete(true) if grab(child_found)
# # #     # end
# # #     # tool_found = tool_list[module_id][:icon]
# # #     # tool_color= :orange
# # #     # module_found.box({id: "#{module_found.id.value}_svg_support", width: module_found.width.value/2, height: module_found.height.value/2, center: true, attached: :invisible_color})
# # #     # svg_fetch(tool_found, tool_color, "#{module_found.id.value}_svg_support")
# # #   end
# # #
# # # end
# # #
# # # insert_module(:toto)
# # #
# #
# # # require 'src/medias/rubies/examples/table'
# #
# # # new({ sanitizer: :color }) do |params|
# # #   if  color.value
# # #     grab(color.value[:id]).delete(true)
# # #   end
# # #   parent_found = found_parents_and_renderers[:parent]
# # #   parent_found = [:black_matter] if parent_found == [:view]
# # #   render_found = found_parents_and_renderers[:renderers]
# # #   # we delete any previous color if there's one
# # #   # alert
# # #   default_params = { renderers: render_found, id: "color_#{Universe.atomes.length}", type: :color,
# # #                      attach: parent_found,
# # #                      red: 0, green: 0, blue: 0, alpha: 1 }
# # #   params = create_color_hash(params) unless params.instance_of? Hash
# # #   new_params = default_params.merge!(params)
# # #   atome[:color] = new_params
# # #   new_params
# # # end
# # #
# # #
# # # new({ sanitizer: :shadow }) do |params|
# # #   # we delete any previous shadow if there's one
# # #
# # #   grab(shadow.value[:id]).delete(true) if shadow.value
# # #   parent_found = found_parents_and_renderers[:parent]
# # #   parent_found = [:user_view] if parent_found == [:view]
# # #   render_found = found_parents_and_renderers[:renderers]
# # #   default_params = { renderers: render_found, id: "shadow_#{Universe.atomes.length}", type: :shadow,
# # #                      attach: parent_found,
# # #                      red: 0, green: 0, blue: 0, alpha: 1, blur: 3, left: 3, top: 3 }
# # #   # default_params.merge!(params)
# # #     params = create_shadow_hash(params) unless params.instance_of? Hash
# # #     new_params = default_params.merge!(params)
# # #     atome[:shadow] = new_params
# # #     new_params
# # #
# # # end
# #
# # # new({particle: :touch , store: true })
# # # new({sanitizer: :touch  }) do |params, bloc|
# # #   # alert bloc
# # #   # @touch='lkjl'
# # #   # alert bloc
# # #   # if params.instance_of? Hash
# # #   #   sanitized_params=params
# # #   # else
# # #   sanitized_params={}
# # #     sanitized_params[params]=bloc
# # #     # sanitized_params=params
# # #   # end
# # #   # alert sanitized_params
# # #   sanitized_params
# # # end
# # #
# # # new({ post: :touch }) do |params, user_bloc|
# # #   @touch = {} if @touch == nil
# # #   @touch[params] = user_bloc
# # #   # as store for touch is set to false we have to manually save the instance variable
# # #   store_value(:touch)
# # # end
# # ######################### works below
# # # b = box()
# # # b.color(:red)
# # # b.color(:black)
# # # b.color(:yellow)
# # # c=b.circle
# # #
# # # c.color(:blue)
# # # c.color(:pink)
# # #
# # # # alert b.attached
# # # b.detached("box_color")
# #
# #
# # # frozen_string_literal: true
# #
# # ############################# problems here ###########################################################################################################################################################################################################
# # # b=box({color: :blue })
# # # b.color(:red)
# # # alert "col is : #{b.color.value}"
# # # grab(b.color.value[:id]).delete(true)
# # ############################# problems here ###########################################################################################################################################################################################################
# #
# # #############################*********************######################################@
# #
# # # alert b.attached
# # # alert c
# # # # alert b.color.value.class
# # # b.color(:blue)
# # # b.shadow({ blur: 33 })
# # #
# # # b.shadow({ blur: 44 })
# # # # alert b.color.value.class
# # # b.color(:orange)
# # # b.color(:violet)
# # # # c=color(:green)
# # # # b.attached(c.id)
# # # # alert b.color
# # # b.touch(:up) do
# # #   color(:blue)
# # # end
# # #
# # # b.touch(:long) do
# # #   color(:yellow)
# # # end
# # #
# # # # alert :goodyob
# # # puts "=> #{b.touch}"
# # #
# # # # alert b.color
# # # b=box({id: :toto})
# # # #################################################@ jen suis la
# # # t=text({ data: "hello guys!!", color: :orange })
# # # # t=text({ data: :hello_you_all, id: :the_text})
# # # wait 0.5 do
# # #   t.color(:red)
# # #   wait 0.5 do
# # #     t.color(:green)
# # #     wait 0.5 do
# # #       t.color(:yellow)
# # #
# # #
# # #     end
# # #   end
# # # end
# # # wait 2 do
# # #   t.add({color: :blue})
# # #   # alert t
# # # end
# # # ################################################# apres ca marche
# #
# # def add_to_atome(atome_type, particles_found, &user_proc)
# #   # alert particles_found
# #   send(atome_type,particles_found)
# #   # we update  the holder of any new particle if user pass a bloc
# #   # store_code_bloc(particle, &user_proc) if user_proc
# #   # values.each do |value_id, value|
# #   #   @atome[particle][value_id] = value
# #   # end
# # end
# #
# #
# #
# #
# #
# #
# # ######## start tests #######
# # box
# # wait 1 do
# #   c=circle({id: :titi, color: :yellow })
# #   ## c=circle({id: :titi })
# #   # c.box({left: 100, id: :a1})
# #   # c.box({left: 200, id: :a12})
# #   # c.box({left: 300, id: :a14})
# #   # c.color(:red)
# # end
# #
# #
# #
# # # puts "c color is :#{c.color},  #{c.color.value.class}"
# # # puts "c shape is :#{c.shape},  #{c.shape.value.class}"
# #
# #
# # ########## end tests #######
# # # puts "b color is : #{b.color}"
# # # puts "b is : #{b}"
# # # puts "c is : #{c}"
# # # solution for attached, children or box => list box children , color: list color children
# #
# # #
# # # # frozen_string_literal: true
# # #
# # # #################
# # # # frozen_string_literal: true
# # #
# #
# # ############# last important test
# # color({id: :toto, red: 1})
# #
# # b=box
# # color({id: :tii, red: 1})
# # alert grab(:toto)
# # alert grab(:view)
#
# # image('boat.png')
# # i=image({ id: :logo, height: 39,  path: './medias/images/logos/atome.svg',  width: '9%',top: 19, left: 19 })
# # puts  "b => #{b}"
# # puts  "i => #{i}"
# # b.include(c.id)
#
# # alert(grab(:view).parents)
#
#
#
# require 'src/medias/rubies/examples/schedule'
# require 'src/medias/rubies/examples/time'
# require 'src/medias/rubies/examples/code'
# require 'src/medias/rubies/examples/text'
# require 'src/medias/rubies/examples/delete'
# require 'src/medias/rubies/examples/table'#######
# require 'src/medias/rubies/examples/web'
# require 'src/medias/rubies/examples/fullscreen'
# require 'src/medias/rubies/examples/video'
# require 'src/medias/rubies/examples/touch'
# require 'src/medias/rubies/examples/create_atome_in_atome'
# require 'src/medias/rubies/examples/color'
# require 'src/medias/rubies/examples/animation'
# require 'src/medias/rubies/examples/drag'
# require 'src/medias/rubies/examples/bottom'
# require 'src/medias/rubies/examples/attached'
# require 'src/medias/rubies/examples/parents'
# require 'src/medias/rubies/examples/markers'
# require 'src/medias/rubies/examples/add'
# require 'src/medias/rubies/examples/read'
# require 'src/medias/rubies/examples/clone'
# require 'src/medias/rubies/examples/atome_new'
# require 'src/medias/rubies/examples/link'
require 'src/medias/rubies/examples/monitoring'






# require 'src/medias/rubies/examples/delete'
# require 'src/medias/rubies/examples/_audio'
# ###############
# # b=box({id: :the_box})
# # b.color(:red)
# # # c=circle({id: :the_circle, color: [{ renderers: [:browser], id: :shaper_color, type: :color,
# # #                                   red: 0.4, green: 0.4, blue: 1, alpha: 1 }]})
# # x=circle({color: :purple, id: :cici})
# # # c.color(:red)
# # # c.color(:orange)
# # # cc=circle()
# # # # e=text(:hello)
# # # # b.children([c.id])
# # # # b.children([cc.id])
# # # # b.children([e.id])
# # b.set_color({ renderers: [:browser], id: :shaper_color, type: :color,
# #               red: 0.4, green: 0.4, blue: 1, alpha: 1 })
# # b.left(33)
# # # # puts b
# # # b.attached(c.id)
# # #
# # #
# # # puts b
# ############### new tests ################
#
# # puts 'xxxx :'
# # `console.clear()`
#
# # wait 1 do
# #
# # c=circle({ id: :cici0, shadow: { renderers: [:browser], id: :shadow2, type: :shadow, parents: [], children: [],
# #                                  left: 3, top: 9, blur: 3, direction: :inset,
# #                                  red: 0, green: 0, blue: 0, alpha: 1
# # }})
# # c=circle({ colour: 'red'})
# #  `console.clear()`
#
#
#
# # ##################### important to test ########################
# # wait 0.1 do
# #  # c=circle({color: { renderers: [:browser], id: :dor_color, type: :color,
# #  #                     red: 0, green: 0.5, blue: 0.5, alpha: 1 } })
# #  # c=circle({color: :orange})
# #  # c=circle({ id: :cici0, shadow: { renderers: [:browser], id: :shadow2, type: :shadow, parents: [],
# #  #                                  left: 3, top: 9, blur: 3, direction: :inset,
# #  #                                  red: 0, green: 0, blue: 0, alpha: 1
# #  # }})
# #   c=circle()
# #
# #  b=box
# #  c.attached(b.id)
# #
# #  # c.color(:red)
# #  puts c.browser_object
# #  puts "color : #{c.color}"
# #  c.color(:orange)
# #  c.shadow(true)
# #  c.add({shadow: true})
# #  c.add({color: {red: 1, id: :poip}})
# #  c.add({color: {red: 0.1,green: 1, id: :yyy}})
# #  c.add({color: :blue})
# #  # puts "c is #{c}"
# #  puts "circle color : #{c.color}"
# #  puts "circle shadow : #{c.shadow}"
# #  puts "Shadow : #{grab(c.shadow.value[0])}"
# #
# #  puts "c.color is #{c.color.value}"
# #  puts "c.shadow is #{c.shadow.value}"
# #  # c.color(:red)
# #  c.shadow({red: 0, green: 1, blue: 0, alpha: 1, blur: 3, left: 3, top: 3})
# #  c.box({left: 60, id: :the_boite})
# #  t=c.text({left: 60, id: :the_text, data: :hello})
# #  t2=c.text({top: 60, id: :the_second_text, data: :hi})
# #  t.color(:yellow)
# #  c.box({top: 60, id: :the_second_box})
# #  # color_found=c.color.value
# #  # puts "color found : #{color_found}, #{color_found.class}"
# #  shadow_found=c.shadow.value
# #  puts "shadow found : #{shadow_found}, #{shadow_found.class}"
# #  puts "shadow_found.last is : #{grab(shadow_found.last).class}: #{grab(shadow_found.last)}"
# #  puts c.color
# #  puts c.shadow
# #  puts c.shape
# #  puts c.text
# # end
# # #############################################
#
# # c=circle
# # c.color({ renderers: [:browser], id: :dor_color, type: :color,
# #                                            red: 1, green: 0.5, blue: 0.5, alpha: 1 })
# # c=circle({ colors: 'cyan' , shadow: { smooth: 20 }})
#
# # b= :red
# # b.colors(:poil)
# # c=circle({ id: :cici0, colors: { renderers: [:browser], id: :dor_color, type: :color,
# #                                  red: 0.5, green: 0.5, blue: 0.5, alpha: 1 } })
# # c=circle({ id: :cici1})
# #   # puts '-------- sep 1 -------'
# #   c.colors('green')
# # c.send(:set_color, :red)
# # circle({ id: :cercledor, color: { color: { renderers: :browser, id: :dor_color, type: :color,
# #                                            red: 0.5, green: 0.5, blue: 0.5, alpha: 1 } }})
#   # wait 1 do
#     # puts '-------- sep 2 -------'
#     # circle({shadow: true, id: :cici1})
# # circle({shadow: { renderers: [:browser], id: :shadow2, type: :shadow, parents: [], children: [],
# #                   left: 3, top: 9, blur: 3, direction: :inset,
# #                   red: 0, green: 0, blue: 0, alpha: 1
# # }, id: :cici1})
# # circle({color:    { renderers: [:browser], id: :c319, type: :color,
# #                     red: 1, green: 1, blue: 0.15, alpha: 0.6 }, id: :cici1})
#
#   # end
#
# # end
#
#
#
# # my_video = Atome.new(
# #   video: { renderers: [:browser],  id: :video1, type: :video, parents: [:view],
# #            path: './medias/videos/avengers.mp4', left: 333, top: 33, width: 777
# #   }
# # )
# #
# # my_video.touch(true) do
# #  my_video.play(3)
# #  puts "play : #{my_video.play}, pause : #{my_video.pause}"
# # end
# #
# # stoper = lambda do
# #  my_video.pause(true)
# # end
# #
# # jumper=lambda do
# #  my_video.play(12)
# #  my_video.play(12)
# # end
# #
# # my_video.markers({ markers: { begin: 6, code: jumper } })
# #
# # my_video.add({ markers: { my_stop: { begin: 16, code: stoper }, shadow: { blur: 20 }}})
# # alert my_video
# b=box
# b.color(:red)
# b.color(:green)
# # b.color(:blue)
# # b.color(:violet)
# # b.color(:cyan)
# # b.add(color: :red)
# puts b.color
# puts b.attached
#
# # a=[1,2,3,4,5,6]
# # puts a
# # a.delete(3)
# # puts a
# i=image('green_planet.png')
# i.shadow(true)
# text(:hello)
# puts b
#
# my_video3 = video({ path: './medias/videos/avengers.mp4', id: :video16 }) do |params|
#   puts "3 - video callback here #{params}, id is : #{id}"
# end
# my_video3.width = my_video3.height = 333
# my_video3.left(555)
# grab(:video16).on(:pause) do |_event|
#   puts "id is : #{id}"
# end
# my_video3.touch(true) do
#   grab(:video16).time(15)
#   my_video3.play(true) do |currentTime|
#     puts "3- play callback time is : #{currentTime}, id is : #{id}"
#   end
#   wait 3 do
#     puts "time is :#{my_video3.time}"
#   end
#   wait 6 do
#     grab(:video16).pause(true) do |time|
#       puts "paused at #{time} id is : #{id}"
#     end
#   end
# end
#
# # e=element(data: :hello_world)
# # # puts e
# # web({path: 'https://www.youtube.com/embed/usQDazZKWAk', top: 160})
# #
# #
# # # frozen_string_literal: true
# # # alert "le texte plante"
# # bb = text({ id: :the_ref, width: 369, data: "touch me!" })
# # bb.color(:orange)
# # box({ id: :my_box, drag: true })
# # c = circle({ id: :the_circle, left: 222, drag: { move: true, inertia: true, lock: :start } })
# # c.shadow({ renderers: [:browser], id: :shadow2, type: :shadow,
# #            parents: [:the_circle],
# #            left: 3, top: 9, blur: 19,
# #            red: 0, green: 0, blue: 0, alpha: 1
# #          })
# #
# # Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation })
# # aa = animation({
# #                  targets: %i[my_box the_circle],
# #                  begin: {
# #                    left_add: 0,
# #                    top: :self,
# #                    smooth: 0,
# #                    width: 3
# #                  },
# #                  end: {
# #                    left_add: 333,
# #                    top: 299,
# #                    smooth: 33,
# #                    width: :the_ref
# #                  },
# #                  duration: 800,
# #                  mass: 1,
# #                  damping: 1,
# #                  stiffness: 1000,
# #                  velocity: 1,
# #                  repeat: 1,
# #                  ease: 'spring'
# #                }) do |pa|
# #   puts "animation say#{pa}"
# # end
# # aa.stop(true) do |val|
# #   puts " stop : #{val}"
# # end
# #
# # aa.start(true) do |val|
# #   puts " start : #{val}"
# # end
# #
# # bb.touch(true) do
# #   aa.play(true) do |po|
# #     puts "play say #{po}"
# #   end
# # end
# #
# # aaa = animation({
# #                   # no target for advanced animations control on callback
# #                   begin: {
# #                     left_add: 0,
# #                     top: :self,
# #                     smooth: 0,
# #                     width: 3
# #                   },
# #                   end: {
# #                     left_add: 333,
# #                     top: :self,
# #                     smooth: 33,
# #                     width: :the_ref
# #                   },
# #                   duration: 1800,
# #                   mass: 1,
# #                   damping: 1,
# #                   stiffness: 1000,
# #                   velocity: 1,
# #                   repeat: 1,
# #                   ease: 'spring'
# #                 }) do |pa|
# #   puts "get params to do anything say#{pa}"
# # end
# # wait 7 do
# #   aaa.play(true) do |po|
# #     puts "play aaa say #{po}"
# #   end
# # end
#
# b=box()
# b.color(:red)
# b.color(:cyan)
# b.color(:purple)
# b.shadow(true)
#
# b.shadow({ left: 120 })
# b.add({shadow: :true})
#
# b.add({color: :pink})
# b.add({color: false})
# b.circle({left: 33})
# b.circle({left: 133})
# b.color(:yellow)
#
# puts b.color
#
#
###########################################################@ matrix fix here ###########################################################@
# module Matrix
#   def content(items = nil)
#     if items.instance_of?(Array)
#       items.each do |item|
#         content(item)
#       end
#     elsif items.instance_of?(Atome)
#       w_found = items.particles[:width]
#       h_found = items.particles[:height]
#       l_found = items.particles[:left]
#       t_found = items.particles[:top]
#       i_found = items.particles[:id]
#       current_w_found = width
#       current_h_found = height
#       current_l_found = left
#       current_t_found = top
#       @cell_content ||= {}
#       @cell_content[i_found] = { width_ratio: 1, height_ratio: 1, top_ratio: 1, left_ratio: 1 }
#       # alert @cell_content
#       items.parents([id])
#     else
#       @cell_content
#     end
#   end
#
#   def cells(cell_nb)
#     collector_object = collector({})
#     collected_atomes = []
#     cell_nb.each do |cell_found|
#       atome_found = grab("#{id}_#{cell_found}")
#       collected_atomes << atome_found
#     end
#     collector_object.data(collected_atomes)
#     collector_object
#   end
#
#   def cell(cell_nb)
#     grab("#{id}_#{cell_nb}")
#   end
#
#   def columns(column_requested, &proc)
#     number_of_cells = @columns * @rows
#     column_content = get_column_or_row(number_of_cells, @columns, column_requested, true)
#     cells_found = []
#     column_content.each do |cell_nb|
#       atome_found = grab("#{id}_#{cell_nb}")
#       instance_exec(atome_found, &proc) if proc.is_a?(Proc)
#       cells_found << grab("#{id}_#{cell_nb}")
#     end
#     element({ data: cells_found })
#   end
#
#   def rows(row_requested, &proc)
#     number_of_cells = @columns * @rows
#     column_content = get_column_or_row(number_of_cells, @columns, row_requested, false)
#     cells_found = []
#     column_content.each do |cell_nb|
#       atome_found = grab("#{id}_#{cell_nb}")
#       instance_exec(atome_found, &proc) if proc.is_a?(Proc)
#       cells_found << grab("#{id}_#{cell_nb}")
#     end
#     element({ data: cells_found })
#   end
#
#   # def ratio(val)
#   #   puts "ratio must be : #{val}"
#   #
#   # end
#
#   def fusion(params)
#     number_of_cells = @columns * @rows
#     if params[:columns]
#       @exceptions[:columns_fusion] = params[:columns].merge(@exceptions[:columns_fusion])
#       params[:columns].each do |column_to_alter, value|
#         cell_height = (@matrix_height - @margin * (@rows + 1)) / @rows
#         cells_in_column = get_column_or_row(number_of_cells, @columns, column_to_alter, true)
#         cells_to_alter = cells_in_column[value[0]..value[1]]
#         cells_to_alter.each_with_index do |cell_nb, index|
#           current_cell = grab("#{id.value}_#{cell_nb}")
#           if index.zero?
#             current_cell.height(cell_height * cells_to_alter.length + @margin * (cells_to_alter.length - 1))
#           else
#             current_cell.hide(true)
#           end
#         end
#       end
#     else
#       @exceptions[:rows_fusion] = params[:rows].merge(@exceptions[:rows_fusion])
#       params[:rows].each do |row_to_alter, value|
#         cell_width = (@matrix_width - @margin * (@columns + 1)) / @columns
#         cells_in_column = get_column_or_row(number_of_cells, @columns, row_to_alter, false)
#         cells_to_alter = cells_in_column[value[0]..value[1]]
#
#         cells_to_alter.each_with_index do |cell_nb, index|
#           current_cell = grab("#{id.value}_#{cell_nb}")
#           if index.zero?
#             current_cell.width(cell_width * cells_to_alter.length + @margin * (cells_to_alter.length - 1))
#           else
#             current_cell.hide(true)
#           end
#         end
#       end
#     end
#   end
#
#   def divide(params)
#     number_of_cells = @columns * @rows
#     if params[:columns]
#       params[:columns].each do |column_to_alter, value|
#         cells_in_column = get_column_or_row(number_of_cells, @columns, column_to_alter, true)
#         #  we get the nth first element
#         cells_to_alter = cells_in_column.take(value)
#         cells_in_column.each_with_index do |cell_nb, index|
#           current_cell = grab("#{id.value}_#{cell_nb}")
#           if cells_to_alter.include?(cell_nb)
#             current_cell.height(@matrix_height / value - (@margin + value))
#             current_cell.top(current_cell.height.value * index + @margin * (index + 1))
#           else
#             current_cell.hide(true)
#           end
#         end
#       end
#     else
#       params[:rows].each do |row_to_alter, value|
#         cells_in_row = get_column_or_row(number_of_cells, @columns, row_to_alter, false)
#         #  we get the nth first element
#         cells_to_alter = cells_in_row.take(value)
#         cells_in_row.each_with_index do |cell_nb, index|
#           current_cell = grab("#{id.value}_#{cell_nb}")
#           if cells_to_alter.include?(cell_nb)
#             current_cell.width(@matrix_width / value - @margin - (@margin / value))
#             current_cell.left(current_cell.width.value * index + @margin * (index + 1))
#           else
#             current_cell.hide(true)
#           end
#         end
#       end
#     end
#   end
#
#   # def override(params)
#   #   # TODO : allow fixed height ond fixed width when resizing
#   #   puts "should override to allow fixed height or fixed width when resizing #{params}"
#   # end
#
#   def first(item, &proc)
#     if item[:columns]
#       columns(0, &proc)
#     else
#       rows(0, &proc)
#     end
#   end
#
#   def last(item, &proc)
#     if item[:columns]
#       columns(@columns - 1, &proc)
#     else
#       rows(@rows - 1, &proc)
#     end
#   end
#
#   def format_matrix(matrix_id, matrix_width, matrix_height, nb_of_rows, nb_of_cols, margin, exceptions = {})
#     cell_width = (matrix_width - margin * (nb_of_cols + 1)) / nb_of_cols
#     cell_height = (matrix_height - margin * (nb_of_rows + 1)) / nb_of_rows
#     ratio = cell_height / cell_width
#     i = 0
#     nb_of_rows.times do |row_index|
#       nb_of_cols.times do |col_index|
#         # Calculate the x and y position of the cell
#         x = (col_index + 1) * margin + col_index * cell_width
#         y = (row_index + 1) * margin + row_index * cell_height
#         current_cell = grab("#{matrix_id}_#{i}")
#         # puts "===> #{current_cell}"
#         current_cell.shape.each do |child|
#           # puts "=>#{cell_width}"
#           grab(child).width(cell_width) if grab(child)
#           grab(child).height(cell_width) if grab(child)
#         end
#         current_cell.width = cell_width
#         current_cell.height = cell_height
#         current_cell.left(x)
#         current_cell.top(y)
#         i += 1
#       end
#     end
#
#     # exceptions management
#
#     number_of_cells = nb_of_rows * nb_of_cols
#     # columns exceptions
#     return unless exceptions
#
#     fusion({ columns: exceptions[:columns_fusion] }) if exceptions[:columns_fusion]
#     fusion({ rows: exceptions[:rows_fusion] }) if exceptions[:rows_fusion]
#     divide({ columns: exceptions[:columns_divided] }) if exceptions[:columns_divided]
#     divide({ rows: exceptions[:rows_divided] }) if exceptions[:rows_divided]
#   end
#
#   def apply_style(current_cell, style)
#     current_cell.set(style)
#   end
#   def matrix_sanitizer(params)
#     default_params = {
#
#       id: :my_table, left: 33, top: 33, width: 369, height: 369, smooth: 8, color: :gray,
#       columns: { count: 4 },
#       rows: { count: 4 },
#       cells: { particles: { margin: 9, color: :lightgray, smooth: 9, shadow: { blur: 9, left: 3, top: 3 } }
#       }
#     }
#     default_params.merge(params)
#   end
#   def matrix(params = {}, &bloc)
#     params= matrix_sanitizer(params)
#
#
#     columns_data = if params[:columns]
#                      params.delete(:columns)
#                    else
#                      { count: 4 }
#                    end
#
#     rows_data = if params[:rows]
#                   params.delete(:rows)
#                 else
#                   { count: 4 }
#                 end
#
#     cells_data = if params[:cells]
#                    params.delete(:cells)
#                  else
#                    { particles: { margin: 9, color: :lightgray } }
#                  end
#     cells_color = cells_data[:particles].delete(:color)
#     cells_color_id = color(cells_color).id.value
#
#     cells_shadow = cells_data[:particles].delete(:shadow)
#     cells_shadow_id = shadow(cells_shadow).id.value
#
#     exceptions_data = params.delete(:exceptions)
#     default_renderer = Essentials.default_params[:render_engines]
#     atome_type = :matrix
#     generated_render = params[:renderers] || default_renderer
#     generated_id = params[:id] || identity_generator(:matrix)
#
#     generated_parents = params[:parents] || [id.value]
#     generated_children = params[:shape] || []
#     alert "====>#{params}"
#     params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
#     the_matrix = Atome.new({ atome_type => params }, &bloc)
#
#     # TODO:  use the standard atome creation method (generator.build_atome(:collector)),
#     # TODO suite => For now its impossible to make it draggable because it return the created box not the matrix
#     # get necessary params
#     matrix_id = params[:id]
#     matrix_width = params[:width]
#     matrix_height = params[:height]
#     columns = columns_data[:count]
#     rows = rows_data[:count]
#     margin = cells_data[:particles].delete(:margin)
#     the_matrix.instance_variable_set('@columns', columns)
#     the_matrix.instance_variable_set('@rows', rows)
#     the_matrix.instance_variable_set('@margin', margin)
#     the_matrix.instance_variable_set('@cell_style', cells_data[:particles])
#     the_matrix.instance_variable_set('@matrix_width', matrix_width)
#     the_matrix.instance_variable_set('@matrix_height', matrix_height)
#
#     rows = rows_data[:count]
#     columns = columns_data[:count]
#     # @rows = rows_data[:count]
#     # @columns = columns_data[:count]
#     # @margin = cells_data[:particles].delete(:margin)
#     # @cell_style = cells_data[:particles]
#     # @matrix_width = params[:width]
#     # @matrix_height = params[:height]
#
#     # exceptions reorganisation
#     if exceptions_data
#       columns_exceptions = exceptions_data[:columns] ||= {}
#       columns_fusion_exceptions = columns_exceptions[:fusion] ||= {}
#       columns_divided_exceptions = columns_exceptions[:divided] ||= {}
#       rows_exceptions = exceptions_data[:rows] ||= {}
#       rows_fusion_exceptions = rows_exceptions[:fusion] ||= {}
#       rows_divided_exceptions = rows_exceptions[:divided] ||= {}
#       exceptions = { columns_fusion: columns_fusion_exceptions,
#                      columns_divided: columns_divided_exceptions,
#                      rows_fusion: rows_fusion_exceptions,
#                      rows_divided: rows_divided_exceptions }
#       # @exceptions = {
#       #   columns_fusion: columns_fusion_exceptions,
#       #   columns_divided: columns_divided_exceptions,
#       #   rows_fusion: rows_fusion_exceptions,
#       #   rows_divided: rows_divided_exceptions,
#       # }
#     else
#       exceptions = {
#         columns_fusion: {},
#         columns_divided: {},
#         rows_fusion: {},
#         rows_divided: {}
#       }
#       # @exceptions = {
#       #   columns_fusion: {},
#       #   columns_divided: {},
#       #   rows_fusion: {},
#       #   rows_divided: {},
#       # }
#     end
#     the_matrix.instance_variable_set('@exceptions', exceptions)
#
#     # let's create the matrix background
#     # current_matrix = grab(:view).box({ id: matrix_id })
#     # current_matrix.set(params[:matrix][:particles])
#
#     # cells creation below
#     number_of_cells = rows * columns
#     number_of_cells.times do |index|
#       current_cell = grab(matrix_id).box({ id: "#{matrix_id}_#{index}" })
#       the_matrix.instance_variable_set('@cell_style', cells_data[:particles])
#       current_cell.attached([cells_shadow_id])
#       current_cell.attached([cells_color_id])
#       apply_style(current_cell, cells_data[:particles])
#     end
#     # lets create the columns and rows
#     the_matrix.format_matrix(matrix_id, matrix_width, matrix_height, rows, columns, margin, exceptions)
#     the_matrix
#   end
#
#   def add_columns(nb)
#     prev_nb_of_cells = @columns * @rows
#     nb_of_cells_to_adds = nb * @rows
#     new_nb_of_cells = prev_nb_of_cells + nb_of_cells_to_adds
#     new_nb_of_cells.times do |index|
#       if index < prev_nb_of_cells
#         grab("#{id.value}_#{index}").delete(true)
#         # puts index
#         #
#       end
#       current_cell = box({ id: "#{id}_#{index}" })
#       apply_style(current_cell, @cell_style)
#     end
#     @columns += nb
#     ########## old algo
#     # nb_of_cells_to_adds = nb * @rows
#     # prev_nb_of_cells = @columns * @rows
#     # nb_of_cells_to_adds.times do |index|
#     #   current_cell = self.box({ id: "#{id}_#{prev_nb_of_cells + index}" })
#     #   apply_style(current_cell, @cell_style)
#     # end
#     # @columns = @columns + nb
#     format_matrix(id, @matrix_width, @matrix_height, @rows, @columns, @margin, @exceptions)
#   end
#
#   def add_rows(nb)
#     prev_nb_of_cells = @columns * @rows
#     nb_of_cells_to_adds = nb * @columns
#     new_nb_of_cells = prev_nb_of_cells + nb_of_cells_to_adds
#     new_nb_of_cells.times do |index|
#       if index < prev_nb_of_cells
#         grab("#{id.value}_#{index}").delete(true)
#         # puts index
#         #
#       end
#       current_cell = box({ id: "#{id}_#{index}" })
#       apply_style(current_cell, @cell_style)
#     end
#     @rows += nb
#     ########## old algo
#     # nb_of_cells_to_adds = nb * @columns
#     # prev_nb_of_cells = @columns * @rows
#     # nb_of_cells_to_adds.times do |index|
#     #   current_cell = self.box({ id: "#{id}_#{prev_nb_of_cells + index}" })
#     #   apply_style(current_cell, @cell_style)
#     # end
#     # @rows = @rows + nb
#     format_matrix(id, @matrix_width, @matrix_height, @rows, @columns, @margin, @exceptions)
#   end
#
#   def resize(width, height)
#     @matrix_width = width
#     @matrix_height = height
#     grab(id.value).width(width)
#     grab(id.value).height(height)
#     format_matrix(id, @matrix_width, @matrix_height, @rows, @columns, @margin, @exceptions)
#   end
#
#   def get_column_or_row(length, num_columns, index, is_column)
#     # puts "length: #{length}, #{num_columns} : #{num_columns}, index : #{index}, is_column : #{is_column}"
#     # Compute the number of line
#     num_rows = length / num_columns
#     if is_column
#       result = []
#       (0...num_rows).each do |row|
#         result << (index + row * num_columns)
#       end
#       result
#     else
#       start_index = index * num_columns
#       end_index = start_index + num_columns - 1
#       (start_index..end_index).to_a
#     end
#   end
# end
#
# class Atome
#   include Matrix
# end
#
#
# # class Atome
# #   def matrix(params = {}, &bloc)
# #     default_renderer = Essentials.default_params[:render_engines]
# #     atome_type = :matrix
# #     generated_render = params[:renderers] || default_renderer
# #     generated_id = params[:id] || identity_generator(:matrix)
# #     generated_parents = params[:attach] || [id.value]
# #     params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
# #     # the_matrix = Atome.new({ atome_type => params }, &bloc)
# #     Atome.new({ atome_type => params }, &bloc)
# #   end
# # end
# def matrix(params = {}, &proc)
#   # puts params.class
#   grab(:view).matrix(params, &proc)
# end
#
# # alert style[:rubriques]
# matrix_def={"id"=>"briquettes", "left"=>0, "width"=>300, "height"=>300,  "columns"=>{"count"=>2}, "rows"=>{"count"=>2}, "color"=>{"red"=>0.15, "green"=>0.15, "blue"=>0.15}, "cells"=>{"particles"=>{"margin"=>15, "color"=>{"red"=>0.15, "green"=>0.15, "blue"=>0.15}, "smooth"=>0, "shadow"=>{"blur"=>16, "left"=>3, "top"=>3}}}}
# matrix(matrix_def)
#
# # alert matrix_def.class
# # matrix(matrix_def)
# # matrix(style[:rubriques])