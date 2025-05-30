

[Main menu](../atome.md)
-


[back](./kickstart.md)



Install atome prerequisites
-

#Install atome (OSX)

IMPORTANT :
For tauri in prod in "exe/atome" in :
def build_for_osx(destination).. type:

    `cd #{destination};cargo tauri build`
for dev type :

    `cd #{destination};cargo tauri dev`


Install rust & tauri
    
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
    brew install openssl
    cargo install tauri-cli --force

Install Homebew

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Install rbenv, wasi-vfs, wasmtime :
brew install rbenv
# brew install wasmtime
=> please check as it is certainly useless because we have in vendor/src-wasm/wasm/wasi_vfs_...,
if need to install  use :  brew install  wasi-vfs

brew install npm
npm install --save ruby-3_2-wasm-wasi@latest

Install ruby :
rbenv install -l
rbenv install 3.2.2

nano ~/.zshrc => add : eval "$(rbenv init - zsh)"
rbenv shell  3.2.2
rbenv global   3.2.2
gem update --system
gem update

Get atome gem :
git clone https://github.com/atomecorp/atome.git

In the terminal at atome root , type:
bundle install
Bundle update

Ruby wasm time allow local use of ruby wasm :
1 - download :
https://cdn.jsdelivr.net/npm/@ruby/3.2-wasm-wasi@2.3.0/dist/browser.script.iife2.js
2 - change


# how to Install on windows :

# Install ruby :
https://rubyinstaller.org/downloads install with devkit
# check install using :
ruby -v
gem list

# update gem using the two following commands
gem update --system
gem update

#install node:
https://nodejs.org/en/download
# check install using :
node -v

#install wasi :
npm install --save ruby-3_2-wasm-wasi@latest

#install rust :
https://www.rust-lang.org/tools/install use rustup
# check install using :
rustc --version


#install tauri:
npm install --save-dev @tauri-apps/cli
# check install using :
npm fund

#install wasmtime :
https://wasmtime.dev/
# check install using :
ruby wastime --version

#install git :
https://git-scm.com/


# Get atome framework :
git clone https://github.com/atomecorp/atome.git

# go in the cloned directory the in the terminal at atome root , type:
bundle install
Bundle update

# to check we build atome gem
rake build_gem

# in the terminal type
gem list
# check atome is part of the list of the gems

# then in the folder of your choice create a new atome app using :
atome create my_app
cd my_app
atome run browser


getter setter for atome are situated in lib/atome/genesis/genesis.rb :     def new_atome(element, &method_proc)
the getter return a group from the collected atomes ( all included atomes)



# Third parties's javascript libraries are located at different location
# If you need to update it or add a JS library you need to clone : https://github.com/atomecorp/atome_third_parties_js.git

The importance of the type :

When a new atome is created the  rendering occurs when it’s type is set : see :  lib/atome/generators/identity.rb

##### rendering a new atome type

Rendering special atomes (color, shadow)that that only affect materials atome(shape, text)

When crating a new atome the first thing the system  is looking at Is ‘type’ so to render, go to identity.rb in your current render folder (ex :html) and create renderer for the current atom type ex :
new({ method: :type, type: :string, specific: :shape, renderer: :html }) do |_value, _user_proc|
html.shape(@atome[:id])
end


Paths:

new render here : atome/lib/atome/extensions/atome.rb
class Object
def new(params, &bloc)

rendering call here: atome/lib/renderers/renderer.rb

Automatic renderer generation here: atome/lib/atome/extensions/atome.rb :
class Object
def new(params, &bloc)

renderers are build here : atome/lib/atome/genesis/genesis.rb
def build_render(renderer_name, &method_proc)

remove condition  atome/lib/renderers/renderer.rb in def rendering

New particle example :

new({ particle: :shell })
# automatically create a @shell instance variable in the atome to store the value
Usage  :

s=shape({})
s.shell(‘pwd’)
s.shape => ‘pwd’

Callback :


Important : all atome particle have a pros associated often use for callback when needed :
to acces this code use "particle_name_code" ex for touch to access the callbacks use : touch_code
s.shell(‘pwd’) do |method_return|
puts method_return
end
# note that automatically create a @shell_code instance variable in the atome to store proc

