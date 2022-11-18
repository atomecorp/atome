# frozen_string_literal: true

# Atome processors
class Atome
  private

  def data_code_processor(data)
    eval data
  end
end
