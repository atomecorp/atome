#  frozen_string_literal: true

b = box({ id: :tutu, top: 66 })
c = circle
JS.eval('localStorage.clear();')
Universe.allow_localstorage = true
b.left(0)
c.left(0)
b.left(188)
c.left(33)
c.left(67)
c.left(69)
c.left(99)
b.left(33)
d = text({ data: :hello, left: 444 })

def extract_key_and_write(hash)
  first_level_key = hash.keys.first
  first_value_key = hash[first_level_key].keys.first
  write_value = hash[first_level_key][first_value_key]["write"]
  { first_value_key => write_value }
end

def filter_hash_by_key(original_hash, target_key)
  # Dupliquer le hash pour éviter de modifier l'original
  filtered_hash = original_hash.dup

  # Filtrer les entrées en vérifiant que la clé est présente au niveau souhaité
  filtered_hash.select do |_, outer_value|
    # Vérifier que la valeur contient un hash dont une clé correspond à target_key
    outer_value.values.any? do |inner_value|
      inner_value.keys.include?(target_key)
    end
  end
end

def undo(nb_of_backs, atome_to_target=nil)
  nb_of_backs = nb_of_backs - 2
  a = grab(:view)
  if atome_to_target
    history_to_treat=filter_hash_by_key(a.history, atome_to_target)
  else
    history_to_treat=a.history
  end


  key_found = history_to_treat.keys[history_to_treat.length + nb_of_backs]
  value_found = history_to_treat[key_found]
  if history_to_treat.length + nb_of_backs <= (history_to_treat.length - 1)
    prev_action = extract_key_and_write(value_found)
    prev_action.each do |aid_f, action|
      action.each do |prop_f, val_fw|
        hook(aid_f).send(prop_f, val_fw)
      end
    end
  end
  nb_of_backs # important or it crash
end

@back_nb = 0
c.touch(true) do
  undo(@back_nb, c.aid) # undo only history on c if on all objet :  undo(@back_nb)
  @back_nb = @back_nb - 2
end

b.touch(true) do
  undo(@back_nb)
  @back_nb = @back_nb + 2
end

d.touch(true) do
  puts 'kkkooo'
end