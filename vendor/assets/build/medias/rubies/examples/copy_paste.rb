# Copy paste example
b = box()
c = circle({ color: ({ alpha: 0.2 }) , x: 300})
c.copy
b.copy

wait 1 do
  b.delete(true)
end

wait 2 do
  c.paste(:properties)
end

wait 4 do
  grab(:view).clear
end


wait 6 do
  grab(:view).paste(:all)
end

# wait 1 do
#   b.delete(true)
# end
# wait 2 do
#   grab(:view).paste
#   wait 2 do
#     grab(:view).paste
#     wait 2 do
#       grab(:view).paste
#     end
#   end
# end