# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

task default: :test

task :test_browser do
  FileUtils.copy_entry('vendor/assets/build/js/', 'test/test_app/build/js/')
  FileUtils.copy_entry('vendor/assets/build/css/', 'test/test_app/build/css/')
  FileUtils.copy_entry('vendor/assets/build/medias/', 'test/test_app/build/medias/')
  `gem cleanup atome;yes | gem uninstall atome ;gem build atome.gemspec;gem install atome`
  `cd test/test_app;atome update;atome run guard`
end



task :test_server do
  FileUtils.copy_entry('vendor/assets/build/js/', 'test/test_app/build/js/')
  FileUtils.copy_entry('vendor/assets/build/css/', 'test/test_app/build/css/')
  FileUtils.copy_entry('vendor/assets/build/medias/', 'test/test_app/build/medias/')
  `gem cleanup atome;yes | gem uninstall atome ;gem build atome.gemspec;gem install atome`
  `cd test/test_app;atome update;atome run server`
end

task :run_browser do
  `cd test/test_app;atome run guard`
end

task :run_server do
  `cd test/test_app;atome run server guard`
end

task :run_example do
  FileUtils.copy_entry('vendor/assets/build/medias/rubies/examples/', 'test/test_app/build/medias/rubies/examples/')
  `cd test/test_app;atome run `
end

task :run_example_server do
  FileUtils.copy_entry('vendor/assets/build/medias/rubies/examples/', 'test/test_app/build/medias/rubies/examples/')
  `cd test/test_app;atome run server `
end


task default: :test
