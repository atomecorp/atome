# # frozen_string_literal: true
b=box

b.touch(:down) do
   A.message({ action: :authentication, data: { table: :user, particles: { email: 'tre@tre.tre', password: 'poipoi' } } }) do |response|
    alert "=> #{response}"
  end
end

#
#
# # # 1 login attempt

wait 1 do
  A.message({ action: :authentication, data: { table: :user, particles: { email: 'tre@tre.tre', password:  'poipoi' } } }) do |response|
    alert "=> #{response}"
  end
  wait 1 do
    A.message({ action: :authentication, data: { table: :user, particles: { email: 'tre@tre.tre', password:  'poipoi' } } }) do |response|
      alert "=> #{response}"
    end
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
