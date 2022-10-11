# frozen_string_literal: true

# FIXME : try avoid type property duplication (it's the key of the hash and also specified in the hash itself)

if RUBY_ENGINE.downcase == 'opal'
  $document.ready do
    Atome.new(shape: { render: [:html], id: :view, type: :shape, parent: :user_view, left: 0, right: 0, top: 0, bottom: 0,
                       color: { render: [:html], id: :c1, type: :color,
                                red: 0.15, green: 0.15, blue: 0.15, alpha: 1 }
    })
  end
else
  Atome.new(shape: { render: [:headless], id: :view, type: :shape, parent: :user_view, left: 0, right: 0, top: 0, bottom: 0,
                     color: { render: [:headless], id: :c1, type: :color,
                              red: 0.15, green: 0.15, blue: 0.15, alpha: 1 }
  })
end

# init basic object for atome environment

# let's create the view port

# Atome.new is used  to create a new atome using best performances but params must be formatted and ordered correctly

# use atome.atome to create a new atome using a more permissive syntax less performances but params must be formatted
# and ordered correctly

# Atome.atome ids the easiest way to  create a new atome
# Atome.atome({
#                      shape: { left: 0, right: 0, top: 0, bottom: 0, id: :view, color: { id: :c1, render: [:headless],
# red: 0.15, green: 0.15, blue: 0.15, alpha: 1 } } })

# puts Atome.current_machine
