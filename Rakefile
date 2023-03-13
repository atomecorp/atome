# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

task default: :test

task :re_build do
  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')
  `cd test/test_app;atome update`
  `rake build`
  `cd pkg; gem install atome --local`
  puts 'solution re-build!'
  # `cd test/test_app;atome update;atome run`
end

task :run_browser do
  # FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  # FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  # FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')
  # `cd test/test_app;atome update;atome run compile`
  `open test/test_app/src/index.html`
  puts 'atome browser is running'
end

task :cleanup do
  `gem cleanup atome;yes | gem uninstall atome;cd pkg`
end


task :test_server do
  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')
  `gem cleanup atome;yes | gem uninstall atome ;gem build atome.gemspec;cd pkg; gem install atome --local`
  `cd test/test_app;atome update;atome run server`
end


task :run_server do
  `cd test/test_app;atome run server guard`
end

task :refresh do
  FileUtils.copy_entry('vendor/assets/src/medias/rubies/examples/', 'test/test_app/src/medias/rubies/examples/')
  `cd test/test_app;atome build`
  puts "refreshed!"
end

task :open_server do
`open http://127.0.0.1:1430/`
end

task :run_example_server do
  FileUtils.copy_entry('vendor/assets/src/medias/rubies/examples/', 'test/test_app/src/medias/rubies/examples/')
  `cd test/test_app;atome run server`
end


# task :taurification do
#   `cd test/test_app;cargo tauri dev`
# end

task :osx do
  `cd test/test_app;atome run osx guard`
end


task default: :test
