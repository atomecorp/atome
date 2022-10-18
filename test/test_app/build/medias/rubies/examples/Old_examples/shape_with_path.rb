# shape with path example

svg = shape({ path: :apple, drag: true, width: 333, height: 333, atome_id: :the_path})

svg.touch do
  `$('#the_path').children().css({fill: 'blue'}).css({stroke: 'yellow'})`
end