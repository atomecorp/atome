module IdentityProcessor
  def atome_id_pre_processor(params)
    alert :poipoipoipo
    params
  end
  def atome_id_processor(params)
    alert "atome_id DSP is #{params}"
    params
  end
end