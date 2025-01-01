#  frozen_string_literal: true
b = box({ drag: true, id: :the_b, top: 63, left: 63 })
c = b.circle({ left: 99, id: :the_c })
b.box({left: 99, top: 99, width: 33, height: 33, id: :second_one})
t = b.text({ data: 'touch the circle', left: 44, top: 44, id: :the_t })
c.touch(:down) do
  b.unfasten([c.id])
  b.color(:green)
  t.data('circle unfasten')
  grab(:infos).data("number of item(s) fasten to the box : #{b.fasten}")
  wait 2 do
    grab(:second_one).delete((true))
    grab(:infos).data("number of item(s) fasten to the box : #{b.fasten}")
    wait 2 do
      b.color(:red)
      t.data('unfasten all attached atomes')
      b.unfasten(:all)
      grab(:infos).data("number of  item fasten to the box : #{b.fasten}")
    end
  end
end

text({id: :infos,left: 155, data: "number of  item fasten to the box : #{b.fasten}"})
