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
    # alert "html #{atome_id} #{value}"
     jq_get(atome_id).resizable({ handles: 'all' })
    jq_get(atome_id).on('resize') do |evt|
      self.width(jq_get(atome_id).css("width").to_i, false)
      self.height(jq_get(atome_id).css("height").to_i, false)
      if value.instance_of?(Hash)
        proc=value[:proc]
        proc.call(evt.page_x) if proc.is_a?(Proc)
      end
    end
  end

  def rotation_html(value)
    value = value.read
    jq_get(atome_id).css("transform", "rotate(" + value.to_s + "deg)")
  end
end

