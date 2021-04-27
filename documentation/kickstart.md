
<div align="right">

[Main menu](./atome.md)
-
</div>

how to start the app
-

    cordova platform add browser
    cordova plugin add cordova-sqlite-storage
    cordova plugin add cordova-plugin-file
    bundle update
    bundle install
    bundle exec rake run::browser




To run application in development mode :
-

    bundle exec rake run::browser  
    bundle exec rake run::server
    bundle exec rake run::osx
    bundle exec rake run::windows
    bundle exec rake run::android
    bundle exec rake run::electron


to run in production mode :
-

    bundle exec rake production::browser  
    bundle exec rake production::server
    bundle exec rake production::osx
    bundle exec rake production::windows
    bundle exec rake production::android
    bundle exec rake production::electron

trouble shooting :
-

if cordova Cannot find module 'shelljs' error
try:

    sudo cordova platform remove browser


The different modes :
-

- web (opal)
- server (roda)
- stand alone (Freebsd ARM AMD64)
- native (urho 3D)