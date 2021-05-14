def alert(message)
  if grab(:alert)
    alert =grab(:alert)
    alert_messages=grab(:alert_content)
    new_content="#{alert_messages.content}#{message}\n"
    alert_messages.content(new_content)
    # alert.width=alert_messages.width
    alert.height=alert.height+20
  else
    style=grab(:UI).content
    alert=box({atome_id: :alert}.merge(style))
    alert_messages= alert.text({atome_id: :alert_content, content: "#{message}\n"})
    # alert.width=alert_messages.width
    alert.height=alert_messages.height
    alert.touch do
      alert_messages.content("")
      alert.delete(true)
    end
  end
end