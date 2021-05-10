# shape with path example

svg = shape({ path: :atome, drag: true, width: 333, height: 333, atome_id: :the_path})

svg.touch do
  `$('#atome').css({fill: 'blue'}).css({stroke: 'black'})`
end