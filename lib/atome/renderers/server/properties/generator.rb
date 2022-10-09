# frozen_string_literal: true

# server render methods here
module ServerRenderer
  def render_sever(params, &proc)
    instance_exec(params, &proc) if proc.is_a?(Proc)
    puts "----puts render sever render #{params}"
  end
end
