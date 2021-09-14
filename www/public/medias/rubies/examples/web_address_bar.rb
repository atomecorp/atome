# web_address_bar example

t=text({content: "address bar content here",y: 66 })
address_bar_content = text({content:  "touch to change adress bar content", x: 6, y: 6 })

t.touch do
  address_bar_content.address do |e|
    t.content= "#{e[:location]}\n#{e[:state]}"
  end
end

address_bar_content.touch do
  address_bar_content.web({ address: :my_page } )
end