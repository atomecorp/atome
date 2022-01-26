<span align="right">

[Main menu](../atome.md)
-
</span>
<span align="left">

[back](./tutorials.md)

</span>


in www/public/medias folder, edit app.rb and replace it's content with the following lines :
(in the future the app.rb will be placed in app directory at the root of the framework)

    text("hellow world!")


Assuming you've [installed](../installation/kickstart.md) all the required files and atome

just open your terminal and type : bundle exec rake run browser

your default browser should open and display a classical "hello world!" message 


There two possibles ways to build an atome object:
-


 - using the Atome class

   a=Atome.new(:box)


- or the lazy the way using preset

  a=box()