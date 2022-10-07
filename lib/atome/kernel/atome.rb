# frozen_string_literal: true

# TODO: Id generator
# Add missing params (methods for noobs only?)
# Sanitizer (methods for noobs only?)
# Sort params (methods for noobs only?)
# Pre-processor
# Renderer
# Store
# Post-processor
# Add or set
# Getter
# parental
# modify html file to be able to add meta data

# This is the main entry for Atome class
class Atome
  include Genesis
  include Sanitizer

  def self.current_machine_decision(platform, output)
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

  def self.current_machine
    platform = RUBY_PLATFORM.downcase
    output = `#{platform =~ /win32/ ? 'ipconfig /all' : 'ifconfig'}`
    current_machine_decision(platform, output)
    # TODO: check the code above and create a sensible identity
  end

  def self.current_user
    @user
  end

  def self.current_user=(user)
    # TODO: create or load an existing user
    # if user needs to be create the current_user will be eVe
    @user = user
  end

  def identity_generator
    { date: Time.now, location: geolocation }
  end

  def additional_helper(params)
    virtual_atome = Atome.new({})
    @additional = virtual_atome
    params.each_with_index do |additional, index|
      new_atome = Atome.new({})
      virtual_atome.instance_variable_set("@virtual#{index}", new_atome)
      additional.each do |param, value|
        new_atome.send(param, value)
      end
    end
  end

  def additional(params = nil)
    if params
      additional_helper(params)
    else
      @additional
    end
  end

  def initialize(params = {})
    # TODO: check if we need to add properties for the root object before sending the params
    # we reorder to place id at the beginning of th hash
    id_found = params.delete(:id)
    params = { id: id_found }.merge(params)
    params.each do |atome, values|
      send(atome, values)
    end
    Universe.atomes_add(self)
  end
end

# initialize Universe
Universe.connected
# Atome.new( identity: {type: :eVe, aui: :a_97987987987})
# puts "is anyone connected"
