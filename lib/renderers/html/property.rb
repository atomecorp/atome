# frozen_string_literal: true

new({ renderer: :html, method: :diffusion, type: :string })

new({ method: :red, type: :integer, specific: :color, renderer: :html })

new({ method: :green, type: :integer, specific: :color, renderer: :html })

new({ method: :blue, type: :integer, specific: :color, renderer: :html })
new({ method: :alpha, type: :integer, specific: :color, renderer: :html })

new({ renderer: :html, method: :diffusion, type: :string })

# edit
new({ renderer: :html, method: :edit }) do |params|
  html.attr(:contenteditable, params)
  html.update_data(params)
end


new({ method: :clean, renderer: :html, type: :hash }) do |params|
  html.table_clean(params)
end

new({ method: :insert, renderer: :html, type: :hash }) do |params|
  html.table_insert(params)
end



new({ method: :sort, renderer: :html, type: :hash }) do |params|
  html.refresh_table(params)
end

new({ method: :inside, renderer: :html }) do |params|
  if params
    affect.each do |at_found|
      grab(at_found).html.style("box-sizing", 'border-box')
    end
  else
    html.style("boxSizing", ' content-box')
  end
end


new({ method: :align, renderer: :html, type: :hash }) do |params|
  html.style('text-align',  params)
end