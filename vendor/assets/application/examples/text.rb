# frozen_string_literal

t=text({ data: [{data:  'one', id: 'a1' }, {data:  ' two', id: 'a2' }, { data: ' three', color: :red, id: 'a3'}], component: { size: 33 }, left: 120 })
# text({  data: 'hello for al the people in front of their machine', center: true, top: 120, width: 77, component: { size: 11 } })

grab('a3' ).touch(true) do
  # alert t.fasten
  t.data([{data:  'four', id: 'a4' }, {data:  ' five', id: 'a5' }, { data: ' six', color: :pink, id: 'a3' }])
  # alert t.fasten

  grab('a3' ).blink(:white)
end
# def api_infos
#   {
#   "example": "Purpose of the example",
#   "methods_found": []
# }
# end
