module PropertylHtml
  def width_html(value)
    value = value.read
    jq_get(atome_id).css("width", value)
  end

  def height_html(value)
    value = value.read
    jq_get(atome_id).css("height", value)
  end

  def size_html(value)
    value = value.read
    # todo place the code belowin methods before html methods
    if value.instance_of?(Integer) || value.instance_of?(String) || value.instance_of?(Symbol)
      value = {value: value}
    end
    # We treat the Object temporary alogo
    unless value[:value].nil?
      #alert "#{atome_id} : #{self.width} : #{value[:value]}"
      #alert "html #{atome_id} #{value} uniformiser toutes les fonction html  ou lplacer le traitemnent avant html: tritement catcher if string or hash and take decision"
      #self.width(value[value].to_i/100*self.width)
      #self.height(value[value].to_i/100*self.height)
    end

    # dynamic treatment below
    jq_get(atome_id).resizable({handles: 'all'})
    jq_get(atome_id).on('resize') do |evt|
      self.width(jq_get(atome_id).css("width").to_i, false)
      self.height(jq_get(atome_id).css("height").to_i, false)
      if value.instance_of?(Hash)
        proc = value[:proc]
        proc.call(evt) if proc.is_a?(Proc)
      end
    end
  end

  def rotation_html(value)
    value = value.read
    jq_get(atome_id).css("transform", "rotate(" + value.to_s + "deg)")
  end
end

