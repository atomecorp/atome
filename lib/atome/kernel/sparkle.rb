# frozen_string_literal: true

class Atome
  include OpalRenderer
end

# init basic object for atome environment

# let's create the view port

# Atome.new is used  to create a new atome using best performances but params must be formatted and ordered correctly
Atome.new({
            shape: { type: :shape, render: [:html], id: :view, left: 0, right: 0, top: 0, bottom: 0,
                     color: { type: :color,
                              render: [:headless], id: :c1, red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } }
          })

# use atome.atome to create a new atome using a more permissive syntax less performances but params must be formatted
# and ordered correctly

# atome.atome ids the easiest way to  create a new atome
# Atome.atome({
#                      shape: { left: 0, right: 0, top: 0, bottom: 0, id: :view, color: { id: :c1, render: [:headless],
# red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } } })

# puts Atome.current_machine
# puts Atome.current_user
