# here the methods to add spatial and visuals properties to atome objects
#  the module below contains all the specifics code for properties
class VisualProcessor < UtilityProcessor
  def self.color_pre_processor(params)
    alert ("params is : #{params}")
    params
  end

  def self.shadow_post_processor(params)
    alert ("ok for the params")
    params
  end

  def self.overflow_pre_processor(params)
    alert ("ok for the preoverflow")
    params
  end

  def self.overflow_post_processor(params)
    alert ("ok for the postoverflow")
    params
  end


end
