# frozen_string_literal: true

# let's create the Universe
def eval_protection
  binding
end

# Let's set the default's parameters according to ruby interpreter
if RUBY_ENGINE.downcase == 'opal'
  Essentials.new_default_params({ render_engines: [:browser] })
else
  Essentials.new_default_params({ render_engines: [:headless] })
  eval "require 'atome/extensions/geolocation'", eval_protection, __FILE__, __LINE__
  eval "require 'atome/extensions/ping'", eval_protection, __FILE__, __LINE__
  eval "require 'atome/extensions/sha'", eval_protection, __FILE__, __LINE__
end

# now let's get the default render engine
default_render = Essentials.default_params[:render_engines]

Universe.current_user = :jeezs
puts "application identity: #{Universe.app_identity}"
puts "atome version: #{Atome::VERSION}"
puts "current host: #{Universe.current_machine}"
puts "current user: #{Universe.current_user}"
puts "current server: #{Universe.current_server}"

Atome.new(
  { element: { renderers: [], id: :eDen, type: :element,
               parents: [], children: [] } }
)

Atome.new(
  { element: { renderers: [], id: :user_view, type: :element,
               parents: [:eDen], children: [] } }
)

Atome.new(
  { shape: { renderers: default_render, id: :view, type: :shape, parents: [:user_view], children: [],
             left: 0, right: 0, top: 0, bottom: 0,width: :auto,height: :auto, overflow: :auto,
             color: { renderers: default_render, id: :view_color, type: :color, attach: [:view],
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
# initialize Universe
