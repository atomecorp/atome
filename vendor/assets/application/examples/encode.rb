#  frozen_string_literal: true

my_pass = Black_matter.encode('hello')
puts my_pass
checker = Black_matter.check_password('hello,', my_pass)
puts checker