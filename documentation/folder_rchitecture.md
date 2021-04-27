
<div align="right">

###[Main menu](./atome.md)
</div>

Architecture of the folders :
-

The folders dedicated to the atome framework are :

- The app folder : contain all end user scripts

- The atome folder : it contain the atome ruby's gem, this is basically the heart of the framework
  The renderers folders contains rendering engine such as :

        - html for pure js rendering
    
        - Headless for text only rendering of atome's objects
    
        - Vocals to render atomes as audio description
    
        - Urho3D for native rendering

- The documentations folder : it contains infos and documentations of the framework ( how to install it , enhance it or use it )

- The scripts folder contains two files
  one to automatise the install of atome framework
  the other generate ruby's methods that manipulate atome properties (to avoid too much meta programming)

- The rakefile file use to automatise the launch of atome framework

- The index.js in www/public/js/atome_libraries contains js functions and utility for the web rendering of atome engine

- The index.html in www/public/ to initiate the web version of atome

- The app.rb found in the www folder is used for the server version of atome
