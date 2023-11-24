# frozen_string_literal: true
# add renderer html to atome

# headless rendering for atome
class Atome
  def headless(_val = nil); end
end

#  this class is aimed at headless rendering
class Headless

  def initialize(id_found, current_atome)
    @element ||= self
    @id = id_found
    @original_atome = current_atome
  end

end
