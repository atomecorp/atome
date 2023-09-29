# frozen_string_literal: true


Universe.atome_list.each do |atome_name|
  pluralised_atome_name = "#{atome_name}s"
  Atome.define_method pluralised_atome_name do |params = nil, &method_proc|
    instance_exec(params, &method_proc) if method_proc.is_a?(Proc)
    @atome[pluralised_atome_name] = params
  end
end
