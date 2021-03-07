module PropertylHtml

  def test_html(value, &proc)
    #alert atome_id
    #jq_get(atome_id).css("width")

    #jq_get(JSUtils.device).resize do |evt|
    #  proc.call(evt) if proc.is_a?(Proc)
    #end
    #Element.find(JSUtils.device).resize do |evt|
    Element.find(JSUtils.device).resize do |evt|
      width= jq_get(atome_id).css("width")
      height=jq_get(atome_id).css("height")
    proc.call({width: width,height: height }) if proc.is_a?(Proc)
    end
  end

  def test2_html(value, &proc)
    alert @monitor
    Element.find(JSUtils.device).resize do |evt|
      proc.call(evt) if proc.is_a?(Proc)
    end
  end


end