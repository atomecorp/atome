

def capture_pix(name, path)
  # `gphoto2 --capture-image-and-download --filename "../src/medias/images/photos/image-%Y%m%d%H%M%S.jpg"`
  # puts  `pwd`
  # `gphoto2 --capture-image-and-download --filename "../src/medias/images/photos/taritoto.jpg"`
end
capture_pix('../src/medias/images/photos/', 'julia')




bb=box
t=text(:hello)
t2=text({ data: :hello , top: 333 })
# path='../src/medias/images/photos'
bb.touch(true) do
  A.terminal('cd ../src/medias/images/photos;pwd') do |data|
    path = data
    t.data("path  :\n #{data}")
  end
  A.terminal('cd ../src/medias/images/photos;ls') do |data|
    t2.data("content  :\n #{data}")
  end
end


c=circle({left: 333})
c.touch(true) do
  # path= "../src/medias/images/photos/taritoto2.jpg"
  # A.terminal("gphoto2 --capture-image-and-download --filename \\\"#{path}\\\"  ")

  A.terminal('cd ../server;ruby capture.rb')
end
