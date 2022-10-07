# frozen_string_literal: true

# Main render engine
module Render
  def self.render(atome_type, atome_content, atome, &proc)
    puts "renderer message (#{atome.id}) : #{atome_type}, #{atome_content}, #{proc.class}"
    # atome_content.each do |content|
    #   next unless content[:render]
    #
    #   renderer = if content[:render]
    #                content.delete(:render)
    #              else
    #                render
    #              end
    #   renderer.each do |renderer|
    #     send(renderer, { type: atome_type }.merge(content))
    #   end
    # end
  end

  def self.html(params)
    puts "html : #{params}"
  end

  def self.native(params)
    puts "native : #{params}"
  end
end
