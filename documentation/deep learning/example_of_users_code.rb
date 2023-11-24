# animation example

b=box({id: :the_box})

b.animate(true)


Atome.new( { renderers: [:html], attach: [:view],id: :my_test_box, type: :shape, apply: [:shape_color],
             left: 120, top: 0, width: 100, smooth: 15, height: 100, overflow: :visible, attached: [], center: true
           })


# Here is the attach explanation and example
# the attach method in atome is both a getter and a setter
# attach and attached particles serve the same purpose but just in the opposite direction
# please note that atome.attach([:atome_id]) means that atome will be the parent of the atome with the id :atome_id
# to sum up :  attach and attached are both setter and getter :
# attach will attach the current object to the IDs passed in the params. The current atome will be the child of the the atomes width IDS passed in the the params,
# while attached is the opposite to attached it will attach IDs passed in the params to the current atome. The current atome will be the parent of of the the atomes width IDS passed in the the params

# atome.attach([:atome_id]) means that atome will be the child of the atome with the id :atome_id
# Here is how to use it as a setter :
b = box({ id: :b315, color: :red })
circle({ id: :c_12, top: 0, drag: true, color: :yellow })


c=circle({ id: :c_123, color: :cyan, left: 233, drag: true })
box({ id: :b_1, left: 333, drag: true })
grab(:b_1).attach([:c_123])

bb = box({ top: 99, drag: true })
bb.attach([:b_1])


box({ id: :my_test_box })
wait 1 do
  b.attach([:c_12])
  # Here is how to use it as a getter :
  # to retrieve witch atomes b315 is attached to  to the atome c_12 just type
  puts  b.attach # => [:c_12]
  # to retrieve atome attached to the atome c_12 just type tha other method
  puts  c.attached #=> [:b_1]
end

# Here is the attached explanation and example :

# the attached method in atome is both a getter and a setter
# attach and attached particles serve the same purpose but just in the opposite direction
# please note that atome.attach([:atome_id]) means that atome will be the parent of the atome with the id :atome_id
# to sum up :  attach and attached are both setter and getter :
# attach will attach the current object to the IDs passed in the params. The current atome will be the child of the the atomes width IDS passed in the the params,
# while attached is the opposite to attached it will attach IDs passed in the params to the current atome. The current atome will be the parent of of the the atomes width IDS passed in the the params


# Here is how to use it as a setter :
grab(:black_matter).color({ red: 1, green: 0.6, blue: 0.6, id: :active_color })
grab(:black_matter).color({ red: 0.3, green: 1, blue: 0.3, id: :inactive_color })

b = box({ left: 99, drag: true, id: :the_box })
wait 1 do
  b.apply([:active_color])
end
c = circle({ left: 333, id: :the_circle })
wait 2 do
  c.apply(:inactive_color)
  b.attached([c.id])

  # Here is how to use it as a getter :
  # to retrieve witch atomes b315 is attached to  to the atome c_12 just type
  puts  c.attach # => [:the_box]
  # to retrieve atome attached to the atome c_12 just type tha other method
  puts  b.attached #=> [:the_circle]
end



# The class Universe is used to  retrieve some data needed for the atome framework
# per example you can retrieve the list of all available particles
puts Universe.particle_list
# this give at the date 14/11/2023 :
# or the list of all available atomes
puts Universe.atomes
# this give at the date 14/11/2023 :
# as well as the list of renderer available
puts Universe.renderer_list
# this give at the date 14/11/2023 :

# Universe hold all these instance variable :

# @counter is a integer  that store the total number of atome actually active for the current user on the current machine
# @atomes = is a hash that contains  a list all atomes actually active for the current user on the current machine,
# the key is the atome ID the value is the atome object itself
# atomes_specificities
# @atome_list is a hash that contains all atome's types available
# @particle_list is a hash that contains all particle's types available
# @renderer_list is an array that contains all renderers available
# @specificities indicate to the atome framework witch atomes or particles have specificities, as all atomes and particles methods are define using lot of meta-programming, some atome and particle need special treatment, then we use specificities
# @specificities is a hash where the key is either the atome type or the particle type and the value is a proc that hold the code to be executed when the specified atome is instantiated or the particle is applied onto the atome
# @sanitizers  is a hash where the key is either the atome type or the particle type and the value is a proc holding the code to sanitize user input value before it's the value is interpreted , rendered and stored
# @history is a hash that store the history of all modification of any atome's particle that happen on the current machine for current user.
# the history hash is define as follow: the key is number of the operation  ( 0 is the first modification, 1 the second , and so on... )
# that value of the history hash contain also another hash define as follow: the key is the id of the atome altered and the value is again a new hash with three keys :
# on of the three keys is sync , the sync value hold the sync state of the alteration (sync true means that the alteration is stored and backup on a server), another keys is time, its value hold the time stamp of the alteration
# the third key is the particle altered and value is the new value of the particle
# @users = is a hash that contains all user session on the current machine

# basic usage:
# # we create a basic empty atome
a=Atome.new
# we add a bunch particles
a.renderers([:html])
a.id(:my_shape)
a.type(:shape)
a.width(33)
a.height(33)
a.top(33)
a.left(33)
# we can now add a color the atome using  apply  used to apply an atome onto another (please note that color is also an atome not a particle)
# in this case  we apply the color atome name box_color this a default color created by the system
a.apply([:box_color])
wait 2 do
  # a bit less efficient and a bit more processor intensive solution is to use the box preset, that render a box too
  b=box
  # we can add a color atome onto the new atome my_shape. as stated before for some atome types such as color, shadows ,the relation between the two atomes won't be attach and attached but  apply and affect instead the atome color with the particle red onto the
  b.color(:red)
end



# browse only works with  application version of atome or using server mode , it allow the browse local file on your computer or remote file on server, if operating in server mode

# here is an example :
A.browse('/') do |data|
  text "folder content  :\n #{data}"
end



# here is how callbock is used with atome
test_box = box({left: -20})

test_box.blur(9) do |params_back|
  puts "here is the callback  : #{params_back}"
end
# per example it's possible to set back params like this
test_box.callback({ blur: 'I am the callback content!!' })
# now we call the callback for blur
test_box.call(:blur)

circle({id: :the_c})
# here is a callback with event params
test_box.drag(true) do |event|
  grab(:the_c).left(150+event[:pageX].to_i)
end



# here is how to clear the content of an atome
b=box
c=circle
b.left(0)
c.left(222)
wait 2 do
  # Important : please note that the view is also an atome, this this a system atome that can't be deleted,
  # There are a few system atomes created at init time
  # Here are the list of the system atomes created at system startup:
  #  we can clear it's content using .clear(true) its the same action as if I have done : b.delete(true) and c.delete(true)
  grab(:view).clear(true)
end


# here are the list of system atomes created at system startup :


