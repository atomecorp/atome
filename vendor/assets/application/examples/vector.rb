 # frozen_string_literal: true

edition = "M257.7 752c2 0 4-0.2 6-0.5L431.9 722c2-0.4 3.9-1.3 5.3-2.8l423.9-423.9c3.9-3.9 3.9-10.2 0-14.1L694.9 114.9c-1.9-1.9-4.4-2.9-7.1-2.9s-5.2 1-7.1 2.9L256.8 538.8c-1.5 1.5-2.4 3.3-2.8 5.3l-29.5 168.2c-1.9 11.1 1.5 21.9 9.4 29.8 6.6 6.4 14.9 9.9 23.8 9.9z m67.4-174.4L687.8 215l73.3 73.3-362.7 362.6-88.9 15.7 15.6-89zM880 836H144c-17.7 0-32 14.3-32 32v36c0 4.4 3.6 8 8 8h784c4.4 0 8-3.6 8-8v-36c0-17.7-14.3-32-32-32z"

v = vector({ data: { path: { d: edition, id: :p1, stroke: :black, 'stroke-width' => 37, fill: :red } } })

wait 1 do
  v.data([{ circle: { cx: 300, cy: 300, r: 340, id: :p2, stroke: :blue, 'stroke-width' => 35, fill: :yellow } }, { circle: { cx: 1000, cy: 1000, r: 340, id: :p2, stroke: :green, 'stroke-width' => 35, fill: :yellow } }])
  wait 1 do
    v.color(:cyan) # colorise everything with the color method
    wait 1 do
      v.shadow({
                 id: :s4,
                 left: 20, top: 0, blur: 9,
                 option: :natural,
                 red: 0, green: 1, blue: 0, alpha: 1
               })
      wait 1 do
        wait 1 do
          v.component(p2: { fill: :blue, 'stroke-width' => 33 })
        end
        v.component(p2: { fill: :blue, 'stroke-width' => 122 })
        wait 1 do
          v.data({})
          wait 1 do
            v.data({ circle: { cx: 300, cy: 300, r: 340, id: :p2, stroke: :blue, 'stroke-width' => 99, fill: :yellowgreen } })
          end
        end
      end
      v.left(222)
    end
  end
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "1",
    "1L694",
    "2",
    "2c",
    "3",
    "3l",
    "4",
    "4L687",
    "5",
    "5L431",
    "6",
    "7",
    "8",
    "8c",
    "8l423",
    "9",
    "9L256",
    "9c",
    "9c3",
    "9s",
    "9z",
    "color",
    "component",
    "data",
    "left",
    "shadow"
  ],
  "1": {
    "aim": "The `1` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `1`."
  },
  "1L694": {
    "aim": "The `1L694` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `1L694`."
  },
  "2": {
    "aim": "The `2` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `2`."
  },
  "2c": {
    "aim": "The `2c` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `2c`."
  },
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "3l": {
    "aim": "The `3l` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3l`."
  },
  "4": {
    "aim": "The `4` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `4`."
  },
  "4L687": {
    "aim": "The `4L687` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `4L687`."
  },
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
  "5L431": {
    "aim": "The `5L431` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5L431`."
  },
  "6": {
    "aim": "The `6` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `6`."
  },
  "7": {
    "aim": "The `7` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `7`."
  },
  "8": {
    "aim": "The `8` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `8`."
  },
  "8c": {
    "aim": "The `8c` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `8c`."
  },
  "8l423": {
    "aim": "The `8l423` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `8l423`."
  },
  "9": {
    "aim": "The `9` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9`."
  },
  "9L256": {
    "aim": "The `9L256` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9L256`."
  },
  "9c": {
    "aim": "The `9c` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9c`."
  },
  "9c3": {
    "aim": "The `9c3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9c3`."
  },
  "9s": {
    "aim": "The `9s` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9s`."
  },
  "9z": {
    "aim": "The `9z` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `9z`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "component": {
    "aim": "The `component` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `component`."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "shadow": {
    "aim": "The `shadow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shadow`."
  }
}
end
