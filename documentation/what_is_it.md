<div align="right">

[Main menu](./atome.md)
-
</div>

what is (an) atome?
-

The concept
-

The idea behind atome is to have only one kind of object, so any tools can be apply onto it whatever it's type.

atome : the uniq object format
-

an atome is a collection of properties
atome type is also an property so atome can mutable
a single atome can displayed in different way according it's rendering mode and or it's type. 

EG : 

    a=image(content: :moto)



<img src="https://github.com/atomecorp/atome/raw/development/www/public/medias/images/moto.png" width="333" />

    a.type(:text)
moto

    a.render({value: :list, option: :property, ordered: :alphabetically })
<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/list.png" width="400px" />



- Anything that define an atome is a property.
  any atome can contain an other atome or a group of atomes as a property ex:

  b=box()
  i=image(:logo)
  c=circle()
  t=text("hello)
  c.atome(b)
  puts c.child #=> c (b is now a child of c
  b.group([i,t])
  puts b.child #=> [i,t] (i and t ares now a child of b


The atome properties are always define using a key-value pair (Hash type). those values can be a String, an Integer, a hash(key-value) or an array.
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

- to set a complex property such as shadow that needs more more than one parameters we have to send a hash to the atome

please note that any property can potentially have multiples parameters even the simplest one

    a=box()
    a.set({x: {content: 200, unit: :meters}) 

- Any property are stackable (even the simplest one), in this case we used the 'add' method to stack prop. alternatively it's possible to used an array to stack properties

a simple gradient :

    b=box()
    b.color([{color: :red, top: 0}, {color: :blue, bottom: 0}])


- all properties are treated identically and can be swap at any time.Type mutation is also possible : ex change the type of object from an image to text type

  x=image(:boat)
  x.type(:text) #now the objet is rendered as a text object


here some possible definition of an atome

    a=box({color: red}) # an red box is created
    a.set(smooth: 3) # the box has rounded corner the view is refreshed
    a.set({width: 250},true )# the box is now 250px wide the view is forced to refresh
    a.set({border: :orange, thickness: 3}, false) #the atome is still red the view is not refreshed (no border!)
    a.set([[color: :red, top: 20],[color: :blue, bottom: 0]], false) #the first parameters is an array that contain an array of color to allow a gradient , finally the view is not refreshed the atome remains 'red'.
    a.color([{color: :yellow, top: 0}, {color: :orange, bottom: 0}]) # another way to set the atome property using the property name instead of using the 'set' methods, this time the view is refreshed
    
