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
let's create a new type of atome :

in the scr

Build a new tool
  -
