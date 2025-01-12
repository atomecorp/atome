#  frozen_string_literal: true



b=box({color: :red})
b.touch(true) do
  JS.eval('loadFeature()') # found in atome.js file
end

