# # frozen_string_literal: true
# b=box
# # TODO : resolve SHA256
# # TODO : solve this:
# # b.touch(:down) do
# #   {message: { action: :authentication, data: { table: :user, particles: { email: 'tre@tre.tre' } } } }
# #   {message: { action: :authorization, data: { table: :user, particles: { password: 'poipoi' } } }}
# # end
#
#
#
# # # 1 login attempt
wait 4 do
  alert :now
  A.message({ action: :authentication, data: { table: :user, particles: { email: 'tre@tre.tre', password:  'poipoi' } } }) do |response|
    puts "=> #{response}"
  end
end
#
# 2 account creation attempt
# wait 1 do
#   A.message({ action: :account_creation, data: { email: 'tre@tre.tre', password: 'poipoi', user_id: 'Nico' }  }) do |response|
#     puts response
#   end
#
# end

# string=hello
#
# puts JS.global.sha256(string.to_s)
