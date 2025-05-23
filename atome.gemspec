# frozen_string_literal: true

require_relative 'lib/atome/version'

Gem::Specification.new do |spec|
  spec.name = 'atome'
  spec.version = Atome::VERSION
  spec.authors = ['Jean-Eric Godard']
  spec.email = ['jeezs@atome.one']

  spec.summary = 'the creative framework'
  spec.description = 'the creative framework.'
  spec.homepage = 'https://atome.one'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1'
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/atomecorp/atome'
  spec.metadata['changelog_uri'] = 'https://github.com/atomecorp/atome/changelog'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.

  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   `git ls-files -z`.split("\x0").reject do |f|
  #     (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
  #   end
  # end
  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   # Utilisez git ls-files pour récupérer les fichiers, puis filtrez-les selon vos besoins
  #   git_files = `git ls-files -z`.split("\x0").reject do |f|
  #     (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
  #   end
  #
  #   # Ajoutez manuellement les fichiers du dossier lib/eVe
  #   eve_files = Dir['lib/eVe/**/*']
  #
  #   # Combine les deux listes de fichiers
  #   git_files + eve_files
  # end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    # Utilisez git ls-files pour récupérer les fichiers, puis filtrez-les selon vos besoins
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']


  # spec.add_runtime_dependency 'artoo', '~> 1.8.2'
  # spec.add_runtime_dependency 'arduino_firmata', '~> 0.3'
  # spec.add_runtime_dependency 'eVe', '~>  0.1.0'
  spec.add_runtime_dependency 'capybara', '~> 3.40.0'
  spec.add_runtime_dependency 'cuprite', '~> 0.15.1'
  spec.add_runtime_dependency 'eventmachine', '~> 1.2.7'
  spec.add_runtime_dependency 'faye-websocket', '~> 0.1'
  # spec.add_runtime_dependency 'ferrum', '~>  0.15.0'
  spec.add_runtime_dependency 'geocoder', '~> 1.8'
  spec.add_runtime_dependency 'guard', '~> 2.1'
  # spec.add_runtime_dependency 'guard-shell', '~> 0.7.2'
  # spec.add_runtime_dependency 'guard-puma', '~> 0.8.1'
  # spec.add_runtime_dependency 'shotgun', '~> 0.9.2'
  spec.add_runtime_dependency 'gems', '~> 1.2'
  spec.add_runtime_dependency 'guard-rake', '~> 1.0'
  # spec.add_runtime_dependency 'rerun', '~> 0.14.0'
  spec.add_runtime_dependency 'image_size', '~> 3.0'
  spec.add_runtime_dependency 'mail', '~> 2.1'
  spec.add_runtime_dependency 'net-ping', '~> 2.0'
  spec.add_runtime_dependency  "opal", "~> 1.8"
  spec.add_runtime_dependency 'parser', '~> 3.1'
  spec.add_runtime_dependency 'puma', '~> 6.0'
  spec.add_runtime_dependency 'rack', '~> 3.1.7'
  spec.add_runtime_dependency 'rack-unreloader', '~> 1.8'
  spec.add_runtime_dependency 'rake', '~> 13.0'
  spec.add_runtime_dependency 'roda', '~> 3.5'
  spec.add_runtime_dependency 'rqrcode', '~> 2.2.0'
  # spec.add_runtime_dependency 'ruby2js', '~> 5.0'
  spec.add_runtime_dependency 'rufus-scheduler', '~> 3.8'
  spec.add_runtime_dependency 'securerandom', '~> 0.2'
  spec.add_runtime_dependency 'sequel', '~> 5.5'
  spec.add_runtime_dependency 'sqlite3', '~> 2.0.2'
  spec.add_runtime_dependency 'uglifier', '~> 0.1'
  # spec.add_runtime_dependency 'atome_eVe', '>= 0.1.0.0.7'
  # spec.add_runtime_dependency 'webrick', '~> 1.7.0'
  # the gem below are need to make the atome server works on Windows
  spec.add_runtime_dependency 'tzinfo-data', '~> 1.2023.4'
  spec.add_runtime_dependency 'win32-security', '~> 0.5.0'
  spec.add_runtime_dependency  'wdm', '>= 0.1.0' if Gem.win_platform?

  # patch because guard have bad dependency
  spec.add_runtime_dependency  'pry', '>= 0.14.2'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
