def alert(message)
  if grab(:alert)
    alert_box = grab(:alert)
    alert_messages = grab(:alert_content)
    new_content = "#{alert_messages.content}#{message}\n"
    alert_messages.content(new_content)
    # alert.width=alert_messages.width
    alert_box.height = alert_box.height + 20
  else
    style = grab(:UI).content
    alert_box = box(style.merge({ atome_id: :alert }))
    alert_messages = alert_box.text({ x: 9, y: 3, atome_id: :alert_content, content: "#{message}\n" })
    # alert.width=alert_messages.width
    alert_box.height = alert_messages.height
    alert_box.touch do
      alert_messages.content("")
      alert_box.delete(true)
    end
  end
end