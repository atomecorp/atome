# size

img = image({content: :moto, x: 66, y: 66})
infos = text({content: "resize the moto!", width: 300})
img.size(60) do |evt|
  infos.content = "width: #{img.width}\nheight: #{img.height},\npointer: #{evt.page_x}/#{evt.page_y}"
end