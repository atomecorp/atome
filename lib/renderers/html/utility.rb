# frozen_string_literal: true

new({ renderer: :html, method: :web }) do |params, &user_proc|
  params
end
new({ renderer: :html, method: :preset, type: :string })
new({ renderer: :html, method: :renderers, type: :string })
new({ renderer: :html, method: :delete, type: :string }) do |params|
  html.delete(id)
end
new({ renderer: :html, method: :hypertext }) do |params|
  html.hypertext(params)
end
new({ renderer: :html, method: :hyperedit }) do |params|
  html.hyperedit(params)
end
new({ renderer: :html, method: :read, type: :string }) do |value, &bloc|
  html.read(id, value)
end

new({ renderer: :html, method: :browse, type: :string }) do |value, &bloc|
  html.browse(id, value)
end

new({ renderer: :html, method: :terminal, type: :string }) do |value, &bloc|
  html.terminal(id, value)
end



new({renderer: :html, method: :match}) do |params, bloc|
  case id
  when :atome || :view
    result = bloc.call
    result = { alterations: result }
    params = params.merge(result)
    html.match(params)
  else
    # code to be written i
  end
end