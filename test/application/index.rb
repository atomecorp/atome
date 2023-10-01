# require './examples/attach'
def Users
  @user = []
end

# new({particle: :validated, type: :boolean})
new ({ particle: :protected })
# current_machine=machine({id: :my_mac, name: :macAir, data: {users: []}})
# current_user=human( {protected: :data,id: :me, name: :jeezs, data: {name: 'jeezs', password: '********'}})
# current_user.id(:titi)
# alert current_user.inspect
# wait 2 do
#   current_user.set({id: :tutu})
#   current_user.set({name: :okoko})
#   # alert current_user.inspect
# end
# current_machine.data(:hello)
# wait 1 do
#   current_machine.data(:salut)
#   wait 1 do
#     current_machine.data(:so_cool)
#     alert current_machine.history
#   end
# end
b = box
b.data(:kool)
alert b.history[:data]
b.data
b.touch(true) do
  b.data(:super)
  b.data
  alert b.history[:data]
end

# puts "my machine : #{current_machine.name}"
# puts "my machine : #{current_machine.id}"