#Atome.new(
#   { renderers: [], id: :eDen, type: :element, tag: { system: true }, attach: [], attached: [] }
# )
# Atome.new(
#   { renderers: [], id: :user_view, type: :element, tag: { system: true },
# 	attach: [:eDen], attached: [] }
# )
#
# # color creation
# Atome.new(
#   { renderers: default_render, id: :view_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.15, green: 0.15, blue: 0.15, alpha: 1, top: 12, left: 12, diffusion: :linear, attach: [], attached: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :shape_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.4, green: 0.4, blue: 0.4, alpha: 1, attach: [], attached: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :box_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.5, green: 0.5, blue: 0.5, alpha: 1, attach: [], attached: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :invisible_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0, green: 0, blue: 0, alpha: 1, attach: [], attached: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :text_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.9, green: 0.9, blue: 0.9, alpha: 1, attach: [], attached: [] }
# )
#
# Atome.new(
#   { renderers: default_render, id: :circle_color, type: :color, tag: ({ system: true, persistent: true }),
# 	red: 0.6, green: 0.6, blue: 0.6, alpha: 1, attach: [], attached: [] }
# )
#
# # system object creation
# # the black_matter is used to store un materialized atomes
# Atome.new(
#   { renderers: default_render, id: :black_matter, type: :shape, attach: [:user_view],apply: [],
# 	left: 0, right: 0, top: 0, bottom: 0, width: 0, height: 0, overflow: :hidden, tag: { system: true }, attached: []
#   })
#
# # view port
# Atome.new(
#   { renderers: default_render, id: :view, type: :shape, attach: [:user_view], apply: [:view_color],
# 	tag: { system: true },
# 	attached: [], left: 0, right: 0, top: 0, bottom: 0, width: :auto, height: :auto, overflow: :auto,
#   }
#
# )
#
# # unreal port, hold system object and tools
# Atome.new(
#   { renderers: default_render, id: :intuition, type: :shape, attach: [:user_view], tag: { system: true },
# 	left: 0, top: 0, width: 0, height: 0, overflow: :visible, attached: [],apply: []
#   }
# )
#
# machine_id = :dummy_machine
# # attention we must used two separate pass to avoid the password to be encode twice
# machine_password = { read: {atome: :star_wars},write: {atome: :star_wars} }
# user_password = { read: {atome: :star_wars},write: {atome: :star_wars} }
#
# machine({ id: machine_id, password: machine_password, name: :macAir, data: { date: '10090717' }, tag: { system: true } })
#
# human({ id: :anonymous, login: true, password: user_password, data: { birthday: '10/05/1996' }, tag: { system: true } })
#
# # default_user.set_current_user(:anonymous)
# Universe.current_machine = machine_id
# # the constant A is used to access alla atomes methods
# A = Atome.new(
#   { renderers: default_render, id: :atome, type: :element, tag: { system: true }, attach: [], attached: [] }
# )#
#
# # TODO : clones alteration must be bidirectional, to do so :
# # 1 - we may create an atome type 'clone' then add a ' pre_render_clones option' when rendering clones property
# # 2 - this pre_render_clones option, will catch alterations and throw it the the original atome
# # 3 - we also add a new particle call mirror that holds the particle's list that will reverse intrication
#
# b = box({ color: :red, smooth: 6, id: :the_box })
#
# b.clones([{ left: 300, top: 300, color: :blue, entangled: [:width, :attached, :height] },
#           { left: 600, top: 366, color: :green, entangled: [:left, :height] }])
#
# wait 1 do
#   b.width(190)
# end
#
# wait 2 do
#   b.height(180)
# end
#
# wait 3 do
#   b.left(180)
# end
#
# grab(:the_box_clone_0).smooth(33)
# #
# grab(:the_box_clone_1).rotate(33)
#
# wait 5 do
#   b.clones.each do |clone_found|
#     grab(clone_found[:id]).delete(true)
#   end
# end
#


c = circle({ id: :the_circle, left: 12, top: 0, color: :orange, drag: { move: true, inertia: true, lock: :start } })
b = box({ top: 123 })

t = text({ data: :hello, left: 300 })

t.touch(true) do
  alert "#{b.touch} , #{b.touch_code}"
  b.touch_code[:touch].call
end
col = color({ id: :col1, red: 1, blue: 1 })

atomes_monitored = [c, b]
# particles_monitored=[:left, :width, :touch, :apply]
particles_monitored=[:left, :width,  :apply]
# particles_monitored = [:touch]
Atome.monitoring(atomes_monitored, particles_monitored) do |monitor_infos|
  puts "1 ==> #{@id} : #{monitor_infos[:particle]},#{monitor_infos[:altered]}"

  atomes_monitored.each do |atome_to_update|
    # we exclude the current  changing atome to avoid infinite loop
    unless atome_to_update == self || (monitor_infos[:original] == monitor_infos[:altered]) || !monitor_infos[:altered]
      puts "2 ==> #{atome_to_update.id} : #{monitor_infos[:particle]},#{monitor_infos[:altered]}"
      atome_to_update.send(monitor_infos[:particle], monitor_infos[:altered])
    end

  end
end

b.resize(true)
c.resize(true) do |l|

  puts c.instance_variable_get("@resize_code")
end
ccc = color(:red)
wait 1 do
  # b.left(133)
  b.touch(true) do
    alert "b width is #{b.width}"
  end

  c.left(133)
  wait 1 do
    # c.color(:red)
    # c.apply([ccc.id])
    b.width(155)
  end
end

############## add class solution
the_b=box({color: :green})

the_b.resize(true) do
  puts :j
end
class HTML

  def id(id)
    @element[:classList].add(id.to_s)
    attr('id', id)
    self
  end
  def add_class(val)
    @element[:classList].add(val.to_s)
    # @element.setAttribute('id', val)
  end

  def force_top(id,value)
    element=JS.global[:document].getElementById(id.to_s)
    element[:style][:top] ='33px'
  end
end

new({ particle: :add_class }) do |params|
  html.add_class(params)
end

new({ particle: :force_top }) do |params|
  html.force_top(params)
end

b = box({ id: :toto })
bb = box({ id: :toto, left: 333 })
bb.add_class(:toto)
b.add_class(:toto)
bb.force_top(:toto,3)

new({ particle: :run }) do |params, code|
  code_found = @code_code[:code]
  instance_exec(params, &code_found) if code_found.is_a?(Proc)
end
a = box
a.code(:hello) do
  circle({ left: 333 })
end
wait 1 do
  a.run(:hello)
end


col=color({green: 1, id: :the_col})

b=box({top: 3})
t=text(data: :red, left: 0, top: 123)
t1=text(data: :green, left: 100, top: 123)
t2=text(data: :blue, left: 200, top: 123)
t3=text(data: :yellow, left: 300, top: 123)
t4=text(data: :orange, left: 400, top: 123)
t5=text(data: :cyan, left: 500, top: 123)

