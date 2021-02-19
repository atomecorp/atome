class Nucleon < Renderer
  include Utilities
  include Properties
  def initialize(params = nil)
    # if no params is sent we create a default property hash with type set to particle
    params ||= {type: :particle}
    # if no type is found in the params we use particle by default
    params[:type] = :particle unless params[:type]
    # now we check identity data
    check_identtity params
  end

  def check_identtity(params)
    # we generate the atome_id below if not send by user
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
    format_params reorder_properties(params)
  end

  def format_params(params)
    # #we create an array to store the correctly formatted params
    formatted_params = {}
    # now we parse and send the collected properties to the atome
    params.each_key do |property|
      if params[:type][:value] == :buffer
        puts "treatment to come"
      else
        analysed_params = (params_analysis property, params[property], nil)
        formatted_params[analysed_params.keys[0]] = analysed_params.values[0]
      end
    end
    # now we add the new atome to the atomes's list
    Atome.class_variable_get("@@atomes") << self
    # and now we render if needed
    unless params[:render] == false
      # we reformat the data so the atome_id is the key
      render_properties({formatted_params[:atome_id][:value] => formatted_params})
    end
  end

  def self.atomise
    # this method create a class variable to store all created atomes
    Atome.class_variable_set("@@atomes", []) # you can access without offense
  end

  def self.atomes
    # this method return all created atomes
    Atome.class_variable_get("@@atomes") # you can access without offense
  end
end