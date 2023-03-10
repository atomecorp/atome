# frozen_string_literal: true

class Atome
  def /(val)
    val = val.value if val.instance_of? Atome
    value / val
  end

  def *(val)
    val = val.value if val.instance_of? Atome
    value * val
  end

  def -(val)
    val = val.value if val.instance_of? Atome
    value - val
  end


  def +(val)
    val = val.value if val.instance_of? Atome
    value + val
  end
end
