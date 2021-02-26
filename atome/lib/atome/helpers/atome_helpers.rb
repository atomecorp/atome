module AtomeHelpers
  def delete
    if Atome.atomes.key?(atome_id)
      # we remove the atome fom the Atome.atomes's hash
      delete_atome = Atome.atomes.delete(atome_id)
      # adding the deleted atome to the black_hole for later retrieve
      grab(:black_hole).content[atome_id] = delete_atome
      # now we remove the atome from view if it is rendered
      unless delete_atome.render == false
        delete_html
      end
    end
  end
end