# frozen_string_literal: true

# Object  extensions for atome

class String
  def is_json?
    begin
      !JSON.parse(self).nil?
    rescue
      false
    end
  end
end