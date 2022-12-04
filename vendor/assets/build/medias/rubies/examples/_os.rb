# frozen_string_literal: true

# module OS
#   def OS.windows?
#     (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
#   end
#
#   def OS.mac?
#     (/darwin/ =~ RUBY_PLATFORM) != nil
#   end
#
#   def OS.unix?
#     !OS.windows?
#   end
#
#   def OS.linux?
#     OS.unix? and !OS.mac? and !OS.opal?
#   end
#
#   def OS.jruby?
#     RUBY_ENGINE == 'jruby'
#   end
#
#   def OS.opal?
#     RUBY_ENGINE == 'opal'
#   end
# end
#
# # alert  OS.linux?