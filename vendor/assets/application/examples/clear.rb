# frozen_string_literal: true

# here is how to clear the content of an atome
box
circle({ left: 222 })
wait 2 do
  # as the view is also an atome we will clear it's content
  grab(:view).clear(true)
end