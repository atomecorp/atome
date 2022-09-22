# frozen_string_literal: true
# here is the atome kernel

# todo :
# Id generator
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

# This is the main entry for Atome class

# TODO: modify html file to be able to add meta data
class Atome
  # include AtomeGeometryMethods
  include Genesis
  include Sanitizer

  def self.current_machine
    platform = RUBY_PLATFORM.downcase
    output = `#{(platform =~ /win32/) ? 'ipconfig /all' : 'ifconfig'}`
    case platform
    when /darwin/
      $1 if output =~ /en1.*?(([A-F0-9]{2}:){5}[A-F0-9]{2})/im
      puts :darwin
    when /win32/
      $1 if output =~ /Physical Address.*?(([A-F0-9]{2}-){5}[A-F0-9]{2})/im
      # Cases for other platforms...
    else
      nil
    end
    # todo check the code above and create a sensible identity
    platform
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
    {date: Time.now, location: geolocation}
  end

  def initialize(params = {})
    default_params = { render: [{ engine: [{ value: :html }] }], type: [{ value: :particle }] }
    @aui = "#{Atome.current_user}_#{Universe.app_identity}_#{Universe.atomes.length}"
    params = default_params.merge(params).merge(identity: identity_generator)
    # @atome = {}
    # params.each do |property, value|
    #   @atome[property] = value
    # end
    # puts "Atome.current_user : #{Atome.current_user}"
    Universe.atomes_add(self)
  end



  # def properties_common(property, value, dynamic, optional_processing)
  #   # stack_property, optional_processor
  #   if value.nil?
  #     # the method is a getter
  #     @atome[property]
  #   else
  #     # here we set the value to the property
  #     @atome[property] = value
  #     # atome_router(property, value, dynamic, optional_processing)
  #   end
  # end

end

# initialize Universe
Universe.connected
# Atome.new( identity: {type: :eVe, aui: :a_97987987987})
# puts "is anyone connected"