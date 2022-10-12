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
  `gem cleanup atome;yes | gem uninstall atome ;gem build atome.gemspec;gem install atome`
  `cd test;atome create test_app;cd test_app;atome run`
  # # sleep 3
  # `cd test/test_app;atome run`
  # Opal.append_path "app"
  # File.binwrite "build.js", Opal::Builder.build("application").to_s
end

task default: :test