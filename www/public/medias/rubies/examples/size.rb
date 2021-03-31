# size

img = image({content: :moto, x: 66, y: 66})
infos = text({content: "resize the moto!", width: 33})
img.size(60) do
  infos.content = "width: #{img.width}\nheight: #{img.height}"
end