# frozen_string_literal: true

Atome.new(
  image: { renderers: [:browser], id: :image1, type: :image, attach: [:view], path: "./medias/images/red_planet.png", left: 99, top: 120, width: 199, height: 199,
  }
)

image({path: "./medias/images/green_planet.png", left: 33, top: 33})