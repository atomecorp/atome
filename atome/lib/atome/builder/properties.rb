class Quark
  include Batch
  def initialize(property)
    @property = property
  end

  def read
    @property
  end
  # recipient for created atome
  def self.space
    # this method create a class variable to store all created atomes
    Atome.class_variable_set("@@atomes", {}) # you can access without offense
  end
end