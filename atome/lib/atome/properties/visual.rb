# here the methods to add spatial and visuals properties to atome objects
#  the module below contains all the specifics code for properties
class VisualProcessor < UtilityProcessor
  def self.color_pre_processor(params)
    alert (params)
    params
  end

  def self.border_processor(params)
    params
  end
end