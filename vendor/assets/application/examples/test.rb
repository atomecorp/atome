m = table({ renderers: [:html], attach: :view, id: :my_test_box, type: :table, apply: [:shape_color],
            left: 333, top: 0, width: 300, smooth: 15, height: 900, overflow: :scroll, option: { header: false },
            component: {
              border: { thickness: 5, color: :blue, pattern: :dotted },
              overflow: :auto,
              color: "white",
              shadow: {
                id: :s4,
                left: 20, top: 0, blur: 9,
                option: :natural,
                red: 0, green: 1, blue: 0, alpha: 1
              },
              # height: 80,
              # width: 12,
              component: { size: 12, color: :black }
            },
            data: [
              { remove_me: :nonono },
              { dfgdf: 1, name: 'Alice', age: 30, no: 'oko', t: 123, r: 654, f: 123, g: 654, w: 123, x: 654, c: 123, v: 654 },
            ]
          })



  m.data( [
            {header_title: nil },
            { dfgdf:nil, name: nil, age: nil, no: nil, t: nil, r: nil, f: nil, g: nil, w: nil, x: nil, c: nil, v: nil },
            { id: nil, name: nil, age: nil },
            { dfg: nil, name: nil, age: nil, no: nil },
            { dfgd: nil, name: nil, age: nil, no: nil },
            {header_title: nil },
            { dfgdf:nil, name: nil, age: nil, no: nil, t: nil, r: nil, f: nil, g: nil, w: nil, x: nil, c: nil, v: nil },
            { id: nil, name: nil, age: nil },
            { dfg: nil, name: nil, age: nil, no: nil },
            { dfgd: nil, name: nil, age: nil, no: nil },
            {header_title: nil },
            { dfgdf:nil, name: nil, age: nil, no: nil, t: nil, r: nil, f: nil, g: nil, w: nil, x: nil, c: nil, v: nil },
            { id: nil, name: nil, age: nil },
            { dfg: nil, name: nil, age: nil, no: nil },
            { dfgd: nil, name: nil, age: nil, no: nil },
            {header_title: nil },
            { dfgdf:nil, name: nil, age: nil, no: nil, t: nil, r: nil, f: nil, g: nil, w: nil, x: nil, c: nil, v: nil },
            { id: nil, name: nil, age: nil },
            { dfg: nil, name: nil, age: nil, no: nil },
            { dfgd: nil, name: nil, age: nil, no: nil },
            {header_title: nil },
            { dfgdf:nil, name: nil, age: nil, no: nil, t: nil, r: nil, f: nil, g: nil, w: nil, x: nil, c: nil, v: nil },
            { id: nil, name: nil, age: nil },
            { dfg: nil, name: nil, age: nil, no: nil },
            { dfgd: nil, name: nil, age: nil, no: nil },
            {header_title: nil },
            { dfgdf:nil, name: nil, age: nil, no: nil, t: nil, r: nil, f: nil, g: nil, w: nil, x: nil, c: nil, v: nil },
            { id: nil, name: nil, age: nil },
            { dfg: nil, name: nil, age: nil, no: nil },
            { dfgd: nil, name: nil, age: nil, no: nil },

          ])
