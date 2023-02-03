# frozen_string_literal: true

require_relative 'lib/atome/version'

Gem::Specification.new do |spec|
  spec.name = 'atome'
  spec.version = Atome::VERSION
  spec.authors = ['Jean-Eric Godard']
  spec.email = ['jeezs@atopme.one']

  spec.summary = 'the creative framework'
  spec.description = 'the creative framework.'
  spec.homepage = 'https://atome.one'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1'
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/atomecorp/atome'
  spec.metadata['changelog_uri'] = 'https://github.com/atomecorp/atome'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'arduino_firmata', '~> 0.3'
  spec.add_runtime_dependency 'faye-websocket', '~> 0.1'
  spec.add_runtime_dependency 'geocoder', '~> 1.8'
  spec.add_runtime_dependency 'guard', '~> 2.1'
  spec.add_runtime_dependency 'guard-rake', '~> 1.0'
  spec.add_runtime_dependency 'image_size', '~> 3.0'
  spec.add_runtime_dependency 'mail', '~> 2.1'
  spec.add_runtime_dependency 'net-ping', '~> 2.0'
  spec.add_runtime_dependency 'opal', '~> 1.5'
  spec.add_runtime_dependency 'atome-opal-browser', '~> 0.3.6'
  spec.add_runtime_dependency 'opal-jquery', '~> 0.4'
  spec.add_runtime_dependency 'parser', '~> 3.1'
  spec.add_runtime_dependency 'puma', '~> 6.0'
  spec.add_runtime_dependency 'rack', '~> 2.2'
  spec.add_runtime_dependency 'rack-unreloader', '~> 1.8'
  spec.add_runtime_dependency 'rake', '~> 13.0'
  spec.add_runtime_dependency 'roda', '~> 3.5'
  spec.add_runtime_dependency 'ruby2js', '~> 5.0'
  spec.add_runtime_dependency 'rufus-scheduler', '~> 3.8'
  spec.add_runtime_dependency 'securerandom', '~> 0.2'
  spec.add_runtime_dependency 'sequel', '~> 5.5'
  spec.add_runtime_dependency 'sqlite3', '~> 1.4'
  spec.add_runtime_dependency 'uglifier', '~> 0.1'
  spec.add_runtime_dependency 'webrick', '~> 1.7.0'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
