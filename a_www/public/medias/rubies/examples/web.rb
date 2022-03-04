# web_object example

my_tube = web({html: :iframe, path: "https://www.youtube.com/embed/usQDazZKWAk" })
my_tube.y = 150
my_tube.drag(true)
my_tube.width = 300

web({ html: :image, path: "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg" })
# web can also be specified without supplying any path ex :
# web('<image src="https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg"/>')my_tube.x = 300
