def notification(message, size = 16)
  margin = 6
  if grab(:alert)
    # if message== :clear
    #   grab(:alert).delete
    # else
      alert_box = grab(:alert)
      alert_messages = grab(:alert_content)
      new_content = "#{alert_messages.content}#{message}\n"
      alert_messages.content(new_content)
      alert_box.height = alert_box.height + size
    # end

  else
    style = grab(:UI).content
    alert_box = box(style.merge({ atome_id: :alert , parent: :intuition}))
    alert_content = alert_box.text({ x: margin,
                                     y: margin,
                                     visual: { size: size, path: :arial },
                                     atome_id: :alert_content,
                                     content: "#{message}\n",
                                     color: :white })
    alert_box.height = size + margin * 2
    # alert_box.width = alert_content.width + margin*2
    alert_box.touch do
      alert_content.content("")
      alert_box.delete(true)
    end
  end
  alert_box.xx(33)
  alert_box.yy(33)
end

def notif(message, size)
  notification(message, size)
end