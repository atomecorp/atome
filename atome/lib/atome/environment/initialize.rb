# we create the recipient that will store all created atomes instances (cant be read using Atome.atomes)
Atome.sparkle
# now we create the basic universe for the device and it's forthcoming atomes
Device.new
# finally we create an atome constant to access all atomes apis
ATOME = Atome.new({atome_id: :atome, render: false})