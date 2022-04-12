# frozen_string_literal: true

require 'fileutils'
require_relative 'atome/version'
require 'atome/kernel/properties/geometry'
require 'atome/kernel/atome_genesis'
puts "look why this file is already run\n"*9
#  current_path_location = `pwd`.chomp
#  temp_location = '/tmp/com.atome.one'
#  user_script_location=File.join(File.dirname(__FILE__), '../tmp/')
#  Dir.exist?( user_script_location )
#
# FileUtils.mkdir_p temp_location
#
# guard_content = <<~STR
#   guard 'rake', :task => 'build' do
#     watch(%r{^#{current_path_location}})
#   end
# STR
#
# rakefile_content = <<~STR
#   task :build do
#
#   end
# STR
# File.open("#{temp_location}/Guardfile", 'w') { |f| f.write(guard_content) }
# File.open("#{temp_location}/Rakefile", 'w') { |f| f.write(rakefile_content) }
# user_code = File.read("#{temp_location}/Guardfile")

