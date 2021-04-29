
<span align="right">

[Main menu](../atome.md)
-
</span>


**what is (an) atome?**
-

The concept
-

atome object is the uniq object that can hold any type of data!

Think pdf but collaborative and editable!
-

An atome can be anything from a single property to a full blown document.

an atome can hold a simple property such as a color, or an image,a text, an effect, a video, a group of object or even full complex document mixing many types.

Say goodbye to applications : atome can be modified by any tools created for them.
-

The idea behind atome is to have only one kind of object, so any tools applied onto it will have an action whatever the atome's content.

- Simplify the automation of batch process as the object is always the same whatever it is (from a simple box thru a video montage to a complex page description) it's always an atome)
- Simplify the development and tests of new tools. Ruby language allow you to script anything on the fly
- Reduce the number of tools needed for an application. (you dont ever have to wrote a specific tool for a specific medias anymore, as the same tool now work on any atome.
- and many many other ...


Say goodbye to file format: here any tools can alter any data.
-

- no filetype but instead unique objet called an atome 
- These atomes can then be modified by any available api.
- Only one type means no more file format, this is the guaranty that documents can always be open, shared and edited.


**[- What's in the box](./box_content.md)**
-

Guideline and philosophy
-


to keep this idea working we have to follow the following rules during atome development :

- All Apis must run of all targeted platform (their should be no difference from one platform to another.)
- any property or new api must always work on any type of atome, to keep the consistency of the "atome uniq object"


atome explained : the uniq object format
-

an atome is a collection of properties

it's  type is also an property so atome can be mutable!

a single atome can be displayed in different way according it's rendering mode and or it's type. 

EG : 

    a=image(content: :moto)


<img src="https://github.com/atomecorp/atome/raw/development/www/public/medias/images/moto.png" width="333" />

    a.type(:text)
moto

    a.render({value: :list, option: :property, ordered: :alphabetically })
<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/list.png" width="400px" />



- Anything that define an atome is a property.
  any atome can contain an other atome or a group of atomes as a property ex :


    b = box({x: 300, drag: true})
    image(:logo)
    c = circle(x: 100)
    b.insert(c.atome_id)
    b.text('hello')
    puts b.child #=> [c, t] (c and t is now a child of b)
    b.touch do
    # b children can be treated in one passe
    # look at child example for more examples
    b.child.color(:green)
    end

The atome properties can be set using a string or integer eg :

    text("hello)

Those value are always define internally using a key-value pair (Hash type) and can be set so :

    text({content: "hello"})

those values can be a String, an Integer, a hash(key-value) or an array.
The atome can receive a second optional parameters to refresh the view or not.
in this case the atome is till rendered in the view but the newly added parameters does not refresh the objet.
(Please not the 'refresh option' behavior is not the same as the render property, the refresh option is used when a property is modify by the view it self we want to modification to be stored into the atome structure, but but want the view to be re-rendered)

- Any property can be define using an unique value (passed as a String , Symbole or a numeric  value)


    a=box({color: :red})
    a.color(:red)
    a.set({color: :red})

- Any property define are store internally as a Hash or an array if the property is define many times


    a=box()
    a.color(:red)
    puts a.color #=> {color: :red}
  
- multiples parameters can be set at once using a hash:
  

    box({x: 96, y: 96, color: :red, blur: 3})

- an object can be add as/like a property


    box({text: :hello})
    #or 
    b=box(x: 200)
    b.text("hello")

- methods can be chained or assigned 

        b=box(width: 33)
        b.color(:red).x(96).blur(3)
        #or
        c=circle(color: :red)
        b.color=c.color
        c.y=b.blur



- to set a complex property such as shadow that needs more more than one parameters we have to send a hash to the atome

please note that any property can potentially have multiples parameters even the simplest one

    a=box()
    a.set({x: {content: 200, unit: :meters}) 

- Any property are stackable (even the simplest one), in this case we used the 'add' method to stack prop. alternatively it's possible to used an array to stack properties

a simple gradient :

        b=box()
        b.color([:cyan, :green, :orange, {diffusion: :conic}])


- all properties are treated identically and can be swap at any time.Type mutation is also possible : ex change the type of object from an image to text type

    x=image({color: :white, content: :boat })
    ATOME.wait 2 do
    x.type(:text) #now the objet is rendered as a text object
    end



here some possible definition of an atome

    a=box({color: red}) # an red box is created
    a.set(smooth: 3) # the box has rounded corner the view is refreshed
    a.set({width: 250},true )# the box is now 250px wide the view is forced to refresh
    a.set({border: :orange, thickness: 3}, false) #the atome is still red the view is not refreshed (no border!)
    a.set([[color: :red, top: 20],[color: :blue, bottom: 0]], false) #the first parameters is an array that contain an array of color to allow a gradient , finally the view is not refreshed the atome remains 'red'.
    a.color([{color: :yellow, top: 0}, {color: :orange, bottom: 0}]) # another way to set the atome property using the property name instead of using the 'set' methods, this time the view is refreshed

**[- Architecture of the folders](./folder_architecture.md)**
-

**[- logic and datas flows](./datas_flows.md)**
-