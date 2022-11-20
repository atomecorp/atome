# frozen_string_literal: true

# universe method here
class Universe
  @atomes = {}
  @atome_list = []
  @particle_list = []
  @renderer_list = %i[html browser headless server]
  @optionals_methods = {}

  class << self
    attr_reader :atomes, :renderer_list, :atome_list, :particle_list

    def add_to_particle_list(particle = nil)
      instance_variable_get('@particle_list').push(particle)
    end

    def add_optionals_methods(method_name, &method_proc)
      # this method is used to add optional methods
      instance_variable_get('@optionals_methods').merge!({ method_name => method_proc })
    end

    def get_optionals_methods(method_name)
      # this method is used to add optional methods
      instance_variable_get('@optionals_methods')[method_name]
    end

    def add_to_atome_list(atome)
      instance_variable_get('@atome_list').push(atome)
    end

    def add_to_atomes(atome)
      instance_variable_get('@atomes').merge!(atome)
    end

    def app_identity
      # each app hav its own identity, this allow to generate new user identities from th
      @app_identity = 3
      # the identity is define as follow : parentsCreatorID_softwareInstanceID_objetID
      # in this case parents is eve so 0, Software instance number is main eVe server which is also 0,
      # and finally the object is 3 as this the third object created by the main server
    end

    def change_atome_id(prev_id, new_id)
      @atomes[new_id] = @atomes.delete(prev_id)
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

    def current_machine
      platform = RUBY_PLATFORM.downcase
      output = `#{platform =~ /win32/ ? 'ipconfig /all' : 'ifconfig'}`
      current_machine_decision(platform, output)
      # TODO: check the code above and create a sensible identity
    end

    def current_user
      @user
    end

    def current_user=(user)
      # TODO: create or load an existing user
      # if user needs to be create the current_user will be eVe
      @user = user
    end

    def connected
      true
    end
  end
end
