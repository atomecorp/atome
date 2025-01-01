# frozen_string_literal: true

a = box
a.code(:hello) do
  circle({ left: 333, color: :orange })
end
wait 1 do
  a.run(:hello)
end

