class Nucleon
  include Utilities
  include Properties
  include VisualProcessor
  include SpatialProcessor
  include EventProcessor
  include HelperProcessor
  include AudioProcessor
  include GeometryProcessor
  include EffectProcessor
  include IdentityProcessor
  include MediaProcessor
  include HierarchyProcessor
  include CommunicationProcessor
  include UtilityProcessor
  include Renderer
  def initialize(params = nil, refresh = true)
    # if no params is sent we create a default property hash with type set to particle
    params ||= {type: :particle}
    # if no type is found in the params we use particle by default
    params[:type] = :particle unless params[:type]
    # We generate the atome_id below if not sended by user
    if params[:atome_id].nil?
      atome_id = "a_#{object_id}".to_sym
      params[:atome_id] = atome_id
    end
    # We generate the id below if not sended by user
    if params[:id].nil?
      id = if params[:preset]
        "#{params[:preset]} #{object_id}".to_sym
      else
        "#{params[:type]} #{object_id}".to_sym
      end
      params[:id] = id
    end
    # we reorder the properties to be treated in the correct order
    params = reorder_properties(params)
    # we create an array to store the correctly formatted params
    formatted_params = {}
    # now we parse and send the collected properties to the atome
    params.each_key do |property|
      if params[:type][:value] == :buffer
        puts "treatment to come"
      else
        analysed_params = (method_analysis property, params[property], nil)
        formatted_params[analysed_params.keys[0]] = analysed_params.values[0]
      end
    end
    # now we add the new atome to the atomes's list
    Atome.class_variable_get("@@atomes") << self
    # and now we render if needed
    unless params[:render] == false
      # we reformat the datas so the atome_id is the key
      render_properties({formatted_params[:atome_id][:value] => formatted_params})
    end
  end

  def self.atomise
    Atome.class_variable_set("@@atomes", []) # you can access without offense
  end

  def self.atomes
    Atome.class_variable_get("@@atomes") # you can access without offense
  end
end