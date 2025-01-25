#  frozen_string_literal: true


b=box({id: :tutu})
c=circle
JS.eval('localStorage.clear();')
Universe.allow_localstorage = true
b.left(188)
c.left(33)
c.left(67)
c.left(69)
c.left(99)
b.left(33)

def extract_key_and_write(hash)
  # Récupérer la première clé de niveau supérieur
  first_level_key = hash.keys.first

  # Récupérer la première clé dans la première valeur
  first_value_key = hash[first_level_key].keys.first

  # Récupérer la valeur associée à "write"
  write_value = hash[first_level_key][first_value_key]["write"]

  # Construire le résultat
  { first_value_key => write_value }
end

wait 2 do
  a=grab(:view)
  key_found = a.history.keys[b.history.length-5] # Obtenir la clé par l'index
  value_found = a.history[key_found] # Obtenir la valeur associée à cette clé
  # alert   value_found

  prev_action= extract_key_and_write(value_found)
  prev_action.each do |aid_f,action |
    # alert action
    # alert hook(aid_f)
      action.each do |prop_f,val_fw|
        hook(aid_f).send(prop_f,val_fw)
      end
  end

  # alert   b.history.keys
  # alert   b.history.keys
end