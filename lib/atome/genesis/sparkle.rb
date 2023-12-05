# frozen_string_literal: true

# now let's get the default render engine

# Lets create the U.I.

default_render = Essentials.default_params[:render_engines]
Atome.new(
  { renderers: [], id: :eDen, type: :element, tag: { system: true } }
)
Atome.new(
  { renderers: [], id: :user_view, type: :element, tag: { system: true },
    attach: :eDen }
)

# color creation
Atome.new(
  { renderers: default_render, id: :view_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.15, green: 0.15, blue: 0.15, alpha: 1, top: 12, left: 12, diffusion: :linear }
)

Atome.new(
  { renderers: default_render, id: :shape_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.4, green: 0.4, blue: 0.4, alpha: 1 }
)

Atome.new(
  { renderers: default_render, id: :box_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.5, green: 0.5, blue: 0.5, alpha: 1 }
)

Atome.new(
  { renderers: default_render, id: :invisible_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0, green: 0, blue: 0, alpha: 1 }
)

Atome.new(
  { renderers: default_render, id: :text_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.9, green: 0.9, blue: 0.9, alpha: 1 }
)

Atome.new(
  { renderers: default_render, id: :circle_color, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }
)

# system object creation
# the black_matter is used to store un materialized atomes
Atome.new(
  { renderers: default_render, id: :black_matter, type: :shape, attach: :user_view,
    left: 0, right: 0, top: 0, bottom: 0, width: 0, height: 0, overflow: :hidden, tag: { system: true }
  })

# view port
Atome.new(
  { renderers: default_render, id: :view, type: :shape, attach: :user_view, apply: [:view_color],
    tag: { system: true }, left: 0, right: 0, top: 0, bottom: 0, width: :auto, height: :auto, overflow: :auto,
  }

)

# unreal port, hold system object and tools
Atome.new(
  { renderers: default_render, id: :intuition, type: :shape, attach: :user_view, tag: { system: true },
    left: 0, top: 0, width: 0, height: 0, overflow: :visible
  }
)

machine_id = :dummy_machine
# attention we must used two separate pass to avoid the password to be encode twice
machine_password = { read: { atome: :star_wars }, write: { atome: :star_wars } }
user_password = { read: { atome: :star_wars }, write: { atome: :star_wars } }

# copy basket
Atome.new({ renderers: [:html], id: :copy, collect: [], type: :group, tag: { system: true } })


#machine
Atome.new({ renderers: default_render, id: machine_id, type: :machine, password: machine_password,
            name: :macAir, data: { date: '10090717' }, tag: { system: true } })

#user
human({ id: :anonymous, login: true, password: user_password, data: { birthday: '10/05/1996' },selection: [], tag: { system: true } , attach: :user_view })

Universe.current_machine = machine_id
# the constant A is used to access alla atomes methods
A = Atome.new(
  { renderers: default_render, id: :atome, type: :element, tag: { system: true } }
)
# atome infos
def atome_infos
  puts "atome version: #{Atome::VERSION}"
  puts "device identity: #{Universe.app_identity}"
  puts "application identity: #{Atome::aui}"
  puts "host framework: #{Atome::host}"
  puts "engine: #{Universe.engine}"
  puts "users: #{Universe.users}"
  puts "current user: #{Universe.current_user}"
  puts "machine: #{Universe.current_machine}"
  server = Universe.current_server
  server ||= 'disconnected'
  puts "server: #{server}"
end

atome_infos