item_to_batch=[t.id,t1.id,t2.id, t3.id, t4.id, t5.id]
the_group= group({ collected: item_to_batch })
the_group.apply([:the_col])
t.touch(true) do
  b.color({id: :red, red: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t1.touch(true) do
  b.color({id: :green, green: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t2.touch(true) do
  b.color({id: :blue, blue: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t3.touch(true) do
  b.color({id: :yellow,  red: 1, green: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t4.touch(true) do
  b.color({id: :orange,  red: 1, green: 0.5 })
  # puts "number of atomes : #{Universe.atomes.length}"
end
t5.touch(true) do
  b.color({id: :cyan,  blue: 1, green: 1 })
  # puts "number of atomes : #{Universe.atomes.length}"
end

t=text({data: "dynamic color propagation, touch me to propagate"})
t.apply(:the_col)
c=circle({id: :the_circle, top: 260})
c.apply([:the_col])
b.apply([:the_col])

t.touch(true) do
  col.red(1)
end


b = box({ id: :the_html, color: :orange, overflow: :auto, width: :auto, height: :auto, left: 100, right: 100, top: 100, bottom: 100 })
html_desc = <<STR
<!DOCTYPE html>
<html>
    <head>
        <title>Une petite page HTML</title>
        <meta charset="utf-8" />
    </head>
    <body>
        <h1 id='title' style='color: yellowgreen'>Un titre de niveau 1</h1>

        <p>
            Un premier petit paragraphe.
        </p>

        <h2>Un titre de niveau 2</h2>

        <p>
            Un autre paragraphe contenant un lien pour aller
            sur le site <a href="http://koor.fr">KooR.fr</a>.
        </p>
    </body>
</html>
STR

b.hypertext(html_desc)

def markup_analysis(markup) end

def convert(params)
  case
  when params.keys.include?(:atome)

    # Atome.new({type})
    puts params[:atome]
  else
    # ...
  end
end

b.hyperedit(:title) do |tag_desc|
  convert({ atome: tag_desc })
end


b=box
b.left(3)
b.right(3)
b.width(:auto)

b = box()
b.text('click me')

b.touch(true) do
  c = grab(:view).circle({id: :circling, left: 222, color: :orange, blur: 6 })
  c.box({id: :boxing,color: :orange, width: 33, height: 33, left: 123})
  c.box({id: :boxy,color: :red, width: 33, height: 33, left: 333})
  c.text('tap here')
  wait 0.5 do
    c.delete(:left)
    wait 0.5 do
      c.delete(:blur)
    end
  end

  c.touch(true) do
    c.delete({ recursive: true })
  end
end


#############
new({ atome: :generator }) do |params|
  # we remove build and store it in a temporary particle  as it has to be added after atome creation
  build = params.delete(:build)
  params[:temporary] = { build: build }
end
new({ post: :generator }) do |params|
  build_plans = params[:temporary][:build]
  # alert  build_plans
  # grab(params[:id]).build(build_plans)
end

new ({ particle: :build, store: false }) do |params|
  # we get the id or generate it for the new builder
  if params[:id]
    byild_id = params[:id]
  else
    byild_id = "auto_build_#{Universe.atomes.length}"
    params[:id] = byild_id
  end
  # now we create a hash if it doesnt already exist
  # if it exist we feed the hash
  if build
    build[byild_id] = params
  else
    #
    build_hash = { byild_id => params }
    store({ 'build': build_hash })
  end
  #
  # now we'll created the wanted atomes
  # here are the default params
  default_styles = { type: :shape, renderers: [:html], width: 66, height: 66, color: :gray, left: 12, top: 12, copies: 0, attach: [:view] }
  params = default_styles.merge(params)
  color_found = color(params[:color])
  left_pos = params[:left]
  top_pos = params[:top]
  atomes({}) unless atomes

  params[:id] = identity_generator(params[:type]) unless params[:id]
  atomes[params[:id]] = []

  params[:copies].downto(0) do |index|
    item_number = params[:copies] - index
    bundle_id = if params[:id]
                  "#{params[:id]}_#{item_number}"
                else
                  "#{params[:id]}_#{item_number}"
                end
    copied_items_params = params.dup
    copied_items_params[:id] = bundle_id
    # alert copied_items_params
    copy = Atome.new(copied_items_params)
    copy.attach(copied_items_params[:attach])
    copy.apply([color_found.id])
    copy.left(((copy.width + left_pos) * item_number) + left_pos)
    copy.top(((copy.height + top_pos) * item_number) + top_pos)
    atomes[params[:id]] << bundle_id
  end
end


def duplicate(ids)
  ids.each do |id_passed|

    atome_passed=grab(id_passed)
    # atome_passed.particles.delete(:left)
    # we remove attached
    particle_to_remove=[:id, :broadcast, :history,:callback, :html_object, :store_allow,:attached]
    particles_found=atome_passed.particles.dup
    particles_found.delete_if { |key, value| particle_to_remove.include?(key) }
    particles_found[:id]=identity_generator(particles_found[:type])
    collected_particles={}
    particles_found.each  do |particle_found, value_found|
      collected_particles[particle_found]=value_found
    end
    ordered_keys = [:renderers, :id, :type, :attach]
    ordered_particles = ordered_keys.map { |k| [k, collected_particles[k]] }.to_h

    other_part = collected_particles.reject { |k, _| ordered_keys.include?(k) }
    # merge the parts  to obtain an re-ordered hash
    ordered_particles = ordered_particles.merge(other_part)

    # alert ordered_particles
    nw_atome= Atome.new(ordered_particles)

    wait 2 do
      nw_atome.left(333)
    end
  end
end

b=box
c=b.circle
c.text(:hello)
b.touch(true) do
  puts @id
end
b.clones([{ left: 300, top: 300, color: :blue, entangled: [:width, :attached, :height] },
          { left: 600, top: 366, color: :green, entangled: [:left, :height] }])



gen = generator({ id: :genesis, build: {top: 66, copies: 1} })



new({ particle: :display, render: false }) do |params|
  # alert type
  unless params[:items]
    params[:items] = { width: 200, height: 33 }
  end
  container_width = params[:width] ||= width
  container_height = params[:heigth] ||= height
  container_top = params[:top] ||= top
  container_left = params[:left] ||= left

  item_width = params[:items][:width] ||= 400
  item_height = params[:items][:height] ||= 50
  item_margin = params[:margin] ||= 3

  mode = params[:mode]

  case mode
  when :none
  when :custom
  when :list
    if params[:data].instance_of? Array
    elsif params[:data] == :particles
      list_id = "#{id}_list"
      unless grab(list_id)
        container = ''
        attach.each do |parent|
          container = grab(parent).box({ id: list_id, left: container_left, top: container_top, width: container_width, height: container_height, overflow: :auto, color: :black, depth: 0 })
          container.on(:resize) do |event|
            puts event[:dx]
          end
          container.resize({ min: { width: 100, height: 100 }, max: { width: 300, height: 700 } }) do |event|
            puts event
          end

        end
        sorted_particles = particles.sort.to_h
        sorted_particles.each_with_index do |(particle_found, value), index|
          line = container.box({ id: "#{list_id}_#{index}", width: item_width, height: item_height, left: 0, top: ((item_height + item_margin) * index) })
          line.text({ data: "#{particle_found} : ", top: -item_height / 2, left: 2 })
          if value.instance_of?(String) || value.instance_of?(Symbol) || value.instance_of?(Integer)
            input_value = line.text({ data: value, top: -item_height / 2, left: 5, edit: true })
            input_value.keyboard(:down) do |native_event|
              event = Native(native_event)
              if event[:keyCode].to_i == 13
                event.preventDefault()
                input_value.color(:red)
              end
            end
            input_value.keyboard(:up) do |native_event|
              data_found = input_value.data
              send(particle_found, data_found)
            end
          else
            puts "value is :#{value.class} => #{value}"
          end
        end
        closer = container.circle({ id: "#{list_id}_closer", width: 33, height: 33, top: 3, right: 3, color: :red, position: :sticky })
        closer.touch(true) do
          container.delete(true)
        end
      end
    else
    end
  when :grid
    grid_id = "#{id}_grid"
    unless grab(grid_id)
      container = grab(:view).box({ id: grid_id, width: container_width, height: container_height, overflow: :auto, color: :white, depth: 0 })

      container.touch(true) do
        alert "removing container recursively : #{container.id}"
        val_1= Universe.atomes.length
        puts "val_1 : #{val_1}"
        container.delete({ recursive: true })
        val_2= Universe.atomes.length
        puts "val_2 : #{val_2}"
        puts "val_1-val_2 : #{val_1-val_2}"
      end
      ############## deletion
      params[:data].each_with_index do |item, index|
        item = container.box({ id: "#{grid_id}_#{index}", top: 0, position: :relative, left: nil, right: nil })
      end
      # container.html.style('gridTemplateColumns', '1fr 1fr 1fr 1fr 1fr 1fr')
      container.html.style('gridTemplateColumns', 'repeat(4, 1fr)')
      container.html.style('gridTemplateRows', 'auto')
      container.html.style('gridGap', '10px')
      container.html.style('display', 'grid')
      container.on(:resize) do |event|
        puts event[:dx]
      end
      container.resize({ min: { width: 10, height: 10 }, max: { width: 300, height: 700 } }) do |event|
        puts event
      end
    end
  end
end
new({ particle: :visible })
new({ renderer: :html, method: :visible }) do |params|
  if params == false
    params = :none
  elsif params == true
    params = :block
  end
  html.visible(params)
end
new({ particle: :position }) do
end
new({ method: :position, type: :integer, renderer: :html }) do |params|
  html.style(:position, params)
end

b = box({ color: :red })

b.touch(true) do
  # b.display({ mode: :list, data: :particles, width: 333, items: { width: 200, height: 33 }, height: 33, margin: 5 })
  b.display({ mode: :list, data: :particles, items: { width: 200, height: 33 }, height: 33, margin: 5 })
end
############## Builder #############
c = circle({ left: 333 })
fake_array = []
i = 0
while i < 32 do
  fake_array << i
  i += 1
end
c.touch(true) do
  c.display({ mode: :grid, data: fake_array,width: 333, height: 333 })
end

############## Generator #############
gen = generator({ id: :genesis, build: { top: 66, copies: 1 } })
gen.build({ id: :bundler, copies: 32, tag: { group: :to_grid }, color: :red, width: 33, height: 44, left: 123, smooth: 9, blur: 3, attach: [:view] })
grab(:bundler_1).color(:blue)

color({ id: :the_orange, red: 1, green: 0.4 })

atome_to_grid = tagged({ group: :to_grid })
the_group = group({ collected: atome_to_grid })

the_group.touch(true) do |i|
  color(:green)
end
# wait 0.3 do
the_group.left(633)
wait 1 do
  grab(:view).display({ mode: :grid, data: fake_array })
end





#
a=box({width: 666, height: 777, color: :orange})
b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2, depth: 1 })
cc=circle({color: :red, left: 0, top: 0})
clone = ""
b.drag(:start) do
  b.color(:black)
  b.height(123)
  # beware you must use grab(:view) else it'll be attached to the context, that means to 'b' in this case
  clone = grab(:view).circle({ id: "#{b.id}_cloned",color: :white, left: b.left, top: b.top, depth: 3 })
end

b.drag(:stop) do
  b.color(:purple)
  b.height=b.height+100
  clone.delete(true)
end



b.drag(:locked) do |event|
  dx = event[:dx]
  dy = event[:dy]
  x = (clone.left || 0) + dx.to_f
  y = (clone.top || 0) + dy.to_f
  clone.left(x)
  clone.top(y)
end
cc.drag({ restrict: {max:{ left: 240, top: 190}} }) do |event|

end


c=circle

c.drag({ restrict: a.id }) do |event|

end

t=text({data: 'touch me to unbind drag stop for b (clone will not deleted anymore)', left: 250 })
t.touch(true) do
  b.drag({remove: :stop})
end#



dragged = box({ left: 33,top: 333, width: 333,color: :orange, smooth: 6, id: :drop_zone })

dragged.drop(true) do |event|
  grab(event[:destination]).color(:white)
  grab(event[:source]).color(:black)
end

dragged.drop(:enter) do |event|
  grab(event[:destination]).color(:red)
end

dragged.drop(:leave) do |event|
  grab(event[:destination]).color(:gray)
end

dragged.drop(:activate) do |event|
  grab(event[:destination]).color(:yellow)
  grab(event[:source]).color(:cyan)
end


dragged.drop(:deactivate) do |event|
  grab(event[:destination]).color(:orange)
end
box({ left: 333, color: :blue,top: 222, smooth: 6, id: :the_box, drag: true })

t=text({data: 'touch me to unbind drop enter'})
t.touch(true) do
  dragged.drop({ remove: :enter })
end

#

t = text :hello
t.left(99)

t.edit(true)

b=box
b.touch(true) do
  puts t.data
end


my_pass = Black_matter.encode('hello')
puts my_pass
checker = Black_matter.check_password('hello,', my_pass)
puts checker

gen = generator({ id: :genesis, build: {top: 66, copies: 1} })
gen.build({ id: :bundler, copies: 32, color: :red, width: 33, height: 44,  left: 123, smooth: 9, blur: 3, attach: [:view] })
grab(:bundler_1).color(:blue)


the_text = text({ data: 'hello for al the people in front of their machine jhgj  jg jgh jhg  iuuy res ', center: true, top: 120, width: 77, component: { size: 11 } })
the_box = box({ left: 12 })
the_circle = circle({ id: :cc, color: :orange })
the_circle.image('red_planet')
the_circle.color('red')
the_circle.box({ left: 333, id: :the_c })

element({ id: :the_element })
the_view = grab(:view)
puts "views_shape's shape are : #{the_view.shape}"
puts "the_circle color is : #{the_circle.color}"
puts "the_text data is : #{the_text.data}"
puts "the_box left is : #{the_box.left}"
puts "the_circle particles are : #{the_circle.particles}"
#

# the grab method is used to retrieve atome using their ID
a=box({id: :my_box})

# to alter or add a particle you can use the variable, here we set the left value
a.left(33)

# to alter or add a particle you can use the variable
# it's also possible to alter or add a particle without a variable using grab and the ID of the atome , here we set the top value
grab(:my_box).top(55)

circ = circle({ drag: true })
circ.remove({ all: :color })
col_1 = circ.color(:white)
col_2 = circ.color({ red: 1, id: :red_col })
col_4 = circ.color({ blue: 1, id: :red_col2, alpha: 0.3 })
col_5 = circ.color({ red: 0, green: 1, id: :red_col3, alpha: 0.7 })
col_3 = circ.color(:yellow)
wait 0.5 do
  circ.paint({ gradient: [col_1.id, col_2.id], direction: :left })
  wait 0.5 do
    circ.paint({ id: :the_painter, rotate: 69, gradient: [col_1.id, col_2.id] })
    wait 0.5 do
      circ.color(:cyan)
      circ.paint({ gradient: [col_1.id, col_2.id, col_3.id], rotate: 33, diffusion: :conic })
      wait 0.5 do
        painter = circ.paint({ id: :the_painter2, gradient: [col_1.id, col_2.id, col_3.id], direction: :left })
        wait 0.5 do
          circ.color(:blue)
          circ.paint({ gradient: [col_4.id, col_5.id], diffusion: :conic })
        end
      end
    end
  end

end

the_text = text({ data: 'hello for al the people in front of their machine', center: true, top: 222, width: 777, component: { size: 66 } })

the_text.left(333)

the_text.paint({ gradient:  [col_1.id, col_2.id], direction: :left , id: :painted_love })

# #TODO : gradient on text!


text({ id: :the_text,data: 'Touch me to group and colorize', center: true, top: 120, width: 77, component: { size: 11 } })
box({ left: 12, id: :the_first_box })
the_circle = circle({ id: :cc, color: :yellowgreen, top: 222 })
the_circle.image('red_planet')
the_circle.color('red')
the_circle.box({ left: 333, id: :the_c })

element({ id: :the_element })

the_view = grab(:view)

color({ id: :the_orange, red: 1, green: 0.4 })
color({ id: :the_lemon, red: 0, blue: 1 })

the_group = group({ collected: the_view.shape })


wait 0.5 do
  the_group.left(633)
  wait 0.5 do
    the_group.rotate(23)
    wait 0.5 do
      the_group.apply([:the_orange])
      the_group.blur(6)
    end
  end
end
puts the_group.collected
grab(:the_first_box).smooth(9)
grab(:the_text).touch(true) do
  the_group2= group({ collected: [:the_c,:the_first_box, :the_text, :cc ] })
  the_group2.apply([:the_lemon])
end


# grab(:the_text).touch(true) do
# FIXME : on touch code above crash but works with wait


#  here is how to setup a hierarchy within atome using a more simple way than attached and attach .simply adding atome inside another atome. here is a example to do to so : b = box({ id: :the_box })
b=box
# the line below will create a circle inside the box b
c = b.circle({ id: :the_circle })
# we can add any atome inside another atome, below we add a text inside de th box b
t = b.text({ data: :hello, left: 200, id: :the_cirle })
# theres no limit in the depht of atome, we can create an image inside the text, exemple:
t.image({ path: 'medias/images/logos/atome.svg', width: 33 })

# note that creating a hierarchy this way automatically

# Note that when you create a hierarchy in this way, it automatically creates a relationship by populating the 'attach' and 'attached' properties. So, if you enter:


puts "b attach : #{b.attach}" # prints [:view] in the console as it is attached to the view atom
puts "b attached :#{b.attached}" # prints [:the_circle, :the_cirle] in the console

puts "c attach: #{c.attach}" # prints [:the_box] in the console
puts "c attached: #{c.attached}" # prints [:box_14] in the console as there's no child#

b = box({ id: :the_box })
b.data(:canyouwritethis)
b.rotate(33)
b.rotate(88)
b.rotate(99)
b.rotate(12)
b.rotate(6)
b.data
b.touch(true) do
  b.data(:super)
  b.data
  box_data_write_history=b.history({ operation: :write, id: :the_box, particle: :data })
  puts "get data write operation :  #{box_data_write_history}"
  box_data_read_history=b.history({ operation: :read, id: :the_box, particle: :data })
  puts "get data read operation :  #{box_data_read_history}"
end


box_rotate_history=b.history({ operation: :write, id: :the_box, particle: :rotate })
puts "get all all rotate write operation :  #{box_rotate_history}"

# we check if an operation synced (that means saved on atome's server)
puts "first rotate operation state  :  #{box_rotate_history[0]}"

box_data_history=b.history({ operation: :write, id: :the_box, particle: :data })
puts "get data write operation :  #{box_data_history}"



b = box({ id: :the_html, color: :orange, overflow: :auto, width: :auto, height: :auto, left: 100, right: 100, top: 100, bottom: 100 })

html_desc = <<STR
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Com 1 Image</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
        header { display: flex; justify-content: space-between; align-items: center; padding: 20px; }
        nav { display: none; } 
        .section { padding: 50px 20px; text-align: center;z-index: 3  }
        .contact-info { text-align: left; }
        @media (min-width: 768px) {
            nav { display: block; }
        }
    </style>
  <style>
        .ok-info { text-align: left; }
        @media (min-width: 768px) {
            nav { display: block; }
        }
    </style>
</head>
<body>

<header>
    <button>☰</button> <!-- Icône de menu pour mobile -->
    <h1>Com 1 Image</h1>
    <nav>
        <a href="#accueil">Accueil</a>
    </nav>
</header>

<section id='title' class="section my_class" style='left: 333px;color: yellow'>
    <h2>PRODUCTIONS AUDIOVISUELLES</h2>
    <!-- Contenu de la section -->
</section>

<section class="section">
    <h2>COLLABORATIF</h2>
    <p>Texte sur le collaboratif...</p>
</section>

<section class="section">
    <h2>CORPORATE</h2>
    <div class="communication">
        <!-- Images et textes liés à la communication -->
    </div>
    <div class="publicite">
        <!-- Images et textes liés à la publicité -->
    </div>
    <!-- ... Autres contenus de la section Corporate -->
</section>

<section class="section">
    <h2>ART</h2>
    <p>Texte sur l'art...</p>
</section>

<section class="section contact-info">
    <h2>CONTACT</h2>
    <p>email@example.com</p>
    <address>
        74 bis avenue des Thèmes<br>
        63400 - Chamalières
    </address>
</section>

</body>
</html>

STR
b.hypertext(html_desc)


b.hyperedit(:title) do |tag_desc|
  puts tag_desc
end

# TODO : create an html to atome converter

#

image(:red_planet)

image({path: 'medias/images/logos/atome.svg', width: 33})#

t = text :hello
t.left(99)

t.edit(true)

t.keyboard(:press) do |native_event|
  event = Native(native_event)
  puts "press : #{event[:key]} :  #{event[:keyCode]}"
end

t.keyboard(:down) do |native_event|
  event = Native(native_event)
  if event[:keyCode].to_s == '13'
    event.preventDefault()
    t.color(:red)
  end

end

t.keyboard(:up) do |native_event|
  event = Native(native_event)
  puts "up!!"
end

t.keyboard(true) do |native_event|
  event = Native(native_event)
  puts " true => #{event[:keyCode]}"
  puts "true => #{event[:key]}"

end


c = circle({ top: 123, left: 0, width: 55, height: 55 })
c2 = circle({ top: 123, left: 80, width: 55, height: 55 })
c3 = circle({ top: 123, left: 150, width: 55, height: 55 })

c.touch(true) do
  text({ data: 'stop up', top: 150 })
  t.keyboard({ remove: :up })
end
c2.touch(true) do
  text({ data: 'remove all', top: 150 })
  t.keyboard(:remove)
end
c3.touch(true) do
  t.edit(false)
  text({ data: 'stop editing', top: 150 })
end
#

puts "current user: #{Universe.current_user}"
human({ id: :jeezs, login: true })

puts "current user: #{Universe.current_user}"
wait 2 do
  human({ id: :toto, login: true })
  puts "current user: #{Universe.current_user}"
end

# For now markup can only be specified at creation time, it will be possible later
the_one = text({ data: :hello, markup: :h1 })#



box({ color: :red, width: :auto, left: 120, right: 120, id: :box_1 })
circle({ left: 33, top: 200, id: :circle_1 })
circle({ left: 200, top: 200, id: :circle_2 })
circle({ left: 400, top: 200, id: :circle_3 })
circle({ left: 600, top: 200, id: :circle_4 })
text({ data: "resize the window to it's minimum to activate response", id: :my_text })

A.match({condition:{max: {width: 777}, min: {height: 333}, operator: :and }})  do
  {
    circle_1: { color: :red , width: 23},
    circle_2: { color: :orange , width: 23, top: 12},
    box_1: { width: 123, left: 222, color: :blue, rotate: 22}
  }
end

# match can work without any condition then the particles are always applied

# A.match({}) do
#   {
#     circle_1: { color: :red, width: 23 },
#     circle_2: { color: :orange, width: 23, top: 12 },
#     box_1: { width: 123, left: 222, color: :blue, rotate: 22 }
#   }
# end


#
b = box({ color: :red })

b.touch(true) do
  b.connection('localhost:9292') do |params|
    alert " the connection is : #{params}"
  end
end

c = box({ color: :yellow, left: 333 })

c.touch(true) do
  b.message('hi there!!')
  # c = box({ color: :red, left: 333 })
end

b = box({ id: :the_box })
c = circle({ top: 3, id: :the_cirle })
A.monitor({ atomes: [:the_box, :the_cirle], particles: [:left] }) do |atome, particle, value|
  puts "changes : #{atome.id}, #{particle}, #{value}"
end

wait 2 do
  b.left(3)
  wait 2 do
    c.left(444)
  end
end


# please note that whatever the atome resize will return the size of the view!
view = grab(:view)
view.on(:resize) do |event|
  puts "view size is #{event}"
end

text online?#

b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })
b.over(true) do
  b.color(:black)
  # puts "I'm inside"
end
b.over(:enter) do
  puts "in"
  puts "enter"
  b.width= b.width+30
  # alert :in
  b.color(:yellow)
end
b.over(:leave) do
  b.height= b.height+10
  puts "out"
  puts "leave"
  # alert :out
  b.color(:orange)
end

#
t=b.text('touch me to stop over leave')
b.touch(true) do
  b.over({ remove: :enter })
  t.data('finished')
end



c=circle({drag: true, id: :the_circle})

c1=c.color(:white).id
c2=c.color(:red).id
c3=c.color(:yellow).id
color({id: :toto, red: 1 , alpha: 0.5})
wait 0.5 do
  c.paint({ gradient: [c1,c2], direction: :left })
  wait 0.5 do
    c.paint({ gradient: [c1,c2, c3], direction: :left })
    wait 0.5 do
      c.paint({ gradient: [c1,c2], diffusion: :radial })
      wait 0.5 do
        c.paint({ gradient: [c1,c2, c3], diffusion: :conic })
        wait 0.5 do
          c.remove({all: :paint})
        end
      end
    end
  end
end


b = box({ left: 777 })
puts "b ahas the following paticles : #{b.particles}"

bb=box({width: '90%'})
puts bb.to_px(:width)

if Universe.internet
  # v = video({ path: "medias/videos/avengers.mp4", id: :my_video })
  v = video({ path: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4" })
else
  v = video(:video_missing)
end
v.left(200)
v.touch(true) do
  alert v.play
end

t=text({id: :my_text, data: "play video"})

t.touch(true) do
  v.data=0
  v.play(26) do |event|
    t.data("event is : #{event}")
    if event[:frame] ==  900 && v.data <3
      puts v.data
      v.data(v.data+1)
      v.play(26)
    end
  end
end

c=circle({left: 123})

c.touch(true) do
  v.play(:pause)
end

cc=circle({left: 0, width: 55, height: 55})

left=0
cc.drag(:locked) do |event|
  dx = event[:dx]
  left += dx.to_f
  min_left = 0
  max_left = 600
  left = [min_left, left].max
  left = [left, max_left].min
  v.html.currentTime(left/10)
  cc.left(left)
end




puts "add lock x and y when drag"
puts "restrict ro :view doesnt work"


# here how ti use preset in the atome framework
# presets available are : render_engines,image,video,animation,element,box,vector,circle,shape,text,drm,shadow,color,www,raw,code,audio,group,human,machine,paint

my_box=box
# using the code line above a lot of particles will be implicitly created, if we inspect my_box
puts my_box.inspect # this will print :
#[Log] #<Atome: @broadcast={}, @callback={}, @tag={}, @attached=[], @unit={}, @collected={}, @id=:box_14, @type=:shape, @html=#<HTML:0x0662a164 @element=[object HTMLDivElement], @id="box_14", @original_atome=#<Atome: @broadcast={}, @callback={}, @tag={}, @attached=[], @unit={}, @collected={}, @id=:box_14, @type=:shape, @html=#<HTML:0x0662a164 ...>, @attach=[:view], @renderers=[:html], @width=99, @height=99, @apply=[:box_color], @left=100, @top=100, @clones=[], @preset={:box=>{:width=>99, :height=>99, :apply=>[:box_color], :left=>100, :top=>100, :clones=>[]}}>, @element_type="div">, @attach=[:view], @renderers=[:html], @width=99, @height=99, @apply=[:box_color], @left=100, @top=100, @clones=[], @preset={:box=>{:width=>99, :height=>99, :apply=>[:box_color], :left=>100, :top=>100, :clones=>[]}}> (browser.script.iife.min.js, line 13)

# please note that an ID is automatically created using a simple strategy  id : atome_type_total_number_of_users_atomes  ex here :  @id="box_14"

my_box.text("touch me")
puts " my_box preset is : #{my_box.preset}"
# print in the console : [Log]  my_box preset is : {:box=>{:width=>99, :height=>99, :apply=>[:box_color], :left=>100, :top=>100, :clones=>[]}} (browser.script.iife.min.js, line 13)


c=circle
puts  " c is : #{c.inspect }"
# this print : [Log]  c is : #<Atome: @type=:shape, @smooth="100%", @width=99, @id=:circle_16, @renderers=[:html], @height=99, @broadcast={}, @callback={}, @tag={}, @attached=[], @unit={}, @collected={}, @html=#<HTML:0x06579be8 @element=[object HTMLDivElement], @id="circle_16", @original_atome=#<Atome: @type=:shape, @smooth="100%", @width=99, @id=:circle_16, @renderers=[:html], @height=99, @broadcast={}, @callback={}, @tag={}, @attached=[], @unit={}, @collected={}, @html=#<HTML:0x06579be8 ...>, @top=100, @attach=[:view], @left=100, @apply=[:circle_color], @clones=[], @preset={:circle=>{:width=>99, :height=>99, :smooth=>"100%", :apply=>[:circle_color], :left=>100, :top=>100, :clones=>[]}}>, @element_type="div">, @top=100, @attach=[:view], @left=100, @apply=[:circle_color], @clones=[], @preset={:circle=>{:width=>99, :height=>99, :smooth=>"100%", :apply=>[:circle_color], :left=>100, :top=>100, :clones=>[]}}> (browser.script.iife.min.js, line 13)
# it's pôssible to alter basic preset using the particle .preset
my_box.preset({ circle:  {type: :shape, :width=>99, :height=>99, :smooth=>"100%", color: :red, :left=>100, :top=>100, :clones=>[]}})
puts " my_box preset is now : #{my_box.preset}"
# now the preset circle is : [Log]  my_box preset is now : {:circle=>{:type=>:shape, :width=>99, :height=>99, :smooth=>"100%", :color=>:red, :left=>100, :top=>100, :clones=>[]}} (browser.script.iife.min.js, line 13)

my_box.touch(true) do
  my_box.preset(:circle) # the box now rounded like a circle

  new_circle=circle # as the preset circle has been modified tha circle is now red as specified in the updated preset
  puts  "new_circle is : #{new_circle.inspect}"
  # this print : new_circle is : #<Atome: @type=:shape, @smooth="100%", @width=99, @id=:circle_18, @renderers=[:html], @height=99, @broadcast={}, @callback={}, @tag={}, @attached=[], @unit={}, @collected={}, @html=#<HTML:0x0664e99c @element=[object HTMLDivElement], @id="circle_18", @original_atome=#<Atome: @type=:shape, @smooth="100%", @width=99, @id=:circle_18, @renderers=[:html], @height=99, @broadcast={}, @callback={}, @tag={}, @attached=[], @unit={}, @collected={}, @html=#<HTML:0x0664e99c ...>, @top=100, @attach=[:box_14], @left=100, @apply=[:circle_18_color_1_0_0_0_0_0____], @clones=[]>, @element_type="div">, @top=100, @attach=[:box_14], @left=100, @apply=[:circle_18_color_1_0_0_0_0_0____], @clones=[]>
end
#

raw_data = <<STR
<iframe width="560" height="315" src="https://www.youtube.com/embed/8BT4Q3UtO6Q?si=WI8RlryV8HW9Y0nz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
STR


raw_data = <<STR
<svg width="600" height="350" xmlns="http://www.w3.org/2000/svg">
<!-- Style for the boxes -->
                         <style>
.box { fill: white; stroke: black; stroke-width: 2; }
   .original { fill: lightblue; }
   .clone { fill: lightgreen; }
   .arrow { stroke: black; stroke-width: 2; marker-end: url(#arrowhead); }
                                                          .text { font-family: Arial, sans-serif; font-size: 14px; }
   </style>

  <!-- Arrowhead definition -->
  <defs>
    <marker id="arrowhead" markerWidth="10" markerHeight="7" 
    refX="0" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="black"/>
     </marker>
  </defs>

   <!-- Boxes for original and clones -->
                                      <rect x="250" y="30" width="100" height="50" class="box original"/>
   <rect x="100" y="200" width="100" height="50" class="box clone"/>
   <rect x="250" y="200" width="100" height="50" class="box clone"/>
   <rect x="400" y="200" width="100" height="50" class="box clone"/>

   <!-- Text for boxes -->
                       <text x="275" y="55" class="text" text-anchor="middle">Original</text>
  <text x="150" y="225" class="text" text-anchor="middle">Clone 1</text>
   <text x="300" y="225" class="text" text-anchor="middle">Clone 2</text>
  <text x="450" y="225" class="text" text-anchor="middle">Clone 3</text>

   <!-- Arrows -->
   <line x1="300" y1="80" x2="150" y2="200" class="arrow"/>
   <line x1="300" y1="80" x2="300" y2="200" class="arrow"/>
   <line x1="300" y1="80" x2="450" y2="200" class="arrow"/>
   </svg>
STR


raw({ id: :the_raw_stuff, data: raw_data })

A.read('Cargo.toml') do |data|
  text "file content  :\n #{data}"
end



b = box({ top: 166, data: :hello })
c=color({ id: :col1, red: 1, blue: 1})

b.instance_variable_set("@top", 30)
b.instance_variable_set("@apply", [c.id])
b.instance_variable_set("@path", './medias/images/red_planet.png' )

b.instance_variable_set("@smooth", 30)
wait 1 do
  b.refresh
  b.instance_variable_set("@left", 300)
  wait 1 do
    b.refresh
    b.instance_variable_set("@type", :text)
    wait 1 do
      b.refresh
      b.instance_variable_set("@type", :image)
      wait 1 do
        b.refresh
      end
    end
  end
end


b = box({ top: 166 , id: :the_box})
b.color({id: :new_col, red: 1})
b.color({id: :other_col,  green: 1})
# b.paint({gradient: [:other_col, :new_col]})
color({id: :last_col,  green: 0.3, blue: 0.5})
color({id: :last_col2,  red: 1, blue: 0.5})

b.shadow({
           id: :s1,
           # affect: [:the_circle],
           left: 9, top: 3, blur: 9,
           invert: false,
           red: 0, green: 0, blue: 0, alpha: 1
         })
wait 1 do
  b.remove(:other_col)
  wait 1 do
    b.remove(:new_col)
    wait 1 do
      b.remove(:box_color)
      wait 1 do
        b.apply(:last_col)
        wait 1 do
          b.apply(:last_col2)
        end
      end
    end
  end
end
b.touch(true) do
  puts "before => #{b.apply}"
  b.remove({all: :color})
  puts "after => #{b.apply}"
  wait 2 do
    b.paint({id: :the_gradient_1,gradient: [:box_color, :circle_color]})
    b.paint({id: :the_gradient,gradient: [:other_col, :new_col]})
    wait 1 do
      b.remove(:the_gradient)
      wait 1 do
        b.remove(all: :shadow)
      end
    end
  end
end



m = shape({ id: :the_shape, width: 333, left: 130, top: 30, right: 100, height: 399, smooth: 8, color: :yellowgreen, })
m.drag(true)
m.on(:resize) do |event|
  puts event[:dx]
end

m.resize({ size: { min: { width: 10, height: 10 }, max: { width: 300, height: 600 } } }) do |event|
  puts "width is  is #{event[:rect][:width]}"
end

t=text({data: ' click me to unbind resize'})
t.touch(true) do
  t.data('resize unbinded')
  m.resize(:remove)
end

b = box({ id: :the_container, width: 300, height: 300 })
b.box({top: 500, color: :red})
cc=b.circle({ top: 160, id: :the_circle })

initial_height=cc.height
b.overflow(:scroll) do |event|
  new_height = initial_height + event[:top]
  cc.height(new_height)
end#


c=circle({left: 220})
t=text({left: 550,data: :hello,password: { read: {atome: :my_secret} }})
b = box({ id: :the_box, left: 66,smooth: 1.789,
          password: {
            read: {
              atome: :the_pass,
              smooth: :read_pass
            },
            write: {
              atome: :the_write_pass,
              smooth: :write_pass
            }
          }
        })



b.authorise({ read: {atome: :the_pass,smooth: :read_pass }, write: {smooth: :write_pass}, destroy: true}  )
puts b.smooth
# next will be rejected because destroy: true
puts b.smooth
#
b.authorise({ read: {atome: :wrong_pass,smooth: :no_read_pass }, write: {smooth: :wrong_write_pass}, destroy: false}  )
puts 'will send the wrong password'
puts b.smooth

b.authorise({ read: {atome: :wrong_pass,smooth: :read_pass }, write: {smooth: :wrong_write_pass}, destroy: false}  )
puts "'with send the right password it'll works"
puts b.smooth
# authorise has two params the first is the password to authorise the second is used to destroy the password or keep for
# further alteration of the particle
wait 1 do
  b.authorise({write: {smooth: :write_pass}, destroy: true} )
  b.smooth(22)
  wait 1 do
    b.smooth(12)
    wait 1 do
      b.authorise({write: {smooth: :write_pass}, destroy: false} )
      b.smooth(66)
      wait 1 do
        b.authorise({write: {smooth: :false_pass, atome: :no_apss, destroy: true}} )
        b.smooth(6)
      end
    end
  end
end


c = circle({ id: :the_circle, left: 122, color: :orange, drag: { move: true, inertia: true, lock: :start } })
c.color({ id: :col1, red: 1, blue: 1 })

c.shadow({
           id: :s1,
           # affect: [:the_circle],
           left: 9, top: 3, blur: 9,
           invert: false,
           red: 0, green: 0, blue: 0, alpha: 1
         })

shadow({
         id: :s2,
         affect: [:the_circle],
         left: 3, top: 9, blur: 9,
         invert: true,
         red: 0, green: 0, blue: 0, alpha: 1
       })

c.shadow({
           id: :s4,
           left: 20, top: 0, blur: 9,
           option: :natural,
           red: 0, green: 1, blue: 0, alpha: 1
         })

wait 2 do
  c.remove(:s4)
  wait 2 do
    c.remove({ all: :shadow })
  end
end


the_text = text({ data: 'hello for al the people in front of their machine', center: true, top: 222, width: 777, component: { size: 66 } })



the_text.shadow({
                  id: :s4,
                  left: 20, top: 0, blur: 9,
                  option: :natural,
                  red: 0, green: 1, blue: 0, alpha: 1
                })

shape(
  { renderers: [:html], id: :my_test_box, type: :shape, apply: [:shape_color],
    left: 120, top: 0, width: 100, smooth: 15, height: 100, overflow: :visible, attached: [], center: true
  })


b = box({ width: 333, left: 333 })
b.smooth(9)

wait 2 do
  b.smooth([33, 2, 90])
end


b = box

b.style({ left: 33, width: 44, rotate: 23, color: :yellowgreen, blur: 44 })#
b = box({ id: :the_box })
b.data(:canyouwritethis)
b.rotate(33)
b.rotate(88)
b.rotate(99)
b.rotate(12)
b.rotate(6)
b.data
b.touch(true) do
  b.data(:super)
  b.data
  # operation has two option write or read, it filter the history on those two options,  write retrieve all alteration
  # of the particle , read list everytime a particle was get
  # id retrieve all operation on a given ID
  # particle retrieve all operation on a given particle
  # alert b.retrieve({ operation: :write, id: :the_box, particle: :data })
end


# alert b.instance_variable_get('@history')
box_rotate_history=b.history({ operation: :write, id: :the_box, particle: :rotate })
puts "get all all rotate write operation :  #{box_rotate_history}"
first_rotate_operation_state=b.history({ operation: :write, id: :the_box, particle: :rotate })[0][:sync]

# we check if an operation synced (that means saved on atome's server)
puts "first rotate operation state  :  #{box_rotate_history[0]}"

# we check if an operation synced (that means saved on atome's server)
puts "first rotate operation initial state  :  #{box_rotate_history[0]}"
puts "synced  :  #{first_rotate_operation_state}"
first_rotate_operation_number=b.history({ operation: :write, id: :the_box, particle: :rotate })[0][:operation]
puts "first rotate 'write' operation number is:  #{first_rotate_operation_number}"

# now we sync the state
Universe.synchronised(first_rotate_operation_number, :star_wars)
# now we check if it's synced
box_rotate_history=b.history({ operation: :write, id: :the_box, particle: :rotate })
puts "new state for first rotate operation : #{box_rotate_history[0]}"


b=box
b.circle({left: 0, top: 0, tag: {group: :to_grid}})
b.box({left: 120, top: 120, tag: {group: :from_grid}})
b.circle({left: 240, top: 240,  tag: {group: :from_grid}})
b.box({left: 330, top: 330,tag: {group: :to_grid}})
b.box({left: 330, top: 600,tag: :no_tag})


wait 1 do
  tagged(:group).each do |atome_id|
    grab(atome_id).color(:green)
    wait 1 do
      tagged({group: :to_grid }).each do |atome_id|
        grab(atome_id).color(:blue)
      end
    end
  end
end


#
#
#
A.terminal('pwd') do |data|
  text "terminal response  :\n #{data}"
end

  t2 = text({ data: ['this is ', :super, { data: 'cool', color: :red, id: :new_one }], component: { size: 33 }, left: 120 })
  the_text = text({  data: 'hello for al the people in front of their machine', center: true, top: 120, width: 77, component: { size: 11 } })

  #

  b = box({ left: 666, color: :blue, smooth: 6, id: :the_box2 })

  t=text({id: :the_text, data: 'type of touch : ?'})

#   t.touch(:down) do
#     b.touch({remove: :down})
#     # b.touch(:remove) # or  b.touch(false) to remove all touches bindings
#     t.data('touch down killed')
#   end
#   b.touch(true) do
#     # t.data('type of touch : ?')
#     b.color(:red)
#     puts 'box tapped'
#   end
#
#   b.touch(:long) do
#     t.data('type of touch is : long ')
#     b.color(:black)
#   end
#
#   b.touch(:up) do
#
#     t.data('type of touch is : up ')
#     b.color(:orange)
#   end
#
#   b.touch(:down) do
#     t.data('type of touch is : down ')
#     b.color(:white)
#   end
#
#   b.touch(:double) do
#     t.color(:red)
#     t.data('type of touch is : double ')
#     b.color(:yellowgreen)
#   end
#
#
#   b = box({ top: 166, data: :hello,path: './medias/images/red_planet.png'  })
#   b.color({ id: :col1, red: 1, blue: 1})
#
#
#   wait 1 do
#     b.type=:text
#     b.refresh
#     wait 1 do
#       b.type=:image
#       b.refresh
#     end
#   end
#
#   puts "atomes : #{Universe.atomes}"
#   puts "user_atomes : #{Universe.user_atomes}"
#   puts "particle_list : #{Universe.particle_list}"
#   puts "users : #{Universe.users}"
#   puts "current_machine : #{Universe.current_machine}"
#   puts "internet connected : #{Universe.internet}"#
#
#   edition = "M257.7 752c2 0 4-0.2 6-0.5L431.9 722c2-0.4 3.9-1.3 5.3-2.8l423.9-423.9c3.9-3.9 3.9-10.2 0-14.1L694.9 114.9c-1.9-1.9-4.4-2.9-7.1-2.9s-5.2 1-7.1 2.9L256.8 538.8c-1.5 1.5-2.4 3.3-2.8 5.3l-29.5 168.2c-1.9 11.1 1.5 21.9 9.4 29.8 6.6 6.4 14.9 9.9 23.8 9.9z m67.4-174.4L687.8 215l73.3 73.3-362.7 362.6-88.9 15.7 15.6-89zM880 836H144c-17.7 0-32 14.3-32 32v36c0 4.4 3.6 8 8 8h784c4.4 0 8-3.6 8-8v-36c0-17.7-14.3-32-32-32z"
#
#   v = vector({ data: { path: { d: edition, id: :p1, stroke: :black, 'stroke-width' => 37, fill: :red } } })
#
#   wait 1 do
#     v.data(circle: { cx: 1000, cy: 1000, r: 340, id: :p2, stroke: :green, 'stroke-width' => 35, fill: :yellow })
#     wait 1 do
#       v.color(:cyan) # colorise everything with the color method
#       wait 1 do
#         v.shadow({
#                    id: :s4,
#                    left: 20, top: 0, blur: 9,
#                    option: :natural,
#                    red: 0, green: 1, blue: 0, alpha: 1
#                  })
#         v.component(p2: {fill: :blue,'stroke-width' => 166 })
#         v.left(222)
#       end
#     end
#   end
#
#   if Universe.internet
#     v = video({ path: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4" })
#   else
#     v = video(:video_missing)
#   end
#
#   v.touch(true) do
#     v.play(true)
#     wait 3 do
#       v.play(66)
#     end
#   end# #
#   b = box
#
#   wait 2 do
#     b.color(:red)
#   end#
#
#   b = box
#
#   b.www({ path: "https://www.youtube.com/embed/usQDazZKWAk", left: 333 })
#
#   Atome.new(
#     renderers: [:html], id: :youtube1, type: :www, attach: [:view], path: "https://www.youtube.com/embed/fjJOyfQCMvc?si=lPTz18xXqIfd_3Ql", left: 33, top: 33, width: 199, height: 199,
#
#     )