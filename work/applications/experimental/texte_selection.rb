#  frozen_string_literal: true

t = text('hello to you all guys and girls!')
t.edit(true)

def select_text_in_element(element_id)
  element = JS.global[:document].getElementById(element_id.to_s)
  if element
    selection = JS.global[:window].getSelection()
    range = JS.global[:document].createRange()
    range.selectNodeContents(element)
    selection.removeAllRanges() # Supprimer les anciennes plages de sélection
    selection.addRange(range)
  end
end

def select_specific_part(element_id, start_offset, end_offset)
  element = JS.global[:document].getElementById(element_id.to_s)
  if element
    range = JS.global[:document].createRange()
    text_node = element[:firstChild]
    range.setStart(text_node, start_offset)
    range.setEnd(text_node, end_offset)
    selection = JS.global[:window].getSelection()
    selection.removeAllRanges()
    selection.addRange(range)
  end
end

def select_word(id_found, string)
  element = JS.global[:document].getElementById(id_found.to_s)

  if element
    range = JS.global[:document].createRange()
    text_node = element[:firstChild]
    text = element[:textContent].to_s
    start_offset = text.index(string)
    end_offset = start_offset + string.length

    range.setStart(text_node, start_offset)

    range.setEnd(text_node, end_offset)
    selection = JS.global[:window].getSelection()
    selection.removeAllRanges()
    selection.addRange(range)
  end
end

def get_cursor_position
  selection = JS.global[:window].getSelection
  begin
    range = selection.getRangeAt(0)
    range[:startOffset]
  rescue StandardError => e
    # no cursor set
  end
end

def move_cursor_to_position(element_id, position)
  element = JS.global[:document].getElementById(element_id.to_s)
  if element
    range = JS.global[:document].createRange()
    selection = JS.global[:window].getSelection()
    range.setStart(element, 0)
    range.setEnd(element, position)
    selection.removeAllRanges()
    selection.addRange(range)
  end
end

select_specific_part(t.id, 5, 9)
wait 3 do
  current_position = get_cursor_position
  puts "actual cursor position : #{current_position}"
end
wait 4 do
  selection = JS.global[:window].getSelection

  begin
    range = selection.getRangeAt(0)
    start_offset = range[:startOffset]
    end_offset = range[:endOffset]

    selected_text = range.toString()

    puts "start : #{start_offset}, end : #{end_offset}"
    puts "content : #{selected_text}"
  rescue StandardError => e
    # no cursor set
  end
end
wait 5 do
  select_word(t.id, 'girls')
end
wait 6 do
  def deselect_all()
    selection = JS.global[:window].getSelection()
    selection.removeAllRanges()
  end

  # Appel de la fonction pour désélectionner tout
  deselect_all
end
wait 7 do
  # set cursor position
  select_specific_part(t.id, 7, 7)
end