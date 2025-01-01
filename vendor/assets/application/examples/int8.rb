# frozen_string_literal: true

# t = text({ int8: { english: :hello, french: :salut, deutch: :halo } })

# wait 1 do
#   t.language(:french)
#   wait 1 do
#     t.language(:english)
#     # data is updated to the latest choice
#     puts t.data
#     wait 1 do
#       t.data(:hi)
#     end
#   end
# end

Universe.translation[:hello] = { english: :hello, french: :salut, deutch: :halo }

b = box({ left: 155,
          drag: true,
          id: :boxy })


b.text({ data: :hello, id: :t1, position: :absolute, color: :black })
t2 = b.text({ data: :hello, id: :t2, left: 9, top: 33, position: :absolute })



Universe.language = :french
wait 2 do
  t2.refresh
  Universe.language = :deutch
  wait 2 do
  grab(:boxy).refresh
  end
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "data",
    "language",
    "refresh",
    "text",
    "translation"
  ],
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "language": {
    "aim": "The `language` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `language`."
  },
  "refresh": {
    "aim": "The `refresh` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `refresh`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "translation": {
    "aim": "The `translation` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `translation`."
  }
}
end
