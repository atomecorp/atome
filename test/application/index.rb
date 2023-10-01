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

b.data
b.touch(true) do
  b.data(:super)
  b.data
  alert b.history[:data]
end
# alert b.history[:data]
# alert Universe.unsync
# Universe.synchronised(23,:dbQKhb876HZggd87Hhsgf )
# alert Universe.unsync
# alert  Universe.current_machine
# alert  Universe.current_user
# alert grab(Universe.current_machine).inspect

# human({id: :jeezs, login: true})

alert "current user: #{Universe.current_user}"

wait 2 do
  set_current_user(:totot)
end

