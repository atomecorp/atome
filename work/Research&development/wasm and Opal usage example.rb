################################################# examples for wasm and opal compatibility #################################################
#
JS.eval("console.log('kool')")
puts JS.eval("return 1 + 2;") # => 3
# JS.global[:document].write("Hello, world!")
div = JS.global[:document].createElement("div")
div[:innerText] = "clické2 me"
JS.global[:document][:body].appendChild(div)
element = JS.global[:document].createElement("div")
element.setAttribute("id", "my-div")
element[:style][:color] = "red"
element[:innerText] = "cheked"
JS.global[:document][:body].appendChild(element)

div[:style][:backgroundColor] = "orange"
div[:style][:color] = "white"
div.addEventListener("click") do |e|
alert e
puts "hello"
div[:style][:backgroundColor] = "blue"
div[:innerText] = "clicked!"
end
element_to_move = JS.global[:document].getElementById("my-div")
element_to_move[:style][:left] = "333px"
element_to_move[:style][:position] = "absolute"
# ############################
#
def hello_ruby(val)
puts val
end
JS.global[:rubyVM].eval("puts 'eval ruby from JS works!'")
JS.global[:rubyVM].eval("hello_ruby 'method call from js inside ruby works!!!'")


div = JS.global[:document].createElement("div")
JS.global[:document][:body].appendChild(div)
div.setAttribute("id", "the_box")
# // let's add the style

the_boxStyle = "width: 120px;height: 320px;top: 120px;position: absolute,left: 90px;background-color: yellow";
# JS : var obj = { width: "120px", height: "320px",position: "absolute", top: "120px",left: "90px", backgroundColor: "yellow" };
children_found = ["the_box"];
children_found.each do |child|
el_found = JS.global[:document].getElementById(child)
el_found[:style][:cssText]=the_boxStyle
end


# # //let's create the color now
my_colorStyle = "red";
parents_found = ["the_box"];
parents_found.each do |parent_found|
el_found = JS.global[:document].getElementById(parent_found)
el_found[:style][:backgroundColor]=my_colorStyle
end



# ############## resize example ##############
window = JS.global

# # Fonction appelée lorsque la fenêtre est redimensionnée
def on_window_resize
 width = JS.global[:window][:innerWidth]
 height = JS.global[:window][:innerHeight]

 # Afficher la taille dans la console Ruby-Wasm
 puts "Taille de la fenêtre: #{width} x #{height}"
end
#
# # Attacher la fonction au gestionnaire d'événements de redimensionnement
window.addEventListener("resize") do |_|
 on_window_resize
end
# #############

# # demo below uncomemnt corresponding code in wasm/index.html
def my_rb_method(val)
 puts "val is #{val}"
end


def my_rb_method2(val, val2)
 my_proc= instance_variable_get(val2)
 my_proc.call(val) if my_proc.is_a? Proc
end

def  my_fct(val, &proc)
 puts "----- > ok for all #{val}"
 proc.call("Hello from proc!") if proc.is_a? Proc
end

def  my_test_fct
 puts "----- > ok for my_test_fct"
end
JS.global[:rubyVM].eval('my_test_fct') # => works

@my_proc = Proc.new { |x| puts x } # => works
JS.global[:rubyVM].send(:my_fct, 'js can call ruby method!!',&@my_proc) # => works
JS.global[:document][:js_method_that_call_ruby_method]
JS.global.call('js_method_that_call_ruby_method','I am the great params for the proc', "@my_proc")
JS.global.send('my_test_fct')

new({ specific: :color, method: :top }) do |_value, _user_proc|
  # html.shape(@atome[:id])
  "i am here"
end

bb=Atome.new({ color: { left: 77 } })
bb.color({top: 66})

############ color and other atome's type solution
module Color;end

Color.define_method :top do |params = nil, &user_proc|
  puts "top Color"
end

Color.define_method :hello do |params = nil, &user_proc|
  puts "Hello from Color"
end

class Atome
  def hello
    puts "generic hello"
  end

  def top
    puts 'generic top'
  end
end

obj1 = Atome.new
obj1.extend(Color)

obj1.hello
obj1.top

# Redefine the methods in the singleton class

class << obj1
  methods = Atome.instance_methods
  methods.each do |module_method|
    original_method = Atome.instance_method(module_method)
    define_method(module_method, original_method)
  end
end

obj1.hello
obj1.top
box
