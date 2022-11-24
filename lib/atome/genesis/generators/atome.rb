# frozen_string_literal: true

generator = Genesis.generator

generator.build_atome(:color) do |_params, user_proc|
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end

generator.build_atome(:shadow)
generator.build_atome(:shape)
generator.build_atome(:text)
generator.build_atome(:image)
generator.build_atome(:video)
generator.build_atome(:code)
generator.build_atome(:audio)
