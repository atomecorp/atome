module ProcessorHtml

  def preset_processor params
    properties= grab(:preset).content[params]
    properties.each do |property|
      unless  property[0]== :preset
        self.set ({ property[0] => property[1] })
      end
    end
  end
end