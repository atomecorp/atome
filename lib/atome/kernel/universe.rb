# frozen_string_literal: true

# all created atomes are listed here
class Universe
  def self.app_identity
    # each app hav its own identity, this allow to generate new user identities from th
    @app_identity = 3
    # the identity is define as follow : parentCreatorID_softwareInstanceID_objetID
    # in this case parent is eve so 0, Software instance number is main eVe server which is also 0,
    # and finally the object is 3 as this the third object created by the main server
  end

  def self.initialize
    @atomes = []
  end

  def self.atomes_add(new_atome)
    # @atomes[atome_id] = new_atome
    @atomes << new_atome
  end

  def self.atomes
    @atomes
  end

  class << self
    attr_reader :atomes
  end

  def self.connected
    true
  end

end

