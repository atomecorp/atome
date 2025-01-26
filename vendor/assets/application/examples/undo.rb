#  frozen_string_literal: true
undo_button = text({ data: :undo, id: :undo })
redo_button = text({ data: :redo, id: :redo, left: 39 })
JS.eval('localStorage.clear()')

b = box({ id: :tutu, top: 66 })
c = circle({ id: :the_circle, left: 333 })
color({id: :the_color, blue: 1})
color({id: :the_col, red: 1})
Universe.allow_localstorage = true # starting undo logging
c.top(133)
c.color({id: :the_red_color_applied,  red: 1})
b.left(0)
c.left(90)
c.width(22)
b.left(188)
c.left(33)
c.left(467)
c.height(133)
c.apply(:the_color)
c.height(133)
c.apply(:the_col)
c.color({id: :the_green_color_applied,  green: 1 })
c.left(69)
c.left(0)
c.width(133)
c.text({ data: 'geej', id: :the_text })
c.left(777)

c.left(-12)
b.left(33)

text({ data: :hello, left: 444 })

##########################
Universe.allow_localstorage = false
@back_nb = 0

undo_button.touch(true) do
  new_back_nb = @back_nb - 1
  executed = undo(new_back_nb, c.aid, :undo)
  if executed == false
  else
    @back_nb = new_back_nb
  end
end

redo_button.touch(true) do
  new_back_nb = @back_nb + 1
  executed = undo(new_back_nb, c.aid, :redo)
  if executed == false
  else
    @back_nb = new_back_nb
  end
end

Universe.allow_localstorage = true

####################### code

def extract_key_and_write(hash)
  first_level_key = hash.keys.first
  first_value_key = hash[first_level_key].keys.first
  write_value = hash[first_level_key][first_value_key]["write"]
  { first_value_key => write_value }
end

def filter_hash_by_key(original_hash, target_key)
  filtered_hash = original_hash.dup
  filtered_hash.select do |_, outer_value|
    outer_value.values.any? do |inner_value|
      inner_value.keys.include?(target_key)
    end
  end
end

def undo(nb_of_backs, atome_to_target = nil, mode)
  Universe.allow_localstorage = false

  JS.eval('console.clear()')
  puts "@back_nb : @back_nb: #{@back_nb}"

  a = grab(:view)
  puts a.history
  # Déterminer quel historique utiliser
  history_to_treat = atome_to_target ?
                       filter_hash_by_key(a.history, atome_to_target) :
                       a.history

  # Calculer l'index à récupérer
  target_index = history_to_treat.length + nb_of_backs

  # Valider que l'index est dans les limites
  if target_index >= 0 && target_index < history_to_treat.length
    key_found = history_to_treat.keys[target_index]
    previous_value_found = history_to_treat[key_found]

    prev_action = extract_key_and_write(previous_value_found)
    current_action = history_to_treat[key_found+1]

    # Gérer le cas spécial fasten
    if mode == :undo && prev_action.values[0].keys[0] == :fasten
      child_found = prev_action.values[0][:fasten]
      grab(child_found).attach(:black_matter)
    elsif  mode == :undo && prev_action.values[0].keys[0] == :apply
      current_object= hook(prev_action.keys[0])

      current_object.remove(current_object.apply.last)

    elsif  mode == :redo && prev_action.values[0].keys[0] == :apply
      current_object= hook(prev_action.keys[0])
       current_object.apply(prev_action.values[0][:apply].last)

    else
      # Nouvelle logique pour restaurer les propriétés spécifiques
      properties_to_restore = ['width', 'height']
      restored_properties = {}

      # Parcourir l'historique jusqu'à l'index cible
      history_to_treat.keys[0..target_index].reverse_each do |hist_key|
        hist_entry = history_to_treat[hist_key]
        write_actions = extract_key_and_write(hist_entry)

        write_actions.each do |aid_f, action|
          action.each do |prop_f, val_f|
            if properties_to_restore.include?(prop_f) && !restored_properties.key?(prop_f)
              # Restaurer la propriété en utilisant le setter approprié
              hook(aid_f).send("#{prop_f}=", val_f)
              restored_properties[prop_f] = true
              puts "#{hook(aid_f).id}, #{prop_f} : #{val_f} (restauré)"
            end
          end
        end

        # Si toutes les propriétés ont été restaurées, sortir de la boucle
        break if restored_properties.keys.sort == properties_to_restore.sort
      end

      # Appliquer les autres modifications normalement
      prev_action.each do |aid_f, action|
        action.each do |prop_f, val_f|
          unless properties_to_restore.include?(prop_f)
            puts "#{hook(aid_f).id}, #{prop_f} : #{val_f}"
            hook(aid_f).send("#{prop_f}=", val_f)
          end
        end
      end
    end
    Universe.allow_localstorage = true
    nb_of_backs
  else
    Universe.allow_localstorage = true
    false
  end
end