$fabric_canvas_list = {}
$headless_canvas_list = {}
$speech_canvas_list = {}
$three_canvas_list = {}
$zim_canvas_list = {}

def canvas_list(type, id, canvas)
  case type
  when :fabric
    $fabric_canvas_list[id] = canvas
  when :headless
    $headless_canvas_list[id] = canvas
  when :speech
    $speech_canvas_list[id] = canvas
  when :three
    $three_canvas_list[id] = canvas
  when :zim
    $zim_canvas_list[id] = canvas
  else
  end
end


def get_canvas(type, canvas_id)
  canvas = case type
           when :fabric
             $fabric_canvas_list[canvas_id]
           when :headless
             $headless_canvas_list[canvas_id]
           when :html
             $html_canvas_list[canvas_id]
           when :speech
             $speech_canvas_list[canvas_id]
           when :three
             $three_canvas_list[canvas_id]
           when :zim
             $zim_canvas_list[canvas_id]
           else
             $html_canvas_list[canvas_id]
           end
  return canvas
end