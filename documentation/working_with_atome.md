<div align="right">

[Main menu](./atome.md)
-
</div>

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

    preset
    black_hole
    device
    intuition
    view
    messenger
    right
    buffer

the buffer is used to store temporary element such as  the position and content of system element like the code editor or the list of element to remain centered when the main windows is resized,
eg:

    b = box({ width: 700, height: 120, drag: true, center: { dynamic: true } })
    c = circle
    t = text({ content: "ok", color: :black, center: :x })

    ATOME.atomise(:batch, [b, c, t])
    grab(:buffer).content[:resize] = [t, b]
    ATOME.resize_html do |evt|
        t.content("#{evt[:width]}  #{evt[:height]}")
            grab(:buffer).content[:resize].each do |element|
            element.center=element.center
        end
    end