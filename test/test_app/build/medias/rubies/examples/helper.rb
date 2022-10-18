############################## help ###########@#######################

class Atome
  def help(property, view = :raw)
    reader("./medias/utils/infos/#{property}.rb") do |file_content|
      case view
      when :raw
      when :formated
        categorised_methods = {}
        ATOME.methods_categories.each do |key, values|
          values.each do |value|
            categorised_methods[value] = key
          end
        end
        categories = { categories: categorised_methods[property] }
        eval_file_content = eval(file_content)
        file_content = eval_file_content.merge(categories)

        categories = file_content[:categories]
        descriptions = file_content[:descriptions]
        params = file_content[:params]
        tips = file_content[:tips]
        examples = file_content[:examples]
        todos = file_content[:todos]
        tests = file_content[:tests]
        bugs = file_content[:bugs]
        tutorials = file_content[:tutorials]
        links = file_content[:links]
        documentation = file_content[:documentation]

        b = Object.box({ width: 300, height: 600, smooth: 6, shadow: { invert: true }, color: { alpha: 0.3 }, x: 3, parent: :intuition, drag: true })
        # b.drag(true)
        b.text({ content: property, x: 9, disposition: { y: 3 }, visual: 30 })
        b.text({ content: "type: #{categories}", x: 15, disposition: { y: 3 } })
        b.text({ content: "examples:", x: 15, disposition: { y: 3 } })

        examples.each_with_index do |example, index|
          ex = b.text({ content: "#{index} : test", x: 33, disposition: { y: 3 }, color: :orange })
          demo_code = b.text({ content: example[1].to_s, x: 66, disposition: { y: 3 } })
          demo_code.edit(true)
          ex.touch do
            Object.clear(:view)
            code_extracted = if demo_code.content.q_read.instance_of?(Hash)
                               # todo: add internalisation below not .values[0]
                               demo_code.content.q_read.values[0]
                             else
                               demo_code.content.q_read
                             end
            Object.instance_eval(code_extracted)
          end
        end
        clear_view = b.text({ content: "clear", xx: 33, disposition: { y: 3 }, color: :orange })
        clear_view.touch do
          grab(:view).clear(true)
        end
      else
        # we send to the requested method
        Atome.send(view, file_content)
      end
    end
  end
end

ATOME.help(:width, :formated)
