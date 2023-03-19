# # # # # # frozen_string_literal: true

# Done : when sanitizing property must respect the order else no browser
# object will be created, try to make it more flexible allowing any order
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
# TODO : URGENT thes a confusion in the framework between variables and id if the name is the same
# FIXME: touch is unreliable try touch demo some object are not affected

class Object
  # the method missing below is used to create some atome at Object level, EG : text(:hello)
  # We made an exception for the color atome that shouldn't be attach to the view unless specified
  def method_missing(method, *args, &block)
    args.each do |atome_found|
      args.each do |arg|
        # puts "====> the method missing is : #{method}"
        default_parent = Essentials.default_params[method][:attach][0] # we get the first parents
        # puts  "+++++++> #{default_parent}"

        # grab(default_parent).send(element, params, &user_proc)
        # grab(default_parent).send(method, arg, &block)

        # create_method_at_object_level(element)
        atome_found = grab(default_parent).send(method, arg, &block)
        ##### works below
        # if method != :color
        #   atome_found=   grab(:view).send(method, arg, &block)
        # else
        #   atome_found=    grab(:black_matter).send(method, arg, &block)
        # end
        ##### works above
        # we force then return of atome found else its return an hash # TODO : we may find a cleaner solution
        return atome_found
      end
    end
  end
end

# require 'src/medias/rubies/examples/schedule'#
# require 'src/medias/rubies/examples/time'
# require 'src/medias/rubies/examples/code'
# require 'src/medias/rubies/examples/text'
# require 'src/medias/rubies/examples/delete'
# require 'src/medias/rubies/examples/table'
# require 'src/medias/rubies/examples/image'
# require 'src/medias/rubies/examples/video'
# require 'src/medias/rubies/examples/web'
# require 'src/medias/rubies/examples/fullscreen'
# require 'src/medias/rubies/examples/touch'
# require 'src/medias/rubies/examples/create_atome_in_atome'
# require 'src/medias/rubies/examples/color'
# require 'src/medias/rubies/examples/animation'
# require 'src/medias/rubies/examples/drag'
# require 'src/medias/rubies/examples/bottom'
# require 'src/medias/rubies/examples/attached'
# require 'src/medias/rubies/examples/attach'
# require 'src/medias/rubies/examples/markers'
# require 'src/medias/rubies/examples/add'
# require 'src/medias/rubies/examples/read'
# require 'src/medias/rubies/examples/clone'
# require 'src/medias/rubies/examples/atome_new'
# require 'src/medias/rubies/examples/link'
# require 'src/medias/rubies/examples/monitoring'
# require 'src/medias/rubies/examples/detached'
# require 'src/medias/rubies/examples/materials'
# require 'src/medias/rubies/examples/_audio'

############################# # find  test

box({ id: :b1 })
box({ id: :b2, left: 220 })
box({ id: :b3, left: 340 })

new({ atome: :find })
new({ particle: :query, render: false })
new({ particle: :result, render: false })
new({ pre: :query }) do |params|
  result("we must treat : #{params}")
end
new({ particle: :batch, render: false })
new({ sanitizer: :batch }) do |params|
  Batch.new(params)
  # puts "index msg : we must treat the batch : #{params}"

end

# new({ particle: :tag , render: false, type: :hash})

a = grab(:view).find({ query: [:item1, :item2] })
puts "index msg : #{a.query.value}"
puts "index msg : #{a.result.value}"
# TODO : we may remove the collector
# a.collector({id: :batch1, data: [:b1, :b2]})

# puts a.collector.color(:red)
# puts a.collector.poil(:red)

# tag
a.tag({ color: :red })
a.tag({ star: 4 })
a.add({ tag: { value: 4 } })
# puts "index msg : a tag : #{a.tag}"
# puts " index msg : view tag : #{grab(:view).tag}"

# batch

a.batch([:b1, :b2])
puts "----- batch ------"
puts "=> the batch found is #{a}"
# p a.batch.value
a.batch.color(:red).top(0).rotate(33)

a.batch.each do |el|
  el.height(77).blur(9)
end

# find(include: ({color: [:red, :blue], left: 333}))
#
# { equal: { color: [:red, :blue], left: [333] },
#   superior: {top: [333, 22]}
#
# }
# include
# inferior
# different
# imposed