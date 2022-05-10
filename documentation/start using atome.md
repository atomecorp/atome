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

Run the project :
  browser version

    atome run browser

server version

    atome run server

to run in production mode (faster server mode)

    atome run server production

to set the server port

    atome run server port: 9299

Supported platforms with the run command are : browser, server , android, Freebsd, iOS, OSX, Windows

    atome run osx

# compile the app :

 to build your app and re-generate javascript script from ruby type: 

    atome build 

for production mode (compressed and uglified javascript files) type :

    atome build production

Please note, is possible to mix multiple options to create run and set some options in one pas:

     atome create myproject server force run production port: 9293


