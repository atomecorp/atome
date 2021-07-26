module PropertyHtml
  def address_html(&proc)
    JSUtils.on_adress_change(&proc)
  end

  def map_html(position)
    if position ==true
      # we don't send any params so the js we set the corrdiante to current position
      JSUtils.map(atome_id)
    else
      JSUtils.map(atome_id,position[:longitude],position[:lattitude])
    end
  end
end
