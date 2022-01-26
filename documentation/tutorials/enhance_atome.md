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


the ruby scripting layer hold all the apis available to developers 
those API must remain consistent all along the way and must be available on any atome even if it produce no result  

the tool and API should never alter the original atome in order to stay non destructive  

the renderer should always be abstracted from the ruby code 

to do so we have a folder containing the different renderers available   you'll find the render controller in atome/lib/atome/renderers




Build a new atome
-
- create a new type of atome 

let's create a new glow effect:
in the scripts/properties_generator.rb file in the method named "atome_methods" add your new atome in the corresponding category here the effect category
we add "glow" to this list.

the method named "types" is used when we create a new type of atome which is not the case here

the method named "is_atome" is used when the new atome create an object this is also not the case as we create a property for now

the method named  "need_pre_processing" is used idf we want some special treatment before rendering the object, this is not the case

the method named "need_processing" is used idf we want some special treatment after rendering the object, this is not the case

the method named  "getter_need_processing"is used if we want some special treatment when getting the value the the atome

the method named "no_rendering" is used if the atome doesn't need to be rendered, this is not the case

Other methods in the "properties_generator" file can be ignored for now

Now next time we'll run the framework the necessary file will be created

if you try to run your application with th following code:

    
    b=box
    b.glow(6)

you'll have error in the browser console saying : "glow_html: undefined method `glow_html' for..."


atome framework is looking for the rendering  method named "glow_html" we explain the multi-render mechanism in an other document


Finally we have to manually create the rendering method in our renderer by default the HTML render is used

so we have to go to "atome/lib/atome/renderers/html/properties/" the  open "effect.rb" as we want to create an effect renderer 

So in the "effect.rb" file we had the method name "glow_html" (the newly atome name suffixed with "_html" for html rendering)

    def glow(val)
      jq_get(atome_id).css('filter', "drop-shadow(  0px 0px #{val}px white )")
    end
      
That's it you've created your first atome!!

Build a new tool
  -
