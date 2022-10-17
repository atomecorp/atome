# frozen_string_literal: true

# FIXME : try avoid type property duplication (it's the key of the hash and also specified in the hash itself)

# let's create the view port
default_render = if RUBY_ENGINE.downcase == 'opal'
                   :html
                 else
                   :headless
                 end

Sanitizer.default_params[:render] = default_render
Atome.new(
  { shape: { render: [default_render], id: :view, type: :shape, parent: :user_view,
             left: 0, right: 0, top: 0, bottom: 0,overflow: :auto,
             color: { render: [default_render], id: :c1, type: :color,
                      red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } } }
)


# init basic object for atome environment

# Atome.new is used  to create a new atome using best performances but params must be formatted and ordered correctly

# use atome.atome to create a new atome using a more permissive syntax less performances but params must be formatted
# and ordered correctly

# Atome.atome ids the easiest way to  create a new atome
# Atome.atome({
#                      shape: { left: 0, right: 0, top: 0, bottom: 0, id: :view, color: { id: :c1, render: [:headless],
# red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } } })

# WARNING: when using Atome.new syntax , you must get your object using the .atome
# example  to get the atome above : use a.shape.left and not a.left it wont access the physical object

puts "current machine id: #{Atome.current_machine}"

