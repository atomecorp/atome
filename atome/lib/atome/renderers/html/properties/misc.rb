module PropertyHtml
  def address_html(&proc)
    JSUtils.on_adress_change(&proc)
  end
end
