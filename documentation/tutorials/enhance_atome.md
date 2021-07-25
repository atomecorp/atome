<span align="right">

[Main menu](../atome.md)
-
</span>
<span align="left">

[back](./tutorials.md)

</span>

How to enhance the framework :
-
**guideline**


the ruby scripting layer must hold all the apis available to developers 
those API must remain consistent all along the way and be able all availlable atome atome even if it produce no result  

the tool and Pai should never alter the original atome in order to stay non destructive  

the renderer should always be abstracted from the ruby code 

to do so we have a folder containing the different renderers available  
for each renderer if code needs to to be wrapped we used a three steps methods the renderer the abstraction code(opal extensions) and finally the foreign code (javascript)


Creste a new type
-

how to create new type:
ex create a "web" type

- if a visuals are required for the new created, you have to add the following lines in the proton.rb file within 'module Proton':


    @@web = @@visual.merge(@@shape).merge(type: :web, preset: :web)


the presets method create a new hash that hold the basics properties of the new atome type(in this case web type), it is need if you want to define the visual default representation of the type

- in proton.rb, the module Proton contains the  'presets' method you have to return the newly created ex:
  return {box: box, circle: circle, text: text, image: image, video: video, audio: audio, particle: particle, tool: tool, web: web}


- optionally you can define a new function that behave like a shortcut to create a preconfigured object. In this case a "web" function
  will create the shortcut.
  ex add the following function in the big_bang.rb file:
  (To be consistent the function should have the name of the newly created type)


	 def web(options = nil)
       if options && (options[:render]==false || options[:render]==:false )
         refresh=false
       else
         refresh=true
       end
       atome = Atome.new(:web, refresh)
       if options && (options.class == Symbol || options.class == String)
         atome.send(:content, options)
       elsif options && options.class == Hash
         options.each_key do |param|
           value = options[param]
           atome.send(param, value)
         end
       end
       return atome
     end


- neutron.rb file add the following lines :


          def web params = nil, refresh = true, add = false
            tag = :web
            web = Atome.new(tag)
            if params.class == String || params.class == Symbol
              params = {content: params}
            elsif params.class == Hash
              self.child.each do |child|
                if child.type == tag
                  params.keys.each do |key|
                    value = params[key]
                    child.send(key, value)
                  end
                end
              end
            end
            web.set(params)
            self.group(web)
            web.x(0)
            web.y(0)
            return web
          end
    
          def web= params = nil, refresh = true, add = false
            web(params, refresh, add)
          end


There two possibles ways to build an atome object:

- using the Atome class

  a=Atome.new(:box)


- or the lazy the way using preset

  a=box()
  
  how to
  -
  
  create a new tool
  
  how to add new properties
  
  property generator 
  
  	simple property
	
	options 
		pre and post processing
		rendering
		
		
adding a js functionality 
	how to communicate with ruby

create a complex api using js, ruby and a callback
-
        
- 1 create a new file in /www/public/js/atome_libraries/ ex: "dummy_helper.js" 
  
- 2 add a class (please note that you must at least pass pass a proc argument to create a callback. ex :
    
        class DummyClass {
            constructor(args1,proc) {
                treated_datas="the result is :  "+args1
                Opal.JSUtils.$dummy_callback(treated_datas,proc);
            }

[comment]: <> (        })
  
- 3 create an opal helper in /atome/lib/atome/extensions/opal/ ex: opal_dummy.rb
  
- 4 add the above file (dummy_opal.rb) to the require list in /atome/lib/atome.rb ex :
  
        require "atome/extensions/opal/opal_dummy"
  
- 5 in this file you'll create JSUtils module then add two methods within : 
  1 that call the js script newly created: "dummy_helper.js" and the second that receive the callback: "dummy_callback", ex :

      module JSUtils
        def js_speech_recognition(my_arg, &proc)
          `dummy_helper(#{my_arg},#{proc})`
        end
      
        def self.dummy_callback(my_arg, proc)
          proc.call(my_arg) if proc.is_a?(Proc)
        end
  end

-6 now open the /scripts/properties_generator.rb file and add the new method you want to be generated.
ex : "dummy" in  the most corresponding category found at the top the page  ex in :misc=%i[] so misc=%i[dummy]

- 7 at least you have to manually create a rendering methods in /atome/lib/atome/renderers/html/properties and other renderer if you want (fabric,three, zim, ...) ex: 

      module FabricProperty
        def dummy_html(value)
          puts data
        end
      end
	