Also atome automatically create a call back method suffix with ‘_callback’ ex: shell_callback
If you call this method the bloc will be executed with the value as parameters

This automatic method could be override using  : new({callback: :shell}) do |params, bloc|
# …write what you want …
end

To get the proc you’ll need to use :
s.shell_code[:shell]
# please note that s.shell_code return a hash because a single particle may hold many proc (by default the method_code return the default code )



Callback from javascript :
In : vendor/assets/src/js/specific/ there’s two methods used to handle callback
The easier method to send the callback to ruby is to use atomeJsToRuby like this :

With javascript you can  call the internal ‘automatically created ‘ method : termninal_callback and send them the data getter from javascript like this :
atomeJsToRuby(‘particle_callback', "('" + js_data + "')")
Exemple with terminal particle:
atomeJsToRuby('termninal_callback', "('" + cmd_result + "')")
Or call the callback like this :
atomeJsToRuby( " instance_variable_set(‘@terminal_code’, "’" +data+  "’" )")
atomeJsToRuby("callback(:terminal) ")

One is called wasm.js directory and one called opal.js both have the same method  :  atomeJsToRuby

On the js side there’s a special method call  ‘callback’ in atome.js file , this method handle all the needed code to create a callback, this method is call like this:
callback(particle, value)
Ex : callback('terminal', ‘cmd’)


The power of ‘A’
# the constant A is used to access any atomes methods without having to create a new atome
Ex :
A.monitor({ atomes: [:the_box, :the_cirle], particles: [:left] }) do |atome, particle, value|
puts "changes : #{atome.id}, #{particle}, #{value}"
end

to prevent a particle data to be saved you can use :

new ({particle: :build, store: false}) do

# …..
end
To save manually you can use the store method , like this :

store({build: :my_data })

The modifier atomes (color, shadow)
Here is the mechanism of such atome:


Important:

Each Each particles and atome is store as an :
- Particle as an Instant variable in the object itself , get the value of the article simply using : atome.particle
- Each particle as a hash in the the instance variable @atome within the atome  you can retrieve any particle content using : @atome[:particle]
- The atome object is also available in html  in the @atome instance variable
- Atome object is also available in the class Universe within @atomes , to retrieve it use Universe.atomes[atome_id]

It may need a bit more optimization


Atomes have a  special method to monitor all fasten /affected atomes , call : Atome.global_monitoring
Code at :  helpers/utilities.rb /def global_monitoring
Usage :
Atome.global_monitoring(self, [:red, :blue, :blue, :alpha, :left, :right, :diffusion], [:variable1, :variable2])

The ephemera @new_atome to allow access to data send to the  atome at init time

Important : for atomes that needs to be fasten or apply to
This happen in the method  in presets/atome.rb : atome_common
at this line :
if params[:type] == :color || basic_params[:type] == :color || params[:type] == :shadow || basic_params[:type] == :shadow


Sanitizer , pre, post , after in atome/helpers/utilities.rb

Sanitizer :
Particle : allow to modify params send by user before parsing creation  (context is the current atome)
Atome : allow to modify params send by user before parsing creation

To remove :  in material.b add it to : « new({post: :remove}) do |params| »


Pre :
Particle  : after params parsing and  before rendering  (context is the current atome)
Atome :  after params parsing and before atome creation  (context is the parent atome)

Post
Particle  :  after params parsing and  after rendering  (context is the current atome)
Atome:  after params parsing and  after atome creation (context is the current atome)

After :
Particle  : only after rendering and storage (context is the current atome)

read:
To alter a particle before getting the  value



pay attention to atome category material vs modifier
color, shadow and paint are modifier
while shape, image, vector, video audio are materials

there is some specific treatment/code here :
in presets/atome, atome_common:
if %i[color shadow paint].include?(preset_list)

and in genesis,  new_atome :
:   if %i[color shadow paint].include?(element)




atome expert and atome developers
expert develop atome core
developers create solution with atome framework