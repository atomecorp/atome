# frozen_string_literal: true

wait 1 do
  box
  wait 1 do
    circle
  end
end