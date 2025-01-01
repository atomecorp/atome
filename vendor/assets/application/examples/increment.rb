# frozen_string_literal: true

cc=color({red: 1, blue: 0.1,id: :the_col})
b=box({ left: 12, id: :the_first_box, apply: cc.id  })
c=circle({ left: 99, top: 99 })

wait 1 do
  c.increment({left: 33, top: 99})
  b.increment({left: 33, top: 99})
  wait 1 do
    c.increment({width: 33, top: -22})
    b.increment({width: 33, top: -9})
    cc.increment({red: -0.5})
    wait 1 do
      cc.increment({blue: 1})
    end
    # Atome.sync(:ok)
  end
end

# wait 3 do
#   color(:red)
# end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "1",
    "5",
    "id",
    "increment",
    "sync"
  ],
  "1": {
    "aim": "The `1` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `1`."
  },
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "increment": {
    "aim": "The `increment` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `increment`."
  },
  "sync": {
    "aim": "The `sync` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `sync`."
  }
}
end
