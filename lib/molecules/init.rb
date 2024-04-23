# frozen_string_literal: true

module Molecule

end

class Object
  include Molecule
  # we add a getter for the molecule in standard ruby Object
  # def molecule
  #   @molecule
  # end
end

class Atome
  include Molecule
end


# tests
# new({application: :compose, header: true, footer: true })
#
# new(page: {name: :home, application: :compose, attach: :root })
#
# new(module: {name: :home, application: :compose, attach: :root })






