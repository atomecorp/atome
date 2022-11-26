# frozen_string_literal: true

b = box
# TODO : repair the security flow below
b.atome[:left] = 300
wait 1 do
  b.refresh
end