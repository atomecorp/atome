# frozen_string_literal: true

Atome.new(
  image: { renderers: [:browser], id: :image1, type: :image, attach: [:view], path: "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg", left: 99, top: 320, width: 199, height: 199,
    fasten: []}
)

Atome.new(
  www: { renderers: [:browser], id: :youtube1, type: :www, attach: [:view], path: "https://www.youtube.com/embed/usQDazZKWAk", left: 33, top: 33, width: 199, height: 199,fasten: []}
)

www({path: 'https://www.youtube.com/embed/usQDazZKWAk'})
