# `three_test()`
wait 1 do
#   `third_d.universe()`
end
# `third_d_test("poilu")`
`third_d.universe()`

def cube(params)
  grab(:view).cube(params)
end

def light(params)
  grab(:view).light(params)
end

class Atome

  def cube(params)
    cube_html(params)
  end

  def light(params)
    light_html(params)
  end

  def light_html(params)
    opal_light(params)
  end

  def cube_html(params)
    opal_cube(params)
  end

  def opal_cube(params)
    # atome_3d_id = { atome_id: (0...8).map { (65 + rand(26)).chr }.join }
    atome_3d_id = params
    `third_d.addCube(#{atome_3d_id}, #{params})`
  end

  def opal_light(params)
    # atome_3d_id = { atome_id: (0...8).map { (65 + rand(26)).chr }.join }
    atome_3d_id = "theCube"
    `third_d.addLight(#{atome_3d_id}, #{params})`
  end

end

c = circle
c2 = circle({x: 300, color: :yellow})
c3 = circle({x: 600, color: :yellowgreen})
c.touch do
  cube("toto")
  # cube({ color: :red })
end

c2.touch do
  # alert :kool
  light({ color: :red })
end

c3.touch do
  # alert :kool
  # `third_d.move("toto")`
  `third_d.touch("toto")`
  `third_d.anim("toto")`
end
