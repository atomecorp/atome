Atome
-

<img src="./documentation/images/3.png" width="666" />


Atome is powerful engine dedicated to the creation of cross-platform applications, web application and digital medias. 

Cross platform ecosystem
-

- Atome is a cross-platform development framework designed to simplify the creation of mobile and desktop applications, websites, games, presentations, and much more.

- Its primary goal is to make the development process as straightforward and intuitive as possible, allowing developers to focus on building rather than getting lost in technical complexities.
- atome will make it easy to build mobile and desktop applications, websites, games, presentations, and creative applications, including music, graphics, and video apps, and much more
- atome's applications can be deploy as a simple application, a client, a server or both, as well as be booted at startup (Operating System. mode)

- all apis work identically, to ensure you'll have the exact same rendering whatever the host platform (Android, Freebsd, linux, MacOs, Web, Windows).

- atome and all the included libraries are entirely open source with a very permissive MIT licence. it means you can do what you want want with it!

- the framework is totally hybrid, it can be executed as a full blown native application, a native application with a web view, in a web browser or a web view

- Atome can be used in stand alone (offline mode), in cloud mode or both and sync data when required

- it's also possible to publish websites on a static server (without server side language) while using a database and sync data between users

- Anything in atome can be scripted, even on the fly at runtime!

Open source technology included
-

- Ruby : is the language used to script all atome's apis (https://www.ruby-lang.org)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/master/documentation/images/logos/ruby.png" width="100" />)

- Ruby Wasm : is a ruby standard libary used to embed the ruby language in many environments including the web  (https://github.com/ruby/ruby.wasm)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/master/documentation/images/logos/ruby.png" width="100" />)

- Opal : is a ruby gem used to compile the ruby language to JS (https://opalrb.com)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/master/documentation/images/logos/opal.png" width="100" />)

- Roda : is a ruby web framework that push the server version of atome (https://roda.jeremyevans.net)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/master/documentation/images/logos/roda.svg" width="100" />)

- Puma : is a ruby web server to start the backend of atome (https://puma.io)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/master/documentation/images/logos/puma.png" width="100" />)

- FreeBSD : is a Unix platform with a very secure environment (jails), allow to create and boot embedded applications on any compatible machine (standard PC, Raspberry, Beaglebone, etc..), while keeping a very small footprint using the nanoBSD facility of FreeBSD (https://www.freebsd.org/fr/)

[comment]: <> (<img src="https://github.com/atomecorp/atome/raw/master/documentation/images/logos/freebsd.png" width="100" />)

[//]: # (- Tauri : Build smaller, faster, and more secure desktop applications with a web frontend.&#40;https://github.com/tauri-apps/tauri&#41;)

[comment]: <> (<img src="https://avatars.githubusercontent.com/u/54536011?s=200&v=4" width="100" />)

<img src="./documentation/images/logos/ruby.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

[//]: # (<img src="./documentation/images/logos/cordova.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
<img src="./documentation/images/logos/opal.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="./documentation/images/logos/roda.svg" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="./documentation/images/logos/freebsd.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="./documentation/images/logos/puma.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

[//]: # (<img src="./documentation/images/logos/tauri.png" width="100" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add atome

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install atome

## Usage

[Full documentation here](./documentation/atome.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/atomecorp/atome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/atomecorp/atome/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Atome project's codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/atomecorp/atome/blob/master/CODE_OF_CONDUCT.md).


Example website:
-
**[a website showing some apis demo ](http://atome.one)**


Contact:
-
**[queries@atome.one](mailto:contact@atome.one)**

<img src="./documentation/images//atome.svg" width="100" />



---

# Atome Framework: The Future of Multimedia Object Modeling

## Technical Overview

### The Unified Object Model

Atome Framework introduces a revolutionary concept in multimedia object modeling: the Unified Object Model. This model
allows for the seamless creation and manipulation of various multimedia elements like text, images, sound, colors,
videos, vector shapes, and more, all under a single object model.

### Polymorphism

The framework leverages the power of polymorphism, allowing objects to take on multiple forms. This enables a high
degree of flexibility and extensibility in how objects are used and manipulated.

### Features

- **Method Sharing**: All objects share common methods
  like `top`, `left`, `width`, `height`, `red`, `green`, `blue`, `alpha`, `rotate`, and many more.
- **Type Identification**: Easily identify the type of object you're dealing with through the `type` method.
- **Parent-Child Relationships**: Any object can have another object as its child, allowing for complex nested
  structures.
- **Multiple Parenting**: Objects can have multiple parents, enabling versatile and dynamic object relationships.
- **Multiple Rendering**: Objects can be rendered in multiple ways simultaneously, such as text description, audio
  description, and on-screen rendering.
- **Code Rendering**: The framework supports code rendering through technologies like Opal or WebAssembly, offering even
  more versatility.

### Meta-Programming

The framework heavily utilizes meta-programming to avoid code redundancy and to keep the codebase small and efficient.

## Commercial Overview

### Easy to Learn, Powerful to Use

Atome Framework is designed to be easy for novices while also offering an optimized, academic mode for seasoned
developers.

### Open Source and MIT Licensed

The framework is entirely open-source and comes with an MIT license, inviting collaboration and innovation.

### Extensible API

Adding new features is made easy with an automated API system.

## Why Collaborate on GitHub?

- **Innovative Model**: Be part of a revolutionary approach to multimedia object modeling.
- **Community Support**: Benefit from a community of developers for support and feature requests.
- **Career Boost**: Enhance your portfolio by contributing to a cutting-edge project.

## Call to Action

Join us in making multimedia object modeling more efficient, flexible, and powerful than ever before. Star our GitHub
repository, fork it, and send us your pull requests.

---

