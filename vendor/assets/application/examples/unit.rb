# frozen_string_literal: true


box({ left: 50, id: :the_first_box,  color: :blue })
b1=box({ left: 12, id: :the_second_box ,top: 3, unit: {left: '%', width: '%'}, color: :red})
box({ left: 550, id: :the_third_box , unit: {left: :px}, color: :green})
wait 2 do
  b1.unit({left: 'cm'})
  b1.unit({top: 'cm'})
  # b1.unit[:top]='cm'
  puts b1.unit
end



def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "unit"
  ],
  "unit": {
    "aim": "The `unit` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `unit`."
  }
}
end
