# frozen_string_literal: true

# JS add on specific to Opal
module JS

  def self.eval(string)
    clean_str = string.gsub('return', '')
    result = `eval(#{clean_str})`
    Native(result)
  end

  def self.global
    JS.eval('window')
  end

end




