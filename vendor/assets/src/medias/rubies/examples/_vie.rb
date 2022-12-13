# frozen_string_literal: true
a = {
  "modules": [
    {
      "id": "90be7add-12fd-476e-a267-c4ea65cd0bad",
      "name": "Midi in",
      "type_id": "midi",
      "active": "true",
      "input_slots": [
        {
          "id": "948151e4-93c5-428f-a2e9-01f560592a7d",
          "name": "active",
          "unit": "",
          "value": 1
        }
      ],
      "output_slots": [
        {
          "id": "394119f0-886e-4fae-8ae7-d3b187266760",
          "name": "Midi out",
          "unit": ""
        }
      ],
      "position": {
        "x": 0,
        "y": 0,
        "z": 0
      }
    },
    {
      "id": "82a15e17-c93a-4db1-af8a-d79a32c5b590",
      "name": "Sin",
      "type_id": "oscillator",
      "active": "true",
      "input_slots": [
        {
          "id": "f8ba775f-7a30-4728-99df-a6b6edf2666e",
          "name": "active",
          "unit": "",
          "value": 1
        },
        {
          "id": "002a39c1-e0eb-4ef3-9698-b8bc63faf467",
          "name": "freq",
          "unit": "khz",
          "value": 4.40
        }
      ],
      "output_slots": [
        {
          "id": "3d3dd92b-5a61-43bd-b15b-7356224f0fbc",
          "name": "amplitude",
          "unit": "db"
        }
      ],
      "position": {
        "x": 1,
        "y": 0,
        "z": 0
      }
    },
    {
      "id": "6f214581-52ba-484a-a896-1e137305bdd5",
      "name": "mix",
      "type_id": "mixer",
      "active": "true",
      "input_slots": [
        {
          "id": "fbf3a30a-f2a4-49ef-b56c-2830ad5f8917",
          "name": "active",
          "unit": "",
          "value": 1
        },
        {
          "id": "d1948f42-4260-4614-a3b8-2070b50c1e73",
          "name": "input1",
          "unit": "db",
          "value": []
        },
        {
          "id": "82399578-ec95-48f4-a909-d76e27571048",
          "name": "input2",
          "unit": "db",
          "value": []
        }
      ],
      "output_slots": [
        {
          "id": "a1f1cde0-5432-4465-b2a0-d06f759515b0",
          "name": "mixout",
          "unit": "db"
        }
      ],
      "position": {
        "x": 2,
        "y": 0,
        "z": 0
      }
    },
    {
      "id": "bf35dea9-f94e-4b73-9cdc-4c57c20ad996",
      "name": "speak out",
      "type_id": "output",
      "active": "true",
      "input_slots": [
        {
          "id": "fec34afa-a935-4892-949f-bb4ffc312468",
          "name": "active",
          "unit": "",
          "value": 1
        },
        {
          "id": "4b0fc5c3-fc04-4122-905d-aeebc4e06099",
          "name": "input",
          "unit": "db"
        }
      ],
      "output_slots": [],
      "position": {
        "x": 3,
        "y": 0,
        "z": 0
      }
    }
  ],
  "links": [
    {
      "id": "dbde9cd8-462f-4f4a-80c6-cee0b0b9a5eb",
      "sourceComponentId": "90be7add-12fd-476e-a267-c4ea65cd0bad",
      "sourceOutputSlotId": "394119f0-886e-4fae-8ae7-d3b187266760",
      "targetComponentId": "82a15e17-c93a-4db1-af8a-d79a32c5b590",
      "targetInputSlotId": "002a39c1-e0eb-4ef3-9698-b8bc63faf467",
      "active": "true"
    },
    {
      "id": "0bf66202-50fe-4c82-81bd-7c828d1b4edb",
      "sourceComponentId": "82a15e17-c93a-4db1-af8a-d79a32c5b590",
      "sourceOutputSlotId": "3d3dd92b-5a61-43bd-b15b-7356224f0fbc",
      "targetComponentId": "6f214581-52ba-484a-a896-1e137305bdd5",
      "targetInputSlotId": "d1948f42-4260-4614-a3b8-2070b50c1e73",
      "active": "true"
    },
    {
      "id": "929faf01-6320-4273-8557-819f414c9d3a",
      "sourceComponentId": "6f214581-52ba-484a-a896-1e137305bdd5",
      "sourceOutputSlotId": "a1f1cde0-5432-4465-b2a0-d06f759515b0",
      "targetComponentId": "bf35dea9-f94e-4b73-9cdc-4c57c20ad996",
      "targetInputSlotId": "4b0fc5c3-fc04-4122-905d-aeebc4e06099",
      "active": "true"
    }
  ]
}

 Atome.new({ color: { renderers: [:browser], id: :orange_col, type: :color, parents: [], children: [],
                               left: 33, top: 66, red: 0, green: 0.15, blue: 0.7, alpha: 0.6 } })

def get_vie_module(list)
  # puts list[:modules][0].keys
  # puts "---------"
  # module_id = list[:modules][0][:id]
  # module_name = list[:modules][0][:name]
  # module_id = list[:modules][0][:type_id]
  # module_active = list[:modules][0][:active]
  # module_position = list[:modules][0][:position]
  # module_input_slots = list[:modules][0][:input_slots]
  # module_output_slots = list[:modules][0][:output_slots]

  list[:modules].each do |properties, value|
    module_id = properties[:id]
    module_name = properties[:name]
    module_id = properties[:type_id]
    module_active = properties[:active]
    module_position = properties[:position]
    module_input_slots = properties[:input_slots]
    module_output_slots = properties[:output_slots]
    left_pos = 120 + ((module_position[:x].to_i) * (66 + 33+120))
    top_pos=120 + ((module_position[:y].to_i) * (66 + 33))
    a=Atome.new(
      shape: { type: :shape, renderers: [:browser], id: module_id, parents: [:view],children: [], color: :orange,
               left: left_pos, top: top_pos,
               width: 120, height: 120

      }
    )
    a.text({ data:  module_id, visual: {size:  12 }, color: :black, center: :horizontal, width: 120, height: 120})
    a.touch(true) do
      puts  a
    end

    slider=a.circle({width: 20, height: 20, top: 15, left: 15})
    slider.drag( { move: true, inertia: true, lock: :x, constraint: :parent } ) do |pos|
       "module_id : #{module_id}, #{(pos[:left]-left_pos)/100}"
       msg_value=(pos[:left]-left_pos)/100
      `
function send_to_controller(module,value){
console.log(module,value)
}
send_to_controller(#{module_id},#{msg_value});
`
    end
  end

  list[:links]

end

hash_test = a.to_json

json_test = JSON.parse(hash_test)

get_vie_module(json_test)