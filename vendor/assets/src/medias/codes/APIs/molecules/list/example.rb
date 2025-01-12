# frozen_string_literal: true


data_f = %w[initiate suspect prospect abandoned finished archived]

d_d_l = box({ id: :the_ddl, width: 160 })
d_d_l.touch(:down) do
  grab(:view).drop_down({ data: data_f, }) do |params|
    d_d_l.clear(true)
    d_d_l.text(params)
  end
end

