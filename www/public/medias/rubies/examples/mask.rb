# mask example
i=image({ content: :beach , size: 666})
i.touch do ||
  i.mask({content: :atome, repeat: :y, size: 333, position: :top})
end
