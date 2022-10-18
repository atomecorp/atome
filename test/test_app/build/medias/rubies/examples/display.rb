# the display API is used both to visualize an object or not but also when displaying atome in a special way : cf VR mode
# this API must be umerge with the render API (for list mode etc..)
# attention : "render" false remove the object from the DOM while "display" jsut make it invisible on the screen, We may
# keep the two behaviors

b=box({id: :toto, color: :green, display: false, atome_id: :the_box})
# b=box({id: :toto, color: :green, display: :none})
# b.display(true)
wait 2 do
  b.display(true)
end

b.touch do
  # b.display(false)
  b.render(false)
  wait 4 do
    b.render(true)
  end
end