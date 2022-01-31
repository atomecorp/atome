# clip example
text("touch the rectangle")
b=box({width: 222, height: 529, x: 333})
s=shape({ path: :the_mask, width: 33, atome_id: :the_path})

b.touch do ||
  b.clip({path: :clipping5})
  b.shadow({ x: 0, y: 0, color: "rgba(0,0,0,1)", blur: 16, thickness: 0 })
end

s.width(333)
