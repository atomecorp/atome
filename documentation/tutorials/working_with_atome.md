<span align="right">

[Main menu](../atome.md)
-
</span>
<span align="left">

[back](./tutorials.md)

</span>

working with atome framework :
-
any atome properties can be set using a unique value using the syntax below :

    a=box()
    a.color(:red) 
    a.x=200


you can send also the properties to the atome using parenthesis ou the equal sign:

    a=box()
    a.x(300)
    a.y=500

The basic objects

those objects are created by the system at startup : 
-

- preset :  hold the default properties's values for predefined atome  ( box, image text, ...)

- black_hole : a container for all deleted object

- device : Used to identify user device (computer , phone , tablet), also used for Namespace and generate identity of newly created atomes

- intuition : A visual layer used to hold user tools

- view : Where user create and modify there projects

- messenger : A special object used for communication and collaboration

- authorization : this atome is used to authorise or not creation , use, communication and modification of atome

buffer : an atome used to store temporary object, it is used to store temporary element such as  the position and content of system element like the code editor or the list of element to remain centered when the main windows is resized,
eg:


    b = box({ width: 700, height: 120, drag: true, center: { dynamic: true } })
    c = circle
    t = text({ content: "ok", color: :black, center: :x })

    grab(:buffer).content[:resize] = [t, b]
    ATOME.resize_html do |evt|
        t.content("#{evt[:width]}  #{evt[:height]}")
            grab(:buffer).content[:resize].each do |element|
            element.center=element.center
        end
    end