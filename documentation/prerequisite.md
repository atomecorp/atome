<div align="right">

###[Main menu](./atome.md)
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

