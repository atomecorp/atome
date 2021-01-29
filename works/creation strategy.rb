def mac_address
  platform = RUBY_PLATFORM.downcase
  output = `#{(platform =~ /win32/) ? 'ipconfig /all' : 'ifconfig'}`
  case platform
  when /darwin/
    $1 if output =~ /en1.*?(([A-F0-9]{2}:){5}[A-F0-9]{2})/im
  when /win32/
    $1 if output =~ /Physical Address.*?(([A-F0-9]{2}-){5}[A-F0-9]{2})/im
    # Cases for other platforms...
  else nil
  end
end

puts mac_address

connect({user: :toto, pass: "*****", machine: "00:3e:e1:be:0f:23"})


eDen.load(user: :toto, pass: "*****")



# wrong pass
eDen.machine.send({type: :alert})

#dont exist creation
eDen.save({user: :toto, pass: "*****", creation: "2021-01-29 17:21:37 +0100", machine: "00:3e:e1:be:0f:23", type: :human})


b=box()
s=script("b=box();b.color(:red)")
save(b)
#=>{}