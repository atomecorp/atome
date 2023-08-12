# class JSDOM
#
#   def initialize
#     # @document = `document`
#     # # @id = id
#     # @dom = { document: @document }
#     self
#   end
#
#   def write(val)
#     `#{@curent_object}.write(#{val})`
#     self
#   end
#
#   def createElement(val)
#     html_object = ""
#     `var html_object = #{@curent_object}.createElement(#{val});
# #{html_object}= html_object;
# `
#
# #     `
# # #{html_object}.innerText = "click me";
# # document.body.appendChild(html_object);
# # `
#
#     @curent_object=html_object
#     self
#   end
#
#   def innerText(val)
#
#     `#{@curent_object}.innerText = #{val}`
#
#         `
#     document.body.appendChild(html_object)
#     `
#   end
#
#   # private def method_missing(name, *args)
#   #   string = "#{@curent_object}.#{name}('#{args}')"
#   #   `eval(#{string})`
#   # end
#
#   def [](val)
#     @curent_object = `eval(#{val})`
#     self
#   end
# end

module JS

  def self.eval(string)
    clean_str = string.gsub('return', '')
    `eval(#{clean_str})`
  end

  def self.global
    Native(`window`)
  end

end

