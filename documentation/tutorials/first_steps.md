<span align="right">

[Main menu](../atome.md)
-
</span>
<span align="left">

[back](./tutorials.md)

</span>

Now create your first app:
-

first type the following command in your shell

    atome create myproject

This will create a folder named "myproject" that'll hold your application

in this newly created folder you'll find folder name "application".

open it and it the file named "index.rb" adding the text below :

    text("hellow world!")

you're application is ready to run, to do so, in your shell type the following command:

    cd myproject
    atome run


then your default browser should open and display the "hello world!" text


Now lets build some atomes
-

This easiest way to build is to use the basic api such as the text api used just before :

    text("hellow world!")

below here is how build an atome box and assign a variable

    a=box()

You can also build and Atome using the Atome class
-
This is a more complex way to build atome but way a faster for the machine to process 

    a=Atome.new({preset:box)}

# Here are a few common commands


# 1 - Create a new app

in your terminal type :

    atome create myproject

or atome create :

    atome create myproject production
for production mode (all javascript file will be minimized and uglified)


to overwrite an existing project :

    atome create myproject production force

# 2 - Run the application

go into the project :

    cd myproject

# Run the project :

browser version

- Warning : run the app doesn't refresh the user code, to refresh use the command 'build'
    atome run browser

server version 

- Warning : run the app doesn't refresh the user code, to refresh use the command 'build'
    atome run server

By default the address port is 9292 : http://localhost:9292/index

to run in production mode (faster server mode)

    atome run server production

to update your application ti the latest atome version

    gem update
    atome update

to set the server port

    atome run server port: 9299

Supported platforms with the run command are : browser, server , android, Freebsd, iOS, OSX, Windows

    atome run osx

# compile the user app :

to build your app and re-generate javascript script from ruby type:

    atome build 

for production mode (compressed and uglified javascript files) type :

    atome build production

Please note, is possible to mix multiple options to create run and set some options in one pas:

     atome create myproject server force run production port: 9293


