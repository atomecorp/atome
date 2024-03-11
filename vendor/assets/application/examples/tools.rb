# frozen_string_literal: true

b=box({ top: :auto, bottom: 0})



# b.touch(true) do
#   puts :try
#   # b.touch({ remove: :down })
#   # wait 3 do
#   #   b.touch(:dowm) do
#   #     alert :kool
#   #   end
#   # end
# end

b.touch(:down) do
  puts :dow
  b.touch({remove: :down})

  # wait 3 do
    b.touch(:down) do
      puts 'super'
      b.touch({remove: :down})
    end
  # end
  # b.touch({ remove: :down })
  # wait 3 do
  #   b.touch(:dowm) do
  #     alert :kool
  #   end
  # end
end
