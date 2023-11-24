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
# # TODO FIXME :
# #monkey patch below
# require "native"
# class Hash
#   def to_n
#     %x{
#         var result = {};
#         Opal.hash_each(self, false, function(key, value) {
#           result[#{Native.try_convert(`key`, `key`)}] = #{Native.try_convert(`value`, `value`)};
#           return [false, false];
#         });
#
#         return result;
#       }
#   end
# end



