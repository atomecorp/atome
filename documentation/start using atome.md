# 1 - Create a new app

in your terminal type : 
    
    atome create myproject

or atome create : 

    atome create myproject production
for production mode (all javascript file will be minimized and uglified)

# 2 - Run the application

go into the project :

    cd myproject

Run the project :
  browser version

    atome run browser

server version

    atome run server

possible options to run the app are : browser, server , android, Freebsd, iOS, OSX, Windows

# compile the app :

 to build your app and re-generate javascript script from ruby type: 

  atome build 

for production mode type :

    atome build production

