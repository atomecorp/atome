# frozen_string_literal: true

#old code below
# require "bundler/gem_tasks"
# require "rake/testtask"
#
# Rake::TestTask.new(:test) do |t|
#   t.libs << "test"
#   t.libs << "lib"
#   t.test_files = FileList["test/**/test_*.rb"]
# end
#
# task default: :test

task :test do
  FileUtils.copy_entry('vendor/assets/build/js/atome/', 'test/test_app/build/js/atome/')
  `gem cleanup atome;yes | gem uninstall atome ;gem build atome.gemspec;gem install atome`
  `cd test/test_app;atome update;atome run guard`
end

task default: :test
