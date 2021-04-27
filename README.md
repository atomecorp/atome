<img src="https://github.com/atomecorp/atome/raw/development/www/public/medias/images/atome.svg" width="100" />




<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/3.png" width="666" />




#atome


Cross platform development environment
-
- atome is a cross platform development, all apis work identically, to ensure the exact same rendering on Android, Freebsd, linux, MacOs, Web, Windows.

- atome can build web site, mobile or desktop applications, games, presentations, and more...

- atome as well as all the included libraries are entirely open source with a very permissive MIT licence. it means you can do what you want want with it.

- atome comes with a powerful multi-rendering engine (it can render any atome object across several different render engine simultaneously)

- atome's solutions can be deploy as a client, a server or both, as well as boot at startup (Operating System. mode)

- the framework is totally hybrid, it means it can be executed in a web browser, a web view or as a full native application

- You can deploy on any machine you can optionally setup the framework to keep the functionality of a server even if the host machine only serve static files (can't run a sever side language)

- any application created with atome can be used as a data holder, in this case it behave like an universal multimedia document ( think pdf with sound, videos,  animations, interactivity, but entirely editable and scriptable!)

- the powerful scripting engine can script any atome object on the fly at runtime.

prerequisite
-
- ruby
- cordova


####[See full documentation to install the whole framework from scratch ](./documentation/atome.md)


Installation (fast start)
- 
    cordova platform add browser
    cordova plugin add cordova-sqlite-storage
    cordova plugin add cordova-plugin-file
    bundle update
    bundle install
    bundle exec rake run::browser

for more infos:
read atome.md in documentations directory



Guideline and philosophy
-

The idea behind the atome concept is to have a kind of "universal portable intelligent application with documents", this means : 

- no filetype but instead unique objet called an atome (that could a text, an image, a group of object , a video, an effect, ..). This atome can then  be modified by any available api.

The object uniq architecture allow loads of new features:
 
- Simplify the automation of batch process as the object is always the same whatever it is (from a simple box thru a video montage to a complex page description) it's always an atome)
- Simplify the development and tests of new tools. Ruby language allow you to script anything on the fly 
- Reduce the number of tools needed for an application. (you dont ever have to wrote a specific tool for a specific medias anymore,  as the same tool now work on any atome.
- and many many other ...

to keep this idea working we have to follow the following rules during atome development :

- All Apis must run of all targeted platform (their should be no difference form one platform to another.)
- any property or new api must always work on any type of atome, to keep the consistency of the  "atome uniq object" 
#

<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/ruby.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/cordova.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/opal.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/roda.svg" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/freebsd.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/puma.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

Open source technology used
-

- Ruby : is the language used to script all atomes apis (https://www.ruby-lang.org)
  
[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/ruby.png" width="100" />)

- Cordova : a cross platform framework to create applications with web view rendering (https://cordova.apache.org)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/cordova.png" width="100" />)

- Opal : is a ruby gem used to compile the ruby language to JS (https://opalrb.com)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/opal.png" width="100" />)

- Roda : is a ruby web framework that hold the server version of atome (https://roda.jeremyevans.net)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/roda.svg" width="100" />)

- Puma : is a ruby web server to start the server version of atome (https://puma.io)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/puma.png" width="100" />)

- FreeBSD : is a Unix environment with jails, allow to create and boot embedded applications on any compatible machine (standard PC, Raspberry, Beaglebone, etc..) (https://www.freebsd.org/fr/)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/development/documentation/images/logos/freebsd.png" width="100" />)


Open source libraries included
-

- Jquery : is a js framework to simplify JS development (https://jquery.com)

- ZimJS : is a html canvas rendering 2D engine (https://zimjs.com)

- Konva : is a html canvas rendering 2D engine (https://konvajs.org)

- FabricJS : is a html canvas rendering 2D engine (http://fabricjs.com)

- ThreeJS :is a html canvas rendering 3D engine (https://threejs.org)


Optional open source Software related to atome's framework
-
- QAudio : a cross-platform C++ library for Audio Digital Signal Processing (https://cycfi.github.io/q/)

- Urho3D : is a cross platform 3D rendering and game engine used create native applications(or web rendering) using Webassembly (https://urho3d.github.io)

##[Full documentation here](./documentation/atome.md)

 
