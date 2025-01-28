#  frozen_string_literal: true
undo_button = text({ data: :undo, id: :undo })
redo_button = text({ data: :redo, id: :redo, left: 39 })
JS.eval('localStorage.clear()')

b = box({ id: :tutu, top: 66 })
c = box({ id: :the_circle, left: 333 })
color({ id: :the_color, blue: 1 })
color({ id: :the_col, red: 1 })
c.drag(true)

Universe.allow_localstorage = true # starting undo logging
c.top(133)
c.color({ id: :the_red_color_applied, red: 1 })
b.left(0)
c.left(90)
c.width(22)
b.left(188)
c.left(33)
c.left(467)
c.height(133)
c.rotate(20)
c.apply(:the_color)
c.height(133)
c.shadow({ blur: 6 })
c.apply(:the_col)
c.color({ id: :the_green_color_applied, green: 1 })
c.left(69)
c.left(0)
c.rotate(-33)
c.width(133)
c.text({ data: 'geej', id: :the_text })
c.left(777)

c.left(-12)
b.left(33)

t=text({ data: :hello, left: 444 })
t.touch(true) do
  c.width(33)
  c.height(600)
  c.rotate(33)
end

##########################
Universe.allow_localstorage = false
@back_nb = 0

undo_button.touch(true) do
  new_back_nb = @back_nb - 1
  executed = undo(new_back_nb, :undo)
  if executed == false
  else
    @back_nb = new_back_nb
  end
end

redo_button.touch(true) do
  new_back_nb = @back_nb + 1
  executed = undo(new_back_nb, :redo)
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

def undo(nb_of_backs, mode, atome_to_target = nil)
  # Désactiver le logging local
  Universe.allow_localstorage = false
  # JS.eval('console.clear()')

  # Récupérer l'historique pertinent
  view = grab(:view)
  history = atome_to_target ? filter_hash_by_key(view.history, atome_to_target) : view.history
  target_index = history.length + nb_of_backs

  # Valider l'index cible
  return false unless target_index.between?(0, history.length - 1)

  key_found = history.keys[target_index]
  previous_value = history[key_found]
  prev_action = extract_key_and_write(previous_value)

  # Gestion des cas spéciaux
  first_prev_action = prev_action.values.first
  first_key = first_prev_action.keys.first
  first_val = first_prev_action.values.first

  case
  when mode == :undo && first_key == :fasten
    grab(first_val).attach(:black_matter)
  when mode == :undo && first_key == :apply
    object = hook(prev_action.keys.first)
    object.remove(object.apply.last)
  when mode == :redo && first_key == :apply
    object = hook(prev_action.keys.first)
    object.apply(first_val.last)
  else
    restored = {}
    hooks_cache = {}

    # Restaurer toutes les propriétés jusqu'à l'index cible
    history.keys[0..target_index].reverse_each do |hist_key|
      extract_key_and_write(history[hist_key]).each do |aid, actions|
        hooks_cache[aid] ||= hook(aid)
        actions.each do |prop, val|
          next if restored[prop]

          hooks_cache[aid].send("#{prop}=", val)
          restored[prop] = true
          # puts "#{hooks_cache[aid].id}, #{prop} : #{val} (restauré)"
        end
      end
    end

    # Appliquer les autres modifications non restaurées
    prev_action.each do |aid, actions|
      hooks_cache[aid] ||= hook(aid)
      actions.each do |prop, val|
        next if restored[prop]

        hooks_cache[aid].send("#{prop}=", val)
        # puts "#{hooks_cache[aid].id}, #{prop} : #{val}"
      end
    end
  end

  # Réactiver le logging local
  Universe.allow_localstorage = true
  nb_of_backs
end
Universe.allow_localstorage = false
@prev_value = 1
# Universe.history_position=456
grab(:intuition).slider({ id: :toto, range: { color: :yellow }, min: -500, max: 0, width: 333, value: 0, height: 25, left: 99, top: 350, color: :orange, cursor: { color: :orange, width: 25, height: 25 } }) do |value|

  puts value
  # Universe.history_position=value
  @back_nb = value
  if value < @prev_value
    undo(@back_nb, :undo, c.aid)
  elsif value > @prev_value
    undo(@back_nb, :redo, c.aid)
  end
  @prev_value = value
end
Universe.allow_localstorage = true

c.rotate(12) do
  alert :poil
end

alert Universe.history_position # user as a ref when undoing at certain to keep this value

