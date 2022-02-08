# play videos

button=circle({size: 33, x: 66})
button.text("fullscreen")
v=video({atome_id: :the_video, shadow: {blur: 6 , thickness: 1, x: 0, y:0, color: :black},drag: true, scale: true, x: 96})
v.touch do
  v.play(true)
end

button.touch do
  v.size(grab(:view).convert(:width))
  v.x(0)
  v.y(0)
  wait 2 do
    text ('attempt to pplay fulscreen correct the code below')
    `
var videoElement = document.querySelector("#the_video video");
     if (videoElement.requestFullscreen) {
  videoElement.requestFullscreen();
}

`
  end
end
