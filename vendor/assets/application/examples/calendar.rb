# frozen_string_literal: true

new(molecule: :calendar) do |params, &bloc|

  cal = box(params)
  cal.resize(true)
  cal_id = cal.id

  ##########################  create calendar ##########################
  cal_name = cal_id
  calendar = <<~JAVASCRIPT
    	 window.#{cal_name} = new tui.Calendar('##{cal_id}', {
    		defaultView: 'month',
    		usageStatistics: false,
    		month: {
    			startDayOfWeek: 0,
    		},
    		week: {
    			showTimezoneCollapseButton: true,
    			timezones: [{ timezoneOffset: 0, displayLabel: 'UTC', tooltip: 'UTC' }],
    		},
    });


    
     
  JAVASCRIPT

  JS.eval(calendar)

  ######################### Update view methode ############################




  cal.define_singleton_method(:view) do |view_mode|
    update_calendar = <<~JAVASCRIPT
      	 function changeCalendarView(view) {
      	const validViews = ['day', 'week', 'month'];
      	if (!validViews.includes(view)) {
      		console.error(`Vue non valide: ${view}. Les vues valides sont: ${validViews.join(', ')}`);
      		return;
      	}
      	window.#{cal_name}.changeView(view);
      }
      	changeCalendarView('#{view_mode}');

      	// changeCalendarView('day');
    JAVASCRIPT
    JS.eval(update_calendar)
  end

  cal.define_singleton_method(:event) do |new_event|
    add_event = <<~JAVASCRIPT
      window.#{cal_name}.createEvents([
      		{
      			id: '#{new_event[:id]}',
      			calendarId: '#{new_event[:calendarId]}',
      			title: '#{new_event[:title]}',
      			category: '#{new_event[:category]}',
      			dueDateClass: '#{new_event[:dueDateClass]}',
      			start: '#{new_event[:start]}',
      			end: '#{new_event[:end]}',
      		},
      	]);
    JAVASCRIPT
    JS.eval(add_event)

  end



  #################
  cal.define_singleton_method(:update_event) do |event_id, calendar_id, updates|
    update_event = <<~JAVASCRIPT
    window.#{cal_name}.updateEvent(
      '#{event_id}',        // ID de l'événement
      '#{calendar_id}',     // ID du calendrier
      {
        title: '#{updates[:title]}',
        start: new Date('#{updates[:start]}'),
        end: new Date('#{updates[:end]}'),
        category: '#{updates[:category]}',
        dueDateClass: '#{updates[:dueDateClass]}',
        isAllDay: #{updates[:isAllDay] ? 'true' : 'false'},
        location: '#{updates[:location]}',
        raw: #{updates[:raw] || '{}'},
        state: '#{updates[:state]}'
      }
    );
  JAVASCRIPT
    JS.eval(update_event)
  end
  #################

  cal.define_singleton_method(:delete_event) do |event_id, calendar_id|
    delete_event = <<~JAVASCRIPT
    window.#{cal_name}.deleteEvent('#{event_id}', '#{calendar_id}');
  JAVASCRIPT
    JS.eval(delete_event)
  end

  ####################

  cal.define_singleton_method(:log_event_range) do
    log_range = <<~JAVASCRIPT
    var selectedRanges = [];

    window.#{cal_name}.on('selectDateTime', function(info) {
      var range = { start: new Date(info.start), end: new Date(info.end) };
      selectedRanges.push(range);
      console.log('Selected ranges:', selectedRanges);

      // Exemple de traitement de chaque plage
      selectedRanges.forEach(function(range) {
        console.log('Processing range:', range.start, 'to', range.end);
      });

      // Réinitialisation après traitement
      selectedRanges = [];
    });
  JAVASCRIPT
    JS.eval(log_range)
  end
  ######################

  cal.define_singleton_method(:handle_range_clear) do
    clear_range = <<~JAVASCRIPT
    window.#{cal_name}.on('selectDateTime', function(info) {
      // Log the selected range (optional)
      console.log('Selected range:', new Date(info.start), 'to', new Date(info.end));
      
      // Clear the selected range
      window.#{cal_name}.clearGridSelections();
      
      console.log('Range selection cleared');
    });
  JAVASCRIPT
    JS.eval(clear_range)
  end

  ######################
  # now we return main atome
  cal
end
cal = calendar({ id: :the_cal, width: 396, height: 396 })
# below we get range when drag on the calendar
cal.log_event_range
# below we remove teh  range newly created to avoid graphical pollution
cal.handle_range_clear
wait 1 do
  cal.event(	{
                id: '1',
                calendarId: '1',
                title: 'nouvel example',
                category: 'time',
                dueDateClass: '',
                start: '2024-08-20T10:12:00+00:00',
                end: '2024-08-20T12:17:00+00:00',
              })
end

wait 2 do
  grab(:the_cal).view(:day)
  wait 2 do
    cal.view(:week)
    wait 2 do
      cal.view(:month)
      wait 1 do
        wait 1 do
          cal.update_event('1', '1', {
            title: 'Événement mis à jour',
            start: '2024-08-20T11:00:00+00:00',
            end: '2024-08-20T13:00:00+00:00',
            category: 'time'
          })
        end
        cal.delete_event('1', '1')
      end
    end
  end
end





def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "Calendar",
    "define_singleton_method",
    "delete_event",
    "end",
    "error",
    "eval",
    "event",
    "forEach",
    "handle_range_clear",
    "id",
    "includes",
    "join",
    "log",
    "log_event_range",
    "push",
    "resize",
    "start",
    "update_event",
    "view"
  ],
  "Calendar": {
    "aim": "The `Calendar` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `Calendar`."
  },
  "define_singleton_method": {
    "aim": "The `define_singleton_method` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `define_singleton_method`."
  },
  "delete_event": {
    "aim": "The `delete_event` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete_event`."
  },
  "end": {
    "aim": "The `end` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `end`."
  },
  "error": {
    "aim": "The `error` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `error`."
  },
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "event": {
    "aim": "The `event` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `event`."
  },
  "forEach": {
    "aim": "The `forEach` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `forEach`."
  },
  "handle_range_clear": {
    "aim": "The `handle_range_clear` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `handle_range_clear`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "includes": {
    "aim": "The `includes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `includes`."
  },
  "join": {
    "aim": "The `join` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `join`."
  },
  "log": {
    "aim": "The `log` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `log`."
  },
  "log_event_range": {
    "aim": "The `log_event_range` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `log_event_range`."
  },
  "push": {
    "aim": "The `push` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `push`."
  },
  "resize": {
    "aim": "The `resize` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `resize`."
  },
  "start": {
    "aim": "The `start` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `start`."
  },
  "update_event": {
    "aim": "The `update_event` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `update_event`."
  },
  "view": {
    "aim": "The `view` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `view`."
  }
}
end
