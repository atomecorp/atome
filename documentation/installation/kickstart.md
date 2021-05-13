
<div align="right">

[Main menu](../atome.md)
-
</div>

Install prerequisite library
-


    ruby :
        on FreeBSD : 
		sudo pkg install ruby
		sudo pkg install ruby27-gems
		sudo gem install bundler
        on Linux :
        on MacOS :  
		\curl -sSL https://get.rvm.io | bash -s stable --ruby
        on windows :
		https://rubyinstaller.org/downloads/

    npm :
        on FreeBSD : 
		sudo pkg install npm
        on Linux :
	on OSX :
	 - using Brew :
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                    brew install NPM
    - using MacPort :
                    sudo port install npm6
	on Windows	  
		install Npm:
            		https://nodejs.org/en/
	
    GIT :	
     	on FreeBSD : 
		pkg install git
        on Linux :
        on MacOS :  
    - using Brew :
		brew install git
	 - using MacPort :
	    sudo port install git
        on windows :
		sudo install git :

To install application:
    git clone https://github.com/atomecorp/atome.git
    cd atome/www/public
    git submodule add https://github.com/atomecorp/third_parties_libraries.git
    #  to later update lib : git submodule update --remote
    sudo npm install -g cordova
    sudo cordova plugin add cordova-sqlite-storage
    sudo cordova plugin add cordova-plugin-file
    sudo cordova platform add browser
    sudo cordova platform add osx
    sudo cordova platform add windows
    sudo cordova platform add android
    sudo cordova platform add electron
    bundle update
    bundle install

Warning on windows :

    Install Visual studio 2017 with feature "universal windows app development tools"
    cordova build windows --arch="x64"



how to start the app
-

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


[Install atome infrastructure](./atome_server.md)
-