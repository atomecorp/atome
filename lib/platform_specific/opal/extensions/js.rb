# frozen_string_literal: true

module JS

  def self.eval(string)
    clean_str = string.gsub('return', '')
    result = `eval(#{clean_str})`
    native_result = Native(result)
    native_result
  end

  def self.global
    Native(`window`)
  end

end

