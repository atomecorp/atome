# web_object example

my_tube = web({ type: :iframe, path: "https://www.youtube.com/embed/usQDazZKWAk" })
my_tube.y = 150
my_tube.drag(true)
my_tube.width = 300

web({ type: :image, path: "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg" })
# web can also be sepecified without supllying any path ex :
# web('<image src="https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg"/>')my_tube.x = 300
