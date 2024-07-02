# frozen_string_literal: true



a = application({
                  id: :arp,
                  margin: 3,
                })

page1_code = lambda do
  b = box({ id: :ty, left: 90, top: 90, color: :black })
  b.touch(true) do
    b.color(:red)
  end
end

page1 = {
  run: page1_code,
  menu: false,
  id: :page1,
  color: { red: 0.5, green: 0.5, blue: 0.5 },
  name: :accueil,
  # footer: { color: :green, height: 22 },
  header: { color: { red: 0.3, green: 0.3, blue: 0.3 }, height: 90, shadow: { blur: 12, left: 0, top: 0 } },

}

a.page(page1)
c = a.show(:page1)
c.color(:orange)
header = grab(:arp_content_header)
header.color(:orange)
# header.height(66)
# header.subs({ "contact" => { "width" => "33%" }, "project" => { "width" => "33%" }, "calendar" => { "width" => "33%" } })

bloc_to_add = { height: 33, color: :cyan }
bloc_to_add2 = { height: 99, color: :blue }
bloc_to_add3 = { height: 133, color: :red }
bloc_to_add4 = { height: 33, color: :gray }
###########@
grab(:page1).blocks({ direction: :vertical, color: :blue, height: 55, spacing: 6,
                      blocks: { block1: bloc_to_add, block2: bloc_to_add2, block3: bloc_to_add3 } })

grab(:block1).blocks({ direction: :horizontal, color: :orange, spacing: 66, width: 120, top: 0,
                       blocks: { block12: bloc_to_add4, block22: bloc_to_add2, block32: bloc_to_add3 }, distribute: true })
