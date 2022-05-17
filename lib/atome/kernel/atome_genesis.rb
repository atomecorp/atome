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

class Atome
  include AtomeGeometryMethods

  def location
    :clermont
  end

  # def current_machine
  #   platform = RUBY_PLATFORM.downcase
  #   output = `#{(platform =~ /win32/) ? 'ipconfig /all' : 'ifconfig'}`
  #   case platform
  #   when /darwin/
  #     $1 if output =~ /en1.*?(([A-F0-9]{2}:){5}[A-F0-9]{2})/im
  #   when /win32/
  #     $1 if output =~ /Physical Address.*?(([A-F0-9]{2}-){5}[A-F0-9]{2})/im
  #     # Cases for other platforms...
  #   else
  #     nil
  #   end
  #   # todo check the code above and create a sensible identity
  #   platform
  # end

  def self.current_user
    @user
  end

  def self.set_current_user(user)
    # todo : create or load an existing user
    # if user needs to be create the current_user will be eVe
    @user = user
  end

  # def id_generator(number)
  #   charset = Array('A'..'Z') + Array('a'..'z') + Array(0...9)
  #   Array.new(number) { charset.sample }.join
  #   # "#{Atome.current_user}_#{current_machine}_#{location}_#{(Time.now.to_f * 1000).to_i}"
  #   # "object_#{Universe.atomes.length}"
  # end

  def initialize(params = {})
    default_params = { render: [{ engine: [{ value: :html }] }], type: [{ value: :particle }] }
    # primary_id="#{id_generator(9)}_#{params.keys[0]}".to_sym
    aui="#{Atome.current_user}_#{Universe.app_identity}_#{Universe.atomes.length}}"
    puts "aui is : #{aui}"
    params = default_params.merge(params)
    puts params
    @atome = {}
    puts "-----------------"
    params.each do |property, value|
      puts @atome[property]=value
    end
    puts "-----------------"

    Universe.atomes_add(aui, @atome)
  end

  def properties_common(value, property, dynamic, optional_processing)
    # stack_property, optional_processor
    if value.nil?
      # the method is a getter
      @atome[property]
    else
      # here we set the value to the property
      @atome[property] = value
      # atome_router(property, value, dynamic, optional_processing)
    end
  end
end

# initialize Universe
Universe.connected
 # Atome.new( identity: {type: :eVe, aui: :a_97987987987})
puts "is anyone connected"