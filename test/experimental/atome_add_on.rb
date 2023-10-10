require 'native'
require 'js'

new({ atome: :text, type: :hash })
new({ sanitizer: :text }) do |params|
  if params[:data].instance_of? Array
    params
    additional_data = params.reject { |cle| cle == :data }
    data_found = params[:data]
    parent_text = ''
    data_found.each_with_index do |atome_to_create, index|
      unless atome_to_create.instance_of? Hash
        atome_to_create = { data: atome_to_create, width: :auto }
      end
      if index == 0
        parent_text = text(atome_to_create)
        parent_text.set(additional_data)
      else
        parent_text.text(atome_to_create)
      end
    end
    params = { data: '' }
  else
    params = { data: params } unless params.instance_of? Hash
  end
  params
end

new({ browser: :text, type: :string }) do |_value, _user_proc|
  id_found = @atome[:id]
  if atome[:html] && atome[:html][:tag]
    DOM do
      h2(id: id_found).atome.text
    end.append_to(BrowserHelper.browser_document[:user_view])

  else
    DOM do
      div(id: id_found).atome.text
    end.append_to(BrowserHelper.browser_document[:user_view])
  end

  @browser_object = BrowserHelper.browser_document[id_found]
  @browser_object.style[:position] = 'relative'
  @browser_object.style['white-space'] = 'pre-wrap'

  @browser_type = :div
end

module JS

  def self.eval(string)
    clean_str = string.gsub('return', '')
    `eval(#{clean_str})`
  end

  def self.global
    Native(`window`)
  end

end

def resizer(val)
  # puts "====> #{val}"
end

class Atome

  def self.resizer(event, params, bloc)
    self.instance_exec(event, params, &bloc) if bloc
    # bloc.call(event, params) if bloc.is_a? Proc
  end

  def realWidth
    id_found = self.id
    # JS.global[id_found].innerWidth
    el_found = JS.global[:document].getElementById(id_found)
    el_found.offsetWidth
  end

  def realHeight
    id_found = self.id
    # JS.global[id_found].innerWidth
    el_found = JS.global[:document].getElementById(id_found)
    el_found.offsetHeight
  end

  def realSize
    id_found = self.id
    # JS.global[id_found].innerWidth
    el_found = JS.global[:document].getElementById(id_found)
    { width: el_found.offsetWidth, height: el_found.offsetHeight }
  end

  def on_resize(params, &bloc)
    JS.global[:rubyVM].resizer(" method call from rb and js inside ruby works!!!")

    # Create an instance of your Ruby class
    my_ruby_object = Atome.new

    # Wrap the Ruby object into a JavaScript object
    # js_obj = JS::Object.wrap(my_ruby_object)
    #
    # # Expose the wrapped object to the global JavaScript context
    # JS.global[:myExposedObject] = js_obj

    `
    function handleResize(event) {
    //var windowWidth = window.innerWidth;
   // var windowHeight = window.innerHeight;
//call_ruby_method("Atome.resizer("+#{params}+")");
//rubyVM.resizer("method call from js inside ruby works!!!")
Opal.Atome.$resizer(event,#{params},#{bloc})
}


window.addEventListener("resize", handleResize);
`
    self
  end

  def on(params, &bloc)
    action = "on_re#{params[:event]}"
    send(action, params, &bloc)
  end
end

#################

new(particle: :role)
new(particle: :language)
new(particle: :international)
new(particle: :ratio)
new(particle: :state)
new(particle: :symbol)
new(particle: :coordinate)
new(particle: :zoom)
new(particle: :label)
new(particle: :row)
new(particle: :column)
new(particle: :margin)
new(particle: :automatic)
new(particle: :html)

new({ browser: :symbol, type: :string }) do |value, _user_proc|
  id_found = id
  font = value[:font]
  type = value[:type]
  style = value[:style]
  weight = value[:weight]
  `
      var text_found = document.getElementById(#{id_found});
 text_found.style.fontFamily = #{font};
 text_found.style.fontStyle = #{style};

`
end


