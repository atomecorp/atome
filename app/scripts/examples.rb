require './app/scripts/background.rb'

def clear_help (topic, code)
  #grab(:view).clear({target: :view, exclude: :help_container})

  #Atome.clear(:view)


  ######## test #############
  atomes_found = grab(:view).child

  #child_list=[]
  #get(:view).child.each do |child_found|
  #  child_list << child_found.id
  #end
  #alert "message is \n\n#{find({scope: :view,format: :id})} \n#{child_list}\nLocation: examples.rb, line 15"

  #alert "message is \n\n#{child_list} \n\nLocation: examples.rb, line 15"
  get(:view).child.each do |child_found|
    if child_found && child_found.id == :view || child_found.nil?
      #alert "message is \n\n#{"big couille dans le potage"} \n\nLocation: examples.rb, line 8"
    else
      child_found.delete(true)
    end

  end
  #if topic
  #  #Atome.clear(:view)
  #  #help
  #  #Help.puts_help(topic, code.content)
  #else
  #  #Atome.clear(:view)
  #  #help
  #  #   clear({target: :view, exclude: :help_container})
  #end
end


def examples
  #we load te parser dynamically on request
  help_container = box()
  grab(:intuition).insert(help_container)
  help_container.id(:help_container)
  help_container.height(:auto)
  help_container.top(0)
  help_container.bottom(0)
  help_container.right(0)
  help_container.width(200)
  help_container.color('rgb(33,33,33)')
  help_container.overflow(:auto)
  help_container.shadow(true)
  help_container.center(false)
  methods = Help.instance_methods(true)
  methods.delete(:puts_help)
  methods = methods.sort
  methods.each_with_index do |helper, index|
    topic = help_container.text(helper.sub('_api', ''))
    topic.id('menu_item_' + index.to_s)
    topic.size(16)
    topic.left(7)
    topic.color(:gray)
    topic.y = (20 * index) + 7
    topic.touch do
      @code = ''
      if !Opal_utils.opal_parser_ready
        Opal_utils.load_opal_parser
        clear_help(false, false)
        # wait until $opal_parser is loaded
        e = every 0.2, 0 do
          if $opal_parser
            stop(e)
            help = Helper.new()
            help.send(helper)
          end
        end
      else
        clear_help(false, false)
        help = Helper.new()
        help.send(helper)
      end
    end
  end
end

module Help
  def puts_help topic, demo_code
    @code = demo_code
    eval demo_code
    code_content = text('')
    code_content.id(:code_content)
    demo_title = box()
    demo_title.shadow(true)
    demo_title.x(300)
    demo_title.height = 34
    demo_title.width = 333
    demo_title.x(7)
    demo_title.y(7)
    demo_title.smooth(7)
    demo_title.color('rgb(33,33,33)')
    demo_title.touch do
      unless get(:demo_code)
        run_code = box()
        run_code.color(:yellowgreen)
        run_code.id = :run_code
        run_code.size(25)
        run_code.z(3)
        run_code.x(7)
        run_code.y(45)
        run_code.smooth(7)
        code = if @code == ''
                 code_content.content(demo_code)
               else
                 code_content.content(@code)
               end
        code.edit(true)
        code.color(:yellowgreen)
        code.id = :demo_code
        code.size(16)
        code.z(3)
        code.x(7)
        code.y(77)

        run_code.touch do
          puts "we must erase the scene before"
          eval code.content
        end
      end
    end
    title = text(topic)
    demo_title.insert(title)
    title.x(7)
    title.y(0)
    title.color(:lightgray)
  end

  def gradient
    demo_code = <<strdelim
grad = circle
grad.x(350)
grad.y(350)
grad.size = 223
wait 1 do
  grad.color([{content: :red}, :yellow, {color: :orange}, {angle: 150}, {diffusion: :radial}])
end
wait 3 do
  grad.color([{content: :cyan}, :green, :blue])
end
wait 5 do
  grad.color([{content: :orange}, :green, :blue, {angle: 150, diffusion: :linear}])
end
grad.touch do 
puts grad.inspect
end
strdelim
    self.puts_help :gradient, demo_code
  end

  def version
    demo_code = <<strdelim
t=text(Atome.version)
t.center(true)
t.y(70)
strdelim
    self.puts_help :smooth, demo_code
  end

  def add_touch
    demo_code = <<strdelim
b=box()
b.drag(true)
b.touch(option: :down) do
b.color(:orange)
end
c=circle()
c.y=50
c.drag(true)
c.touch(option: :up, add: true) do
c.color(:orange)
end

strdelim
    self.puts_help :smooth, demo_code
  end


  def border
    demo_code = <<strdelim
b=box()
b.x(250)
b.border({thickness: 3, pattern: :dashed})
strdelim
    self.puts_help :smooth, demo_code
  end


  def smooth
    demo_code = <<strdelim
b=box()
b.x(250)
b.smooth([25 ,7])
strdelim
    self.puts_help :smooth, demo_code
  end

  def shadow
    demo_code = <<strdelim
b = box({id: :box_test})
b.shadow({x: 5, y: 5, blur: 7, color: :black, invert: :true})
b.shadow({add: :true, x: 20, y: 20, color: "rgba(0,0,0,1)", blur: 16})
c=circle({x: -30 , y: -30, drag: true, id: :circle_test})
c.shadow({x: -5, y: -5, blur: 7, color: :black, invert: :true})
c.shadow({add: :true,x: 0, y: 0, color: "rgba(0,0,0,1)", blur: 16})
b.drag(true)
b.insert(c)
b.x(500)
b.y(200)
b.color(:orange)
strdelim
    self.puts_help :shadow, demo_code
  end

  def edit
    demo_code = <<strdelim
t=text(" you can type your text here")
t.color(:lightgray)
t.center(:true)
t.edit(true)
strdelim
    self.puts_help :edit, demo_code
  end

  def keypress
    demo_code = <<strdelim
b=box()
info=text("keypress nb")
info.y(50)
info.color(:gray)
t=b.text("press a key!")
t.x(3)
t.y(4)
t.edit(:true)
b.key do |evt|
  info.content(evt.key_code) 
end
strdelim
    self.puts_help :edit, demo_code
  end

  def eval_api
    demo_code = <<strdelim
eval("box(x: 7)")
begin
  eval 'x = {id: 1'
rescue SyntaxError 
  t=text("eval catch the error : 'x = {id: 1'")
t.color(:red)
end
strdelim
    self.puts_help :eval, demo_code
  end

  def read_code_from_file_api
    demo_code = <<strdelim
#read("test", "run","text")
read("./medias/rubies/test", :run,:ruby)
strdelim
    self.puts_help :eval, demo_code
  end

  def select_api
    demo_code = <<strdelim
b = box(x: 300)
b.touch do
  if b.select
    b.select(false)
  else
    b.select(true)
  end
end
t = text(:hello)
t.touch do
  if t.select
    t.select(false)
  else
    t.select(true)
  end
end
strdelim
    self.puts_help :select, demo_code
  end

  def find_atome_from_params_api
    demo_code = <<strdelim
#assume to find an object based on id atome_id or th object itself
b=box()
wait 1 do
  b.find_atome_from_params(b.atome_id).color(:green)
end
wait 2 do
  b.find_atome_from_params(b.id).color(:yellow)
end
wait 3 do
  b.find_atome_from_params(b).color(:blue)
end
strdelim
    self.puts_help :find_atome_from_params_api, demo_code
  end

  def drag
    demo_code = <<strdelim
b=box()
b.drag(true)
b.x(380)
c=circle({x: 250})
c.width=150
t=c.text(:event)
t.size(16)
t.center(true)
c.drag do |evt|
t.content("x: "+(evt.page_x).to_s+"\n""y: "+(evt.page_y).to_s)
end
t.x(33)
strdelim
    self.puts_help :drag, demo_code
  end

  def id
    demo_code = <<strdelim
b=box()
b.y(120)
b.x(250)
b.id(:my_box)
t=text("the box's id is "+b.id)
t.color(:orange)
t.x 250
strdelim
    self.puts_help :id, demo_code
  end

  def monitor_all_prop_on_single_atome
    demo_code = <<strdelim
m = text "touch me"
m.y = 10

t = text("monitor")
t.color(:orange)
t.size(12)
t.y = 50
m.x(500)
t.x(500)
c = circle()
c.x(200)
b = box
b.x(330)
c.y(150)
b.y(200)
m.touch do
  t.content("")
  b.color(:green)
  b.x(500)
  c.color(:blue)
  c.x(250)
end
c.drag(true)
b.drag(true)

b.monitor({ property: :all, reset: true}) do |evt|
  t.content(t.content+"monitoring any color changes on any object : " +  evt.to_s+"\n")
end
strdelim
    self.puts_help :monitor_all_prop_on_single_atome, demo_code
  end

  def monitor_everything
    demo_code = <<strdelim
m = text "touch me"
m.y = 10
t = text("open console, can't write here or we create an infinite loop!!")
t.color(:orange)
t.y = 50
m.x(500)
t.x(500)
c = circle()
c.x(200)
b = box
b.x(330)
c.y(150)
b.y(200)
m.touch do
  t.content("")
  b.color(:green)
  b.x(500)
  c.color(:blue)
  c.x(250)
end
c.drag(true)
b.drag(true)

m.monitor({atome: :all, property: :all, reset: true}) do |evt|
  puts "atome_id = " + evt[0].to_s + " : prop =" + evt[1].to_s
end
strdelim
    self.puts_help :monitor_everything, demo_code
  end

  def monitor_single_atome_on_single_prop
    demo_code = <<strdelim
m = text "touch me"
m.y = 10
t = text("monitor")
t.color(:orange)
t.size(12)
t.y = 50
m.x(500)
t.x(500)
c = circle()
c.x(200)
b = box
b.x(330)
c.y(150)
b.y(200)
m.touch do
  t.content("")
  b.color(:green)
  b.x(500)
  c.color(:blue)
  c.x(250)
end
c.drag(true)
b.drag(true)
m.monitor({atome: b, property: :color, reset: true}) do |evt|
  t.content("monitoring the box color, any other are changes are ignore\nthe box just updated its color to : " + evt.to_s)
end
strdelim
    self.puts_help :monitor_single_atome_on_single_prop, demo_code
  end

  def monitor_single_property_on_all_atome
    demo_code = <<strdelim
m = text "touch me"
m.y = 10
t = text("monitor")
t.color(:orange)
t.size(12)
t.y = 50
m.x(500)
t.x(500)
c = circle()
c.x(200)
b = box
b.x(330)
c.y(150)
b.y(200)
m.touch do
  t.content("")
  b.color(:green)
  b.x(500)
  c.color(:blue)
  c.x(250)
end
c.drag(true)
b.drag(true)

t.monitor({atome: :all, property: :color, reset: true}) do |evt|
  t.content(t.content+"monitoring any color changes on any object : " +  evt[0].to_s + " : prop =" + evt[1].to_s+"\n")
end
strdelim
    self.puts_help :monitor_single_property_on_all_atome, demo_code
  end


  def grab_a_id
    demo_code = <<strdelim
b=box()
b.x(450)
t=text("the box's atome_id is "+b.atome_id)
t.color(:orange)
t.x(350)
t.y(190)
strdelim
    self.puts_help :grab_a_id, demo_code
  end

  def get_api
    demo_code = <<strdelim
b=box({id: :my_box})
get(:my_box).color(:red)
get(:my_box).x 250
strdelim
    self.puts_help :get, demo_code
  end

  def get_by_property
    demo_code = <<strdelim
b = box()
b.y(200)
b.color(:orange)
circle(x:300)
te = text('kool!!')
te.shadow({color: :black, blur: 2})
te.y(250)
te.color(:orange)
t = text("touch me to get all object colored in orange")
t.color(:red)
t.y = 150
t.x = 350
t.touch do
  getted_files = get(color: :orange)
  list_of_orange_atome=[]
  getted_files.each do|match|
    list_of_orange_atome << match.atome_id
    end
  t.content(list_of_orange_atome)
end
strdelim
    self.puts_help :get_by_property, demo_code
  end

  def set_api
    demo_code = <<strdelim
b=box()
b.set({color: :red, x: 200, smooth: 7, width: 500, y: 150, shadow: true})
strdelim
    self.puts_help :set, demo_code
  end

  def content_api
    demo_code = <<strdelim
i=image('atome')
i.x(450)
t=text({content: "hello", color: :lightgray, size: 43})
t.x(550)
t.y(160)
wait 2 do
i.content(:boat)
t.content(t.content+ " folks!")
end
strdelim
    self.puts_help :content, demo_code
  end

  def size_api
    demo_code = <<strdelim
#size keep geometry ratio
i=image('atome')
i.x(350)
i.y(250)
t=text("hello")
t.x(350)
t.y(200)
i.y(300)
wait 2 do
i.size(50)
t.size(80)
end
strdelim
    self.puts_help :size_api, demo_code
  end

  def wait_api
    demo_code = <<strdelim
b=box()
b.x(300)
wait 2 do
b.color(:red)
b.width(200)
end
strdelim
    self.puts_help :wait_api, demo_code
  end

  def every_api
    demo_code = <<strdelim
b=box()
b.smooth(16)
b.x=350
b.overflow(:hidden)
i=0
nb_of_repeat=25
t=b.text("nb of repeat : "+nb_of_repeat.to_s)
t.color(:gray)
m=every 0.2, nb_of_repeat do
  b.width=b.width+5
  t.content("nb of repeat : "+(nb_of_repeat-i-1).to_s)
  if nb_of_repeat-i-1==6
    stop(m)
    t.content("stop by condition!!!")
    t.color(:black)
    t.size(16)
    t.width(200)
  end
  i+=1
end
t.size(12)
t.x(7)
t.y(25)

strdelim
    self.puts_help :every_api, demo_code
  end

  def anim_api
    demo_code = <<strdelim
b=box()
b.y(300)
b.x(400)
text({content: "touch the box!!", x: 450, y: 250, size: 16, color: :lightgray})

b.touch do
  anim({
             start: { smooth: 0, blur: 0,  rotate: 0, color: "rgb(255,255,255)"},
             end: { smooth: 25, rotate: 180, blur: 20, color: "rgb(255,10,10)"},
             duration: 1000,
             loop: 1,
             curve: :easing,
             target: b.id
         })
end
  anim({
             start: {x: 0, y: 0, smooth: 0, rotate: 20},
             end: {x: 400, y: 70, smooth: 25, rotate: 180},
             duration: 2000,
             loop: 3,
             curve: :easing,
             target: b.id
         })
strdelim
    self.puts_help :anim, demo_code
  end

  def group_api
    demo_code = <<strdelim
b=box()
b.x(300)
b.drag(true)
c=circle()
c.drag(true)
c.size(50)
c.color(:red)
t=text("hello")
b.insert([t,c])
t.bottom(3)
t.x(3)
c.right(7)
c.y(7)
i=image(:atome)
i.size(50)
c.insert(i)
i.x(70)
i.y(70)
strdelim
    self.puts_help :group, demo_code
  end

  def touch_api
    demo_code = <<strdelim

b=box()
b.x(350)
b.touch do 
b.set({color: :green,width: 300})
end
strdelim
    self.puts_help :touch, demo_code
  end

  def fill_api
    demo_code = <<strdelim
back_try = box()
back_try.x(350)
back_try.size(490)
moto_text = back_try.image(:moto)
moto_text.size(70)
back_try.color(:transparent)
moto_text.fill({target: back_try, number: 7})
strdelim
    self.puts_help :fill, demo_code
  end

  def fit_api
    demo_code = <<strdelim
b = box()
my_text = text(lorem)
my_text.size(16)
my_text.width(300)
b.insert(my_text)
b.color(:transparent)
b.shadow(true)
b.fit(target: my_text, x: 20,xx: 10,y: 10,yy: 10)

my_text.x=0
my_text.y=0
#my_text.center(true)

z=box()
z.x(500)
z.y(20)
z.color(:orange)
z.fit(target: b, margin: 7)
z.width=z.width+50
z.height=z.height+50
z.insert(b)
b.center(true)
z.y(70)
########
c=circle({color: :red, size: 50})
c.width(150)
a=box()
a.x(300)
a.y(100)
a.fit(target: c, margin: 7)
a.insert(c)
c.center(true)
c.shadow(true)
a.x(190)
a.y(70)
strdelim
    self.puts_help :fit, demo_code
  end

  def blur_api
    demo_code = <<strdelim
img=image(:avion)
img.x(250)
i=0
img.touch do 
i+=7
img.blur(i)
end
strdelim
    self.puts_help :blur, demo_code
  end

  def align_api
    demo_code = <<strdelim
t=text("move the box and resize the view \nit's position remain relative to the right border")
b = circle() 
b.align(:invert)
b.center(:false)
b.right(250)
b.bottom(50)
b.drag(true)
strdelim
    self.puts_help :align, demo_code
  end

  def background_api
    demo_code = <<strdelim
   blue_gradient=['#4160A9', '#2F3EC3']
  Background.theme(blue_gradient)
strdelim
    self.puts_help :background, demo_code
  end

  def value_api
    demo_code = <<strdelim
info=text(:infos)
info.color(:orange)
info.y(34)
t = text("Click me to know my height!  -  "*16)
t.left(250)
t.y(250)
t.width(:auto)
t.right(280)
t.color(:lightgray)
t.touch do
  info.content(t.value(:height)).to_s
end
strdelim
    self.puts_help :value, demo_code
  end

  def stretch_api
    demo_code = <<strdelim
b = box({color: :orangered, smooth: 20})
# .width must be specified and specified before the last position
b.left(150)
b.width(:auto)
b.xx(280)
b.y(50)
b.height(:auto)
b.yy(80)
strdelim
    self.puts_help :stretch, demo_code
  end

  def each
    demo_code = <<strdelim
d=image({content: :moto, id: :moto})
b = Atome.new(:box)
c=circle({x: 34 , y: -34, drag: true, id: :circle_test, color: :red})
b.insert(c)
b.insert(d)
c.x(-150)
c.y(-150)
d.x(150)
b.x(500)
b.y(200)
b.color(:orange)
b.each do |atome|
  atome.blur(7)
end
strdelim
    self.puts_help :smooth, demo_code
  end

  def batch_api
    demo_code = <<~Strdelim
      text_color=:orange
      t1=text("Text 1")
      t1.x=20
      t1.y=20
      t2=text("Text 2")
      t2.x=220
      t2.y=20
      t3=text("Text 3")
      t3.x=440
      t3.y=20
      t4=text("Text 4")
      t4.x=660
      t4.y=20
      Atome.batch([t1,t2,t3,t4], {content: :batched,color: text_color, size: 16, y: 150})
Strdelim
    self.puts_help :batch_api, demo_code
  end

  def find_api
    demo_code = <<strdelim
t=text({content: :results, y: 20})
b= particle()
x=image(:logo)
z=text(:dummy)
x.delete(true)
z.delete(true)
c=circle({x: 34 , y: -34, drag: true, id: :circle_test, color: :red})
b.insert(c)
d=image({content: :moto, id: :moto})
b.insert(d)
b.x(500)
b.y(200)
b.color(:orange)

wait 2 do
 found=find(value: :all, scope: :blackhole, format: :id)
 t.content(found)
end

wait 4 do
 found=find(value: :all, scope: :blackhole, format: :atome_id)
 t.content(found)
end

wait 6 do
 found=find(value: :moto, scope: :view)
 found.x(30)
end

wait 8 do
  batch=find(:all)
  batch.each do |atome|
   atome.color(:green)
  end
end
strdelim
    self.puts_help :batch_api, demo_code
  end

  def convert_api
    demo_code = <<strdelim
c = circle()
c.xx(250)
c.yy(300)
c.width("33%")
t=text('resize the window')
t.y=20
t.color(:gray)
c.resize do |evt|
  t.content("width set : 33%, in pixel :\n"+Atome.to_px(c, :width).to_s+" px")
end
t.size(16)
t.x(450)

strdelim
    self.puts_help :convert, demo_code
  end

  def over_api
    demo_code = <<strdelim
  c = circle()
  c.x(250)
  c.over(:enter) do
    c.color (:green)
  end
  c.over(:exit) do
    c.color (:red)
  end
strdelim
    self.puts_help :over, demo_code
  end

  def overflow_api
    demo_code = <<strdelim
b = box()
b.color(:orange)
c = circle(x: 350, y: 50)
b.drag(true)
c.drag(true)
d = box
d.drag(true)
d.x(100)
d.y(100)
d.width(380)
d.height(150)
d.color(:yellowgreen)
d.overflow(:hidden)
d.smooth(200)
d.insert(b)
d.insert(c)
b.x=b.y=100
b.touch do 
d.overflow(:visible)
end
c.touch do 
d.overflow(:hidden)
end
strdelim
    self.puts_help :overflow_api, demo_code
  end

  def enter_api
    demo_code = <<strdelim
  b=box()
  b.x(250)
  b.drag(true)
  c = circle
c.color(:green)
  c.x(390)
  c.enter(true) do
    c.color (:red)
  end
strdelim
    self.puts_help :enter, demo_code
  end

  def resize_window_api
    demo_code = <<strdelim
  t = text({content: "resize the window!!", color: :lightgray})
t.center(true)
  get(:view).resize do |evt|
    t.content ("width : "+to_px(get(:view), :width).to_s+" px")
  end
strdelim
    self.puts_help :resize_window, demo_code
  end


  def exit_api
    demo_code = <<strdelim
  b = box({x: 250})
  b.drag(true)
  c = circle
  c.x(390)
  c.exit(true) do
    c.color (:green)
  end

strdelim
    self.puts_help :exit, demo_code
  end

  def drop_api
    demo_code = <<strdelim
b = box()
b.x(250)
b.drag(true)
c = circle
c.x(390)
c.drop(true) do
c.color (:black)
end

strdelim
    self.puts_help :drop, demo_code
  end

  def play_with_event_api
    demo_code = <<strdelim
video = video(:lion_king)
video.pick(:audio).level(0)
video.center(:false)
video.x(150)
video.play(true) do |evt|
  video.x = video.x[:content] + evt.time
end
strdelim
    self.puts_help :play_with_event, demo_code
  end

  def video_play_toggle_api
    demo_code = <<strdelim
t=text({content: 'click to play', color: :lightgray, size: 25, x: 400, y:350})
  video = video('lion_king')
video.x(400)
video.y(400)
video.play(true)
  video.touch do
    if video.play #important video.play==true will not work all the times as play could return an int or a proc
      video.stop()
    else
      video.play(true)
    end
  end
t.touch do
    if video.play #important video.play==true will not work all the times as play could return an int or a proc
      video.stop()
    else
      video.play(true)
    end
  end
strdelim
    self.puts_help :video_play_toggle, demo_code
  end

  def chain_play_api
    demo_code = <<strdelim
vidz = video(:lion_king)
video2 = video(:lion_king)
vidz.x(250)
vidz.y(0)
video2.x(250)
video2.y(400)
t = text({content: :time_code, y: 3, x: 257, color: :orange})
vidz.touch do
  vidz.play(52) do |evt|
    t.content('timecode : ' + evt.time.to_s)
    if evt.time > 61
      video2.play(61) do |evt|
        if evt.time > 70
          vidz.play(52)
          video2.stop(70)
        end
      end
      vidz.stop(70)
    end
  end
end
strdelim
    self.puts_help :chain_play, demo_code
  end

  def play_at_api
    demo_code = <<strdelim
 v = video(:lion_king)
 v.pick(:audio).level(0)
v.center(:false)
t = text("timecode")
v.x(200)
v.y(70)
t.y(20)
v.play(1) do |evt|
  t.content = evt.time
end
 wait 1 do
 v.pick(:audio).level(1)
  v.play(33) do |evt|
    t.content = evt.time
  end
end
strdelim
    self.puts_help :play_at_api, demo_code
  end

  def virtual_events
    demo_code = <<strdelim
  e=box()
  e.virtual_touch({target: e.atome_id, content: "Opal.Atome.$text('we just simulate a click on box ')"})
strdelim
    self.puts_help :virtual_events, demo_code
  end

  def add_prop_to_all_childs_api
    demo_code = <<strdelim
b = image(:atome)
b.drag(true)
b.x(300)
d=b.box()
b.text("hello")
c=b.circle()
b.child().each do |atome|
atome.color(:orange)
end
d.x(180)
d.y(200)
c.y(130)
c.x(50)
strdelim
    self.puts_help :add_prop, demo_code
  end

  def volume_api
    demo_code = <<strdelim
  v = video(:lion_king)
  v.x(250)
   v.pick(:audio).level(0)
  v.play(true)
strdelim
    self.puts_help :volume, demo_code
  end

  def video_clipping_api
    demo_code = <<strdelim
t=text({content: 'click to play', color: :lightgray, size: 25, x: 380, y:320})
b = box()
b.x(350)
b.y=50
    b.y=40
b.size(190)
b.drag(:true)
b.overflow(:hidden)
b.smooth(30)
b.shadow(:true)
vidz = b.video(:lion_king).x(-155).y(-50)
t.touch do
  vidz.play(:true)
end
b.touch do
  vidz.play(:true)
end

strdelim
    self.puts_help :video_clipping, demo_code
  end

  def web_api
    demo_code = <<strdelim
  mytube = web('<iframe width="100%" height="180%" src="https://www.youtube.com/embed/usQDazZKWAk" frameborder="5" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
  mytube.x = 300
mytube.y = 150
mytube.drag(true)
  mytube.width = 300
strdelim
    self.puts_help :web_object, demo_code
  end

  def volume_example_api
    demo_code = <<strdelim
b = box()
b.size(190)
b.x(350)
b.drag(:true)
b.overflow(:hidden)
b.smooth(30)
b.shadow(:true)
vidz = b.video(:lion_king).x(-155).y(-50)
b.pick(:video).pick(:audio).level(0)
b.touch do
  if vidz.play()
    vidz.pause()
    b.width(50)
  else
    vidz.play(true) do |evt|
      if evt.time < 20
        b.width = evt.time * 25
      end
    end
  end
end
style = {width: 25, height: 25}
v_plus = box(style)
v_plus.x = 313
v_plus.y = 100
v_text = v_plus.text("+")
v_text.x = 5
v_text.y = -5

v_minus = box(style)
v_minus.x = 313
v_minus.y = 200
v_text_minus = v_minus.text("-")
v_text_minus.x = 5
v_text_minus.y = -5

v_plus.touch do
  b.pick(:video).pick(:audio).level = b.pick(:video).pick(:audio).level + 0.1
end
v_minus.touch do
  b.pick(:video).pick(:audio).level = b.pick(:video).pick(:audio).level - 0.1
end
strdelim
    self.puts_help :volume_example, demo_code
  end

  def delete_api
    demo_code = <<strdelim
  b = box()
  b.x(250)
  b.touch do
    b.delete(true)
  end

strdelim
    self.puts_help :delete, demo_code
  end

  def enliven_api
    demo_code = <<strdelim
t=text({content: "Click to box to delete it,\nThen click me to undelete it!!", color: :lightgray , x: 350, y: 130})
b = box()
c=circle({x: 70 , y: 70, drag: true})
b.insert(c)
b.x(500)
b.y(200)
b.color(:orange)

b.touch do
  b.delete(true)
end

t.touch do
  b.enliven(true)
end
strdelim
    self.puts_help :enliven, demo_code
  end

  def selector_api
    demo_code = <<strdelim
b = box()
b.y(400)
b.selector(:validated)
t = text("my text")
t.selector(:validated)
c = circle()
c.color(:green)
c.x(400)
c.y(200)
t.y(350)
select(:validated).each do |item|
  if item.selector && item.selector.include?(:validated)
    item.color(:orangered)
    item.x(400)
  end
end
strdelim
    self.puts_help :selector, demo_code
  end

  def parent_api
    demo_code = <<strdelim
a = box()
a.x(400)
a.id = "i_am_your_father"
b = circle({color: :red, size: 20})
a.insert(b)
b.center(:true)
parents=[]
b.parent.each do |parent|
  parents << parent.id
end
t = text(content: parents, y: 120)
t.color(:lightgray)
t.x(360)
t.y(200)
strdelim
    self.puts_help :parent, demo_code
  end


  def property_api
    demo_code = <<strdelim
b = box()
b.property({property: :color, value: :red})
t=text("the box keep it's color but the internal value is now : "+b.color)
t.y(200)
strdelim
    self.puts_help :property, demo_code
  end

  def properties_api
    demo_code = <<strdelim
b = box()
b.x(450)
b.properties.each_with_index do |property, index|
   property.each do|key, value|
     t=text(key.to_s + " : " +value.to_s)
     t.size(14)
     t.x=550
     t.color(:orange)
     t.y=250+20*index
   end
end
strdelim
    self.puts_help :properties, demo_code
  end

  def center_api
    demo_code = <<strdelim
b = box()
b.center(:true)
c=circle()
c.color(:red)
c.width=c.height=50
c.center({y: 0, dynamic: false})
c.center(:x)

strdelim
    self.puts_help :center, demo_code
  end

  def position_api
    demo_code = <<strdelim
  z=box()
  z.y(250)
  z.height(2000)
c=circle
c.x=250
c.y=120
c.position(:fixed)

strdelim
    self.puts_help :position_api, demo_code
  end


  def ide_api
    demo_code = <<strdelim
ide_tool = box(z: 50, x: 350, y: 350, width: 34, height: 34, smooth: 7, color: :orange, shadow: {blur: 16, color: :black, ide: :ide_tool})
tool_label = ide_tool.text('ide')
tool_label.x(5)
tool_label.y(5)
tool_label.size(14)
tool_label.id(:tool_label)
grab(:intuition).insert(ide_tool)
grab(:view).ungroup(ide_tool)

ide_tool.touch do
  #we laod the parser first  if not amerady loede
  unless Opal_utils.opal_parser_ready
    Opal_utils.load_opal_parser
  end
  #now we build the ide
  if get(:ide_container)
    if get(:ide_container).parent[0].atome_id ==:intuition
      grab(:intuition).ungroup(get(:ide_container))
      grab(:intuition).ungroup(get(:ide_control_bar))
      get(:dark_matter).insert([get(:ide_container), get(:ide_control_bar)])
    else
      grab(:dark_matter).ungroup(get(:ide_container))
      grab(:dark_matter).ungroup(get(:ide_control_bar))
      get(:intuition).insert([get(:ide_container), get(:ide_control_bar)])
    end

  else
    ide_control_bar = box(smooth: 3, height: 30, width: 570, id: :ide_control_bar, shadow: {blur: 16, color: :black}, color: :orange)
    ide_container = box(height: 300, width: 570, id: :ide_container, shadow: {blur: 16, color: :black}, color: :transparent)
    run_icon = ide_control_bar.box({smooth: 7, width: 21, height: 21, shadow: true, color: :lightgrey, z: 7})
    label = run_icon.text({content: :run, size: 10})
    label.x(2).y(3)
    run_icon.x(2)
    run_icon.y(2)
    ide_container.x = ide_tool.x
    ide_control_bar.x = ide_tool.x
    ide_control_bar.y = ide_tool.y[:content] + 43
    ide_container.y = ide_control_bar.y[:content] + 25

    grab(:intuition).insert(ide_control_bar)
    grab(:view).ungroup(ide_control_bar)
    grab(:intuition).insert(ide_container)
    grab(:view).ungroup(ide_container)

    #ide_control_bar.drag(true) do |evt|
    #  ide_container.x = ide_control_bar.x
    #  ide_container.y = ide_control_bar.y[:content] + 25
    #end
    ide_container.scale do |evt|
      ide_control_bar.width = ide_container.width
    end
    run_icon.touch do
      #ide_id='ide_'+ide_container.atome_id.to_s
      ide_content = JS_utils.get_ide_content(ide_container.atome_id)
      clear(:view)
      eval(ide_content)
    end
    code_to_add = <<new_string
box({color: :green})
t=text('hello')
t.x(300)
new_string
    Render.render_ide(ide_container.atome_id, "circle({color: :yellowgreen, x: 100, y: 350})")
    wait 2 do
      JS_utils.set_ide_content(ide_container.atome_id, code_to_add)
    end
  end
end
ide_tool.add({drag: true})
strdelim
    self.puts_help :ide, demo_code
  end

  def scale_api
    demo_code = <<strdelim
a = box()
a.drag(:true)
a.width=a.height=150
a.overflow(:hidden)
t=a.text({content: "resize me!!\n drag right bottom corner!", size: 14})
t.x=t.y=20
a.scale do |evt|
  t.content("w: "+a.width.to_s+"\nh: "+a.height.to_s)
end
strdelim
    self.puts_help :scale, demo_code
  end

  def clear_api
    demo_code = <<strdelim
d = box()
d.set({width: 100, height: 100})
d.y(50)
t = d.text(content: 'remove all childrens', color: :gray)
t.x=2
t.y=2
d.touch do
  d.clear()
end
strdelim
    self.puts_help :clear, demo_code
  end

  def clear_and_preserve_api
    demo_code = <<strdelim
b=box()
b.id(:the_box)
c=circle({x: 290, id: :circle})
t=text({content: :hello, x: 260})
b.touch do
  clear({target: :view, exclude: :circle})
end
strdelim
    self.puts_help :clear_and_preserve_api, demo_code
  end

  def default_api_values
    demo_code = <<strdelim
##now all newly created box wil have the properties set below
 Atome.presets({box: {color: :yellowgreen, width: 150, left:200, top: 300}})
box()
#Applying circle preset on text 
# Atome.new({type: :text, content: :hello, preset: :circle})
strdelim
    self.puts_help :default_values, demo_code
  end

  def render_api
    demo_code = <<strdelim

b = box({color: :red, render: :false, center: true, id: :b})
t=text({content: :render, x: 400, y:0, id: :t})
h=text(content: :hide, x: 500, y:0, id: :h)
c=text(content: :check, x: 600, y:0, id: :c)
t.touch do
  b.render(:true)
end
h.touch do
  b.render(:false)
end
c.touch do
end
  b.touch do
  end
strdelim
    self.puts_help :render, demo_code
  end

  def constraint_api
    demo_code = <<strdelim
a= box()
a.y(400)
a.x(350)
a.drag(:y) 

#video
v = video(:lion_king)
v.y(20)
v.x(350)
#drag box
b = box({color: :red, shadow: true, smooth: 7})
t = b.text("Deplace moi")
t.size(14)
t.x(2)
t.y(2)
#the param '':parent' indicate the that the drag of the box is constraint into the parent
b.center(:false)
b.drag(:parent) do |evt|
  t.content("pos : " + evt.x.to_s)
end
v.insert(b)
b.center(true)
v.selector(:tutu)

v.pick(:audio).level(0)
v.play(10) do |evt|
  if evt.time > 15
    b.x = evt.time * 10
    b.color(:green)
  else
    b.color(:orange)
  end
end
strdelim
    self.puts_help :constraint, demo_code
  end

end

class Helper
  include Help
end


examples()