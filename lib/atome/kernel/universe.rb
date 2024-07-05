# frozen_string_literal: true

# universe method here
class Universe
  @counter = 0
  @atomes = {}
  @atomes_ids = {}
  @atome_list = []
  @molecule_list = []
  @particle_list = {}
  @renderer_list = %i[html browser headless server log]
  @sanitizers = {}
  @specificities = {}
  @messages = {}
  @increment = 0
  @categories = %w[atome communication effect event geometry hierarchy identity material
                  property security spatial time utility ]
  @history = {}
  @users = {}
  @help = {}
  @example = {}
  @allow_localstorage = false # temp storage boolean
  @allow_sync = false # temp server storage sync
  @connected = false
  @database_ready = false
  @tools_root = []
  @tools = {}
  @allow_tool_operations = false
  @active_tools = []
  @atome_preset = []
  @translation={}
  @default_selection_style = { border: { thickness: 1, red: 1, green: 0, blue: 0, alpha: 1, pattern: :dotted } }
  @applicable_atomes = %i[color shadow border paint animation]
  # @historicize=false
  class << self
    attr_reader :atomes, :atomes_ids, :renderer_list, :molecule_list, :atome_list, :particle_list, :classes, :counter,
                :atomes_specificities
    attr_accessor :connected, :allow_sync, :allow_localstorage, :database_ready, :edit_mode, :tools, :tools_root,
                  :allow_tool_operations, :active_tools, :atome_preset, :applicable_atomes, :default_selection_style,
                  :translation, :language

    def messages
      @messages
    end

    def store_messages(new_msg)
      @messages[new_msg[:msg_nb]] = new_msg[:proc]
    end

    def delete_messages(msg_to_del)
      @messages.delete(msg_to_del)
    end

    def set_help(particle, &doc)
      @help[particle] = doc
    end

    def get_help(particle)
      @help[particle]
    end

    def set_example(particle, &example)
      @example[particle] = example
    end

    def get_example(particle)
      @example[particle]
    end

    def categories
      @categories
    end

    def add_to_particle_list(particle = nil, type, category)
      # instance_variable_get('@particle_list')[particle] = { type: type, category: category }
      @particle_list[particle] = { type: type, category: category }
    end

    def add_atomes_specificities atome_type_to_add
      @specificities[atome_type_to_add] = {}
    end

    def set_atomes_specificities params
      particle_found = params[:method].to_sym
      specificity = "#{params[:specific]}_".to_sym
      @specificities[params[:specific]][particle_found] = specificity
    end

    def get_atomes_specificities
      @specificities
    end

    def add_sanitizer_method(method_name, &method_proc)
      # this method is used to add sanitizer methods
      @sanitizers.merge!({ method_name => method_proc })
    end

    def get_sanitizer_method(method_name)
      # this method is used to add optional methods
      @sanitizers[method_name]
    end

    def add_to_atome_list(atome)
      @atome_list.push(atome)
    end

    def add_to_molecule_list(molecule)
      @molecule_list.push(molecule)
    end

    def add_to_atomes(aid, atome)
      @atomes[aid] = atome
      @counter = @counter + 1
    end

    def id_to_aid(id, aid)
      @atomes_ids[id] = aid
    end

    def user_atomes
      collected_id = []
      @atomes.each_value do |atome_found|
        collected_id << atome_found.id unless atome_found.tag && atome_found.tag[:system]
      end
      collected_id
    end

    def system_atomes
      collected_id = []
      @atomes.each do |id_found, atome_found|
        collected_id << id_found if atome_found.tag && atome_found.tag[:system]
      end
      collected_id
    end

    def generate_uuid
      uuid = SecureRandom.uuid.gsub('-', '')
      formatted_time = Time.now.strftime("%Y%m%d%H%M%S")
      "#{uuid}#{formatted_time}"
    end

    def app_identity
      # each app has its own identity, this allow to generate new user identities from the
      # unique_id = generate_unique_id_with_timestamp
      @app_identity = generate_uuid
      # the identity is define as follow : parentsCreatorID_softwareInstanceID_objetID
      # in this case parents is eve so 0, Software instance number is main eVe server which is also 0,
      # and finally the object is 3 as this the third object created by the main server
    end

    def delete(id)
      @atomes.delete(id)
    end

    def current_machine_decision(platform, output)
      case platform
      when /darwin/
        ::Regexp.last_match(1) if output =~ /en1.*?(([A-F0-9]{2}:){5}[A-F0-9]{2})/im
      when /win32/
        ::Regexp.last_match(1) if output =~ /Physical Address.*?(([A-F0-9]{2}-){5}[A-F0-9]{2})/im
      else
        # Cases for other platforms...
        'unknown platform'
      end
      platform
    end

    def platform_type
      case RUBY_PLATFORM
      when /win/i
        "Windows"
      when /darwin/i
        "macOS"
      when /linux/i
        "Linux"
      when /unix/i
        "Unix"
      else
        "Plate-forme inconnue"
      end
    end

    def engine
      platform = RUBY_PLATFORM.downcase
      output = if platform == :opal
                 platform = JS.global[:navigator][:userAgent].to_s.downcase
                 platform.include?('win32') ? 'ipconfig /all' : 'ifconfig'
                 # `#{platform =~ /win32/ ? 'ipconfig /all' : 'ifconfig'}`
               elsif platform == 'wasm32-wasi'
                 'ifconfig'
               elsif platform_type == :windows
                 'ipconfig'
               else
                 'ifconfig'
               end
      current_machine_decision(platform, output)
      # TODO: check the code above and create a sensible identity
    end

    def current_server
      JS.global[:location][:href].to_s
    end

    def current_user
      @user
    end

    def add_user=(id)
      @users[id] = true
    end

    def users
      @users
    end

    def current_user=(user_id)
      # TODO: create or load an existing user
      # if user needs to be create the current_user will be eVe
      @user = user_id
    end

    def current_machine
      @machine
    end

    def current_machine=(machine_id)
      # TODO: create or load an existing user
      # if user needs to be create the current_user will be eVe
      @machine = machine_id
    end

    def internet
      if RUBY_ENGINE.downcase != :native
        grab(:view).html.internet
      else
        # write code here for native
      end
    end

    def synchronised(action_nb, pass)
      return unless Black_matter.encode(pass) == Black_matter.password[:read][:atome]

      @history[action_nb][:sync] = true
    end

    def historicize(id, operation, element, params)

      if @allow_sync && Universe.connected
        A.sync({ action: :historicize, data: { table: :user } })
      end

      # if @allow_localstorage && @database_ready
      if @allow_localstorage

        operation_timing = Time.now.strftime("%Y%m%d%H%M%S%3N") + @increment.to_s
        @increment += 1
        @increment = @increment % 100
        if @allow_localstorage.include? element
          JS.global[:localStorage].setItem(operation_timing, "{ #{id} => { #{operation} => { #{element} => #{params} } }, sync: false }")
          @history[@history.length] = { operation_timing => { id => { operation => { element => params } }, sync: false, time: Time.now } }
        end

      end
    end

    def story
      @history
    end
  end
end
