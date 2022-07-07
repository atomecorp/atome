
<span align="right">

[Main menu](../atome.md)
-
</span>

atome explained : the uniq object format
-

 # new atome format

----------------
atome structure :
id: {hash: {key: : value}
aui : {atome: {property: value}

ex: a_01: {color:{x: 33, y: 69, red: 0.1, green: 0.2, blue: 1, alpha: 1: diffusion: :radial}}

user can write: 
a.color(:red)
a.red(0.1)
a.color(color:{x: 33, y: 69, red: 0.1})



an atome is a  property ( position, size, type, etc..)

a single property (atome) can hold multiples properties cf: child property

    b=box({ drag: true, atome_id: :the_box })
    t=text({ content: "touch me to extract me from the box,\nand attach me to the circle ",y: 99, atome_id: :the_text  })
    grab(:the_box).attach(:the_text)
    puts  b.child # =>  ["the_text"]
    

atome's property are mutable even it's type ( useful to display a same atome in different manner, or use the data of the atome as a repository of style, or simply sawp it's functionality while retaining it's properties) 

a single atome can be displayed in different way according it's rendering mode and or it's type. 

EG :
    

    a=image(content: :moto)


<img src="https://github.com/atomecorp/atome/raw/development/www/public/medias/images/moto.png" width="333" />

    a.color(:white) #important else the text xill be transparent
    a.type(:text)
moto

    a.render({mode: :list, list: :property, sort: :alphabetically })
<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/list.png" width="400px" />



- Anything that define an atome is a property.
  any atome can contain an other atome or a group of atome as a property ex :


    b = box({x: 300, drag: true})
    image(:logo)
    c = circle(x: 100)
    b.insert(c.atome_id)
    b.text('hello')
    puts b.child #=> [c, t] (c and t is now a child of b)
    b.touch do
    # b children can be treated in one pass
    # look at child example for more examples
    b.child.color(:green)
    end

Many atome properties can be set using a string or integer, it's a shortcut to set the content property eg :

    text("hello") # equivalent to text({content: "hello"})
    # or
    image(:boat) # shortcut for image({content: :boat})

internally properties are always define using a key-value pair (Hash type) and can be set so :

    text({content: "hello"})

Hash's values can be a String, an Integer, a hash or an array.

The atomiser method allow to modifying atome without interpreting/ refreshing the newly set property.
in this case the atome need rendered to refresh it's content

    b = box()
    b.atomiser({ color: :red })
    b.atomiser({ smooth: 6})

    wait 2 do
      b.render(true)
    end


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
    b=box(width: 33)
    b.color(:red).x(96).blur(3)
    c=circle(color: :red)
    b.color=c.color
    c.y=b.blur
      




- to set a complex property such as shadow that needs more more than one parameters we have to send a hash to the atome

please note that any property can potentially have multiples parameters even the simplest one

    # not implemented need a rework
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

    a=box({color: :red}) # an red box is created
    a.set(smooth: 9) # the box has rounded corner the view is refreshed
    a.set({width: 250},true )# the box is now 250px wide the view is forced to refresh
    a.set({ border: { color: :orange, thickness: 7, pattern: :solid } })

**[- Architecture of the folders](./folder_architecture.md)**
-

**[- logic and datas flows](./datas_flows.md)**
-