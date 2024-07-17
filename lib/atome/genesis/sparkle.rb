# frozen_string_literal: true

Universe.language = :english

# now let's get the default render engine

# Lets create the U.I.
default_render = Essentials.default_params[:render_engines]
Atome.new(
  { renderers: [], aid: :eDen, type: :element, tag: { system: true } }
)
Atome.new(
  { renderers: [], aid: :user_view, type: :element, tag: { system: true },
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

Atome.new(
  { renderers: default_render, id: :back_selection, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.6, green: 0.6, blue: 0.1, alpha: 0.7 }
)

Atome.new(
  { renderers: default_render, id: :text_selection, type: :color, tag: ({ system: true, persistent: true }),
    red: 0.3, green: 0.3, blue: 0.3, alpha: 0.9 }
)

# system object creation
# the black_matter is used to store un materialized atomes
Atome.new(
  { renderers: default_render, aid: :black_matter, type: :shape, attach: :user_view,
    left: 0, right: 0, top: 0, bottom: 0, width: 0, height: 0, overflow: :hidden, tag: { system: true }
  })

# view port
Atome.new(
  { renderers: default_render, aid: :view, type: :shape, attach: :user_view, apply: [:view_color],
    tag: { system: true }, left: 0, right: 0, top: 0, bottom: 0, width: :auto, height: :auto, overflow: :auto,
    # language: :english
  }

)

# unreal port, hold system object and tools
Atome.new(
  { renderers: default_render, aid: :intuition, type: :shape, attach: :user_view, data: {}, tag: { system: true },
    left: 0, top: 0, bottom: 0, width: 0, height: :auto, overflow: :visible
  }
)

machine_id = :dummy_machine
# attention we must used two separate pass to avoid the password to be encode twice
machine_password = { read: { atome: :star_wars }, write: { atome: :star_wars } }

# copy basket
Atome.new({ renderers: [:html], aid: :copy, collect: [], type: :group, tag: { system: true } })

# machine
Atome.new({ renderers: default_render, id: machine_id, type: :machine, password: machine_password,
            name: :macAir, data: { date: '10090717' }, tag: { system: true } })

# user
user_password = { global: :star_win, read: { atome: :star_wars }, write: { atome: :star_wars } }

human({ id: identity_generator, login: true, password: user_password, data: { birthday: '10/05/1996' }, selection: [], attach: :user_view })

Universe.current_machine = machine_id
# the constant A is used to access alla atomes methods
A = Atome.new(
  { renderers: default_render, id: :atome, type: :element, tag: { system: true } }
)
# atome selector / collector
Atome.new({ renderers: [:html], aid: :selector, collect: [], type: :group, tag: { system: true } })

# atome infos
def atome_infos
  puts "atome version: #{Atome::VERSION}"
  puts "device identity: #{Atome::aui}"
  puts "application identity: #{Universe.app_identity}"
  puts "host framework: #{Atome::host}"
  puts "engine: #{Universe.engine}"
  puts "users: #{Universe.users}"
  puts "current user: #{Universe.current_user}"
  puts "machine: #{Universe.current_machine}"
  puts "connected: #{Universe.connected}"
end

# help and example below :

A.example(:left) do
  english = 'here is an example, touch me to get some help, or click the code to exec'
  french = "voici un example, click moi pour de l'aide, ou  clicker le code pour l'executer"
  code = <<STR
b=box
puts b.left
b.left(155)
puts b.left
STR
  example = text({ int8: { english: english, french: french },
                   # language: :english,
                   width: 666 })
  code_text = text({ int8: { english: code },
                     # language: :english,
                     width: 666, top: 33 })
  example.touch(true) do
    example.delete(true)
    help(:left)
  end
  code_text.touch(true) do
    eval(code)
  end
end

# the method below init the user
def atome_genesis
  atome_infos
  server = Universe.current_server
  server ||= 'disconnected'
  puts "server: #{server}"
  return unless server.start_with?('http') && Atome::host.to_sym != :tauri
  Universe.connected = true
  A.server({ address: 'localhost:9292', type: 'ws' })
  A.init_websocket do |msg|
    puts "websocket initialised #{msg}"
  end
  Universe.allow_sync = true
end

# this method is call from JS (atome/communication) at WS connection
def init_database
  # we init the db file eDen
  A.sync({ action: :init_db, data: { database: :eDen } }) do |data|
    Universe.database_ready = data[:data][:message] == 'database_ready'
  end
  # now we populate the DB
  A.sync({ action: :create_db_table, data: { table: :user, type: :string } }) do |_db_state|
  end
  A.sync({ action: :create_db_table, data: { table: :atome } }) do |_db_state|
  end

  A.sync({ action: :create_db_table, data: { table: :history } }) do |_db_state|
  end

  A.sync({ action: :create_db_column, data: { table: :user, column: :email, type: :string, unique: true } }) do |_db_state|
  end
  A.sync({ action: :create_db_column, data: { table: :user, column: :password, type: :string } }) do |_db_state|
  end
  A.sync({ action: :create_db_column, data: { table: :history, column: :aid, type: :string } }) do |_db_state|
  end
  A.sync({ action: :create_db_column, data: { table: :history, column: :particle, type: :string } }) do |_db_state|
  end
  A.sync({ action: :create_db_column, data: { table: :history, column: :value, type: :string } }) do |_db_state|
  end
  A.sync({ action: :create_db_column, data: { table: :history, column: :date, type: :datetime } }) do |_db_state|
  end

  # now we send localstorage content to the server
  Atome.send_localstorage_content

end

def user_login
  password = Black_matter.password
  sync({ action: :authentication, data: { email: 'jeezs@atome.one' } }) do |email|
    puts "email received : #{email}"
  end
  sync({ action: :authorization, data: { password: password } }) do |pass|
    puts "password received : #{pass}"
  end

end

# Universe.allow_localstorage = true # to stop data to be stored in localstorage
# Universe.allow_sync= false # to stop data to be sync on server
touch_allow(false) # this lock the system right click in web view
# add a few default font
A.add_text_visual({ path: 'Roboto', name: 'Roboto-Bold' })
A.add_text_visual({ path: 'Roboto', name: 'Roboto-Thin' })
A.add_text_visual({ path: 'Roboto', name: 'Roboto-LightItalic' })
