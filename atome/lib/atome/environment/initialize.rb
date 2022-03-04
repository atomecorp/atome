# we create the recipient that will store all created atomes instances
# (cant be read using Atome.atomes)
Atome.sparkle
$renderer_list=[:html, :fabric,:headless,:speech, :three, :zim]
$default_renderer=[:html]
# finally we create an atome constant to access all atomes apis
ATOME = Atome.new(atome_id: :atome, render: false, content: {})

# now we create the basic universe for the device and it's forthcoming atomes
Device.new
MESSENGER = grab(:messenger)
# we initialise the websocket to atome.one
web_state(:disconnected)
# we set the websocket address
ATOME.websocket("ws.atome.one", true)
# we load the the keyboard shortcut at startup
# todo : kickstart_keyboard_shortcut make the environment editable which lead to permanently open the keyboard
# on mobile device
# kickstart_keyboard_shortcut



