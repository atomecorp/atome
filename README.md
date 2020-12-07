# atome 

 ![](ressources/icons/100.png)
 
Cross platform development
-

 
I - The framework
- 

- atome is a cross platform development environment.all apis work across all platform, to ensure the exact same rendering on Android, Freebsd, linux, MacOs, Web, Windows.

- atome can create build web site, mobile or desktop applications, games, presentations...

- atome is entirely open source as well as all the included libraries.you can do what you want want with it, the whole framework offer a permissive open source licence. 

- atome comes with a powerful multi-rendering engine (it can render any atome object across several different render engine simultaneously )

- atome's solutions can be deploy as a client, a server or both

- the framework is totally hybrid, it means it can be executed in a web browser, a web view or as a full native application

- ***(eVe only) when deploy as a server, any machine can host the server even without running, PHP , ruby, ...

- any application created with it can be used as a data holder, in this case it behave like an universal multimedia document ( think pdf with sound , videos,  animations, interactivity, entirely scriptable, ....)

- the powerful scripting engine can script any atome object on the fly at runtime.

- To install and use : read [documentation](documentation/atome.md)


II Guideline and philosophy
-

The idea behind the atome concept is to have a kind of "universal portable intelligent document", this means : 

- no filetype but instead unique objet called an atome (that could a text, an image, a group of object , a video, an efect, ..). This atome can then  be mnanipulated by any availlable api.

The object uniq architecture bring us lot of new features:
 
- Simplify the automation of batch process as the object is always the same whatever it is (from a simple box thru a video montage to a complex page description) it's always an atome)
- Simplify the development and tests of new tools. Ruby language allow you to script anything on the fly 
- Reduce the number of tools needed for an application. (you dont ever have to wrote a specific tool for a specific medias anymore,  as the same tool now work on any atome.
- and many many other ...
to keep this idea working we have to follow the following rules during atome development :

- All Apis must  run of all targeted platform (their should be no diiference form one platform to another.
- any property or new api must always work on any type of atome, to keep the consistency of the  "atome uniq object" 

III - Open source Software used
-
- Cordova : a cross platform framework to create applications with web view rendering (https://cordova.apache.org)

- Urho3D : is a cross platform 3D rendering and game engine used create native applications(or web rendering) using Webassembly (https://urho3d.github.io)

- FreeBSD : is a Unix environment with jails, allow to create and boot embedded applications on any compatible machine (standard PC, Raspberry, Beaglebone, etc..) (https://www.freebsd.org/fr/)

- Ruby : is the language used to script all atomes apis (https://www.ruby-lang.org)

- Opal : is a ruby gem used to compile the ruby language to JS (https://opalrb.com)

- Roda : is a ruby web framework that hold the server version of atome (https://roda.jeremyevans.net)

- Puma : is a ruby web server to start the server version of atome (https://puma.io)

- Jquery : is a js framework to simplify JS development (https://jquery.com)

- ZimJS : is a html canvas rendering 2D engine (https://zimjs.com)

- Konva : is a html canvas rendering 2D engine (https://konvajs.org)

- FabricJS : is a html canvas rendering 2D engine (http://fabricjs.com)

- ThreeJS :is a html canvas rendering 3D engine (https://threejs.org)

- QAudio : a cross-platform C++ library for Audio Digital Signal Processing (https://cycfi.github.io/q/)

 
