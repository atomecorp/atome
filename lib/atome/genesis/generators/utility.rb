# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:renderers)
generator.build_particle(:code)
generator.build_particle(:run) do |params|
  code_found = @atome[:code]
  instance_exec(params, &code_found) if code_found.is_a?(Proc)
end
generator.build_particle(:broadcast)
generator.build_particle(:additional)
generator.build_particle(:data)
generator.build_particle(:delete) do
  Universe.delete(@atome[:id])
end
generator.build_particle(:clear)
generator.build_particle(:path)
generator.build_particle(:schedule) do |date, proc|
  date = date.to_s
  delimiters = [',', ' ', ':', '-']
  format_date = date.split(Regexp.union(delimiters))
  Universe.renderer_list.each do |renderer|
    send("#{renderer}_schedule", format_date, &proc)
  end
end
generator.build_particle(:read) do |file, proc|
  Universe.renderer_list.each do |renderer|
    send("#{renderer}_reader", file, &proc)
  end
end
