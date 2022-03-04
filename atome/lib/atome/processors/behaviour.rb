#module Processors
module Processors

  def animation_pre_processor params
    unless params.instance_of? Array
      [params]
    end
  end
end