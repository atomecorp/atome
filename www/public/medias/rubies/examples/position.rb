# position

box({x:200, y:100, color: :green})
text({content: "i'm not fixed!", x:20, y: 96, color: :orange})
text({content: "drag the red circle out the window this text will remain fixed in the window",width: 39, x: 66, position: :fixed})
c = circle({x: 300, y: 69})
c.drag(true)