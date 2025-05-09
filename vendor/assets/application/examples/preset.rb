# frozen_string_literal: true


# here how ti use preset in the atome framework
# presets available are : render_engines,image,video,animation,element,box,vector,circle,shape,text,drm,shadow,color,www,raw,code,audio,group,human,machine,paint

my_box=box
# using the code line above a lot of particles will be implicitly created, if we inspect my_box
puts my_box.inspect # this will print :
#[Log] #<Atome: @broadcast={}, @callback={}, @tag={}, @fasten=[], @unit={}, @collected={}, @id=:box_14, @type=:shape, @html=#<HTML:0x0662a164 @element=[object HTMLDivElement], @id="box_14", @original_atome=#<Atome: @broadcast={}, @callback={}, @tag={}, @fasten=[], @unit={}, @collected={}, @id=:box_14, @type=:shape, @html=#<HTML:0x0662a164 ...>, @attach=[:view], @renderers=[:html], @width=99, @height=99, @apply=[:box_color], @left=100, @top=100, @clones=[], @preset={:box=>{:width=>99, :height=>99, :apply=>[:box_color], :left=>100, :top=>100, :clones=>[]}}>, @element_type="div">, @attach=[:view], @renderers=[:html], @width=99, @height=99, @apply=[:box_color], @left=100, @top=100, @clones=[], @preset={:box=>{:width=>99, :height=>99, :apply=>[:box_color], :left=>100, :top=>100, :clones=>[]}}> (browser.script.iife.min.js, line 13)

# please note that an ID is automatically created using a simple strategy  id : atome_type_total_number_of_users_atomes  ex here :  @id="box_14"

my_box.text("touch me")
puts " my_box preset is : #{my_box.preset}"
# print in the console : [Log]  my_box preset is : {:box=>{:width=>99, :height=>99, :apply=>[:box_color], :left=>100, :top=>100, :clones=>[]}} (browser.script.iife.min.js, line 13)


c=circle({id: :my_circle, width: 333, height: 333})
puts  " c is : #{c.inspect }"
# this print : [Log]  c is : #<Atome: @type=:shape, @smooth="100%", @width=99, @id=:circle_16, @renderers=[:html], @height=99, @broadcast={}, @callback={}, @tag={}, @fasten=[], @unit={}, @collected={}, @html=#<HTML:0x06579be8 @element=[object HTMLDivElement], @id="circle_16", @original_atome=#<Atome: @type=:shape, @smooth="100%", @width=99, @id=:circle_16, @renderers=[:html], @height=99, @broadcast={}, @callback={}, @tag={}, @fasten=[], @unit={}, @collected={}, @html=#<HTML:0x06579be8 ...>, @top=100, @attach=[:view], @left=100, @apply=[:circle_color], @clones=[], @preset={:circle=>{:width=>99, :height=>99, :smooth=>"100%", :apply=>[:circle_color], :left=>100, :top=>100, :clones=>[]}}>, @element_type="div">, @top=100, @attach=[:view], @left=100, @apply=[:circle_color], @clones=[], @preset={:circle=>{:width=>99, :height=>99, :smooth=>"100%", :apply=>[:circle_color], :left=>100, :top=>100, :clones=>[]}}> (browser.script.iife.min.js, line 13)
# it's pôssible to alter basic preset using the particle .preset
my_box.preset({ circle:  {type: :shape, :width=>99, :height=>99, :smooth=>"100%", color: :red, :left=>100, :top=>100 }})
puts " my_box preset is now : #{my_box.preset}"
# now the preset circle is : [Log]  my_box preset is now : {:circle=>{:type=>:shape, :width=>99, :height=>99, :smooth=>"100%", :color=>:red, :left=>100, :top=>100, :clones=>[]}} (browser.script.iife.min.js, line 13)

my_box.touch(true) do
  my_box.preset(:circle) # the box now rounded like a circle

  new_circle=circle # as the preset circle has been modified tha circle is now red as specified in the updated preset
  puts  "new_circle is : #{new_circle.inspect}"
  # this print : new_circle is : #<Atome: @type=:shape, @smooth="100%", @width=99, @id=:circle_18, @renderers=[:html], @height=99, @broadcast={}, @callback={}, @tag={}, @fasten=[], @unit={}, @collected={}, @html=#<HTML:0x0664e99c @element=[object HTMLDivElement], @id="circle_18", @original_atome=#<Atome: @type=:shape, @smooth="100%", @width=99, @id=:circle_18, @renderers=[:html], @height=99, @broadcast={}, @callback={}, @tag={}, @fasten=[], @unit={}, @collected={}, @html=#<HTML:0x0664e99c ...>, @top=100, @attach=[:box_14], @left=100, @apply=[:circle_18_color_1_0_0_0_0_0____], @clones=[]>, @element_type="div">, @top=100, @attach=[:box_14], @left=100, @apply=[:circle_18_color_1_0_0_0_0_0____], @clones=[]>
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "inspect",
    "min",
    "preset",
    "script",
    "text",
    "touch"
  ],
  "inspect": {
    "aim": "The `inspect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `inspect`."
  },
  "min": {
    "aim": "The `min` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `min`."
  },
  "preset": {
    "aim": "The `preset` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `preset`."
  },
  "script": {
    "aim": "The `script` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `script`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
