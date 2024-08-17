
/* eslint-disable no-var,prefer-template,no-undef */
var $ = function (selector) {
  return document.querySelector(selector);
};

var $$ = function (selector) {
  return Array.prototype.slice.call(document.querySelectorAll(selector));
};

function getNavbarRange(tzStart, tzEnd, viewType) {
  var start = tzStart.toDate();
  var end = tzEnd.toDate();
  var middle;
  if (viewType === 'month') {
    middle = new Date(start.getTime() + (end.getTime() - start.getTime()) / 2);

    return moment(middle).format('YYYY-MM');
  }
  if (viewType === 'day') {
    return moment(start).format('YYYY-MM-DD');
  }
  if (viewType === 'week') {
    return moment(start).format('YYYY-MM-DD') + ' ~ ' + moment(end).format('YYYY-MM-DD');
  }
  throw new Error('no view type');
}


/* eslint-disable */

var MOCK_CALENDARS = [
  {
    id: '1',
    name: 'personnel',
    color: '#ffffff',
    borderColor: '#9e5fff',
    backgroundColor: '#9e5fff',
    dragBackgroundColor: '#9e5fff',
  },
  {
    id: '2',
    name: 'travail',
    color: '#ffffff',
    borderColor: '#00a9ff',
    backgroundColor: '#00a9ff',
    dragBackgroundColor: '#00a9ff',
  },
 
];

var EVENT_CATEGORIES = ['milestone', 'task'];

function generateTestEvent(viewName, renderStart, renderEnd) {

  var today = new Date();
  var start = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 15, 0);
  var end = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 16, 30);

  if (start >= renderStart && end <= renderEnd) {
    var specificEvent = {
      id: 'testing',
      calendarId: '1',
      title: 'my event',
      body: 'today 16h30',
      start: start,
      end: end,
      category: 'time'
    };

    return [specificEvent];
  } else {
    return []; 
  }
}


/* eslint-disable no-var,prefer-destructuring,prefer-template,no-undef,object-shorthand,no-console */
(function (Calendar) {
  var cal;
  // Constants
  var CALENDAR_CSS_PREFIX = 'toastui-calendar-';
  var cls = function (className) {
    return CALENDAR_CSS_PREFIX + className;
  };

  // Elements
  var navbarRange = $('.navbar--range');
  var prevButton = $('.prev');
  var nextButton = $('.next');
  var todayButton = $('.today');
  var dropdown = $('.dropdown');
  var dropdownTrigger = $('.dropdown-trigger');
  var dropdownTriggerIcon = $('.dropdown-icon');
  var dropdownContent = $('.dropdown-content');
  var checkboxCollapse = $('.checkbox-collapse');
  var sidebar = $('.sidebar');

  // App State
  var appState = {
    activeCalendarIds: MOCK_CALENDARS.map(function (calendar) {
      return calendar.id;
    }),
    isDropdownActive: false,
  };

  // functions to handle calendar behaviors
  function reloadEvents() {
    var randomEvents;

    window.cal.clear();
    setTimeout(function() {
      randomEvents = generateTestEvent(
          window.cal.getViewName(),
          window.cal.getDateRangeStart(),
          window.cal.getDateRangeEnd()
      );
      window.cal.createEvents(randomEvents);
    }, 2000);

  }

  function getReadableViewName(viewType) {
    switch (viewType) {
      case 'month':
        return 'Monthly';
      case 'week':
        return 'Weekly';
      case 'day':
        return 'Daily';
      default:
        throw new Error('no view type');
    }
  }

  function displayRenderRange() {
    var rangeStart = window.cal.getDateRangeStart();
    var rangeEnd = window.cal.getDateRangeEnd();

    navbarRange.textContent = getNavbarRange(rangeStart, rangeEnd, window.cal.getViewName());
  }

  function setDropdownTriggerText() {
    var viewName = window.cal.getViewName();
    var buttonText = $('.dropdown .button-text');
    buttonText.textContent = getReadableViewName(viewName);
  }

  function toggleDropdownState() {
    appState.isDropdownActive = !appState.isDropdownActive;
    dropdown.classList.toggle('is-active', appState.isDropdownActive);
    dropdownTriggerIcon.classList.toggle(cls('open'), appState.isDropdownActive);
  }

  function setAllCheckboxes(checked) {
    var checkboxes = $$('.sidebar-item > input[type="checkbox"]');

    checkboxes.forEach(function (checkbox) {
      checkbox.checked = checked;
      setCheckboxBackgroundColor(checkbox);
    });
  }

  function setCheckboxBackgroundColor(checkbox) {
    var calendarId = checkbox.value;
    var label = checkbox.nextElementSibling;
    var calendarInfo = MOCK_CALENDARS.find(function (calendar) {
      return calendar.id === calendarId;
    });

    if (!calendarInfo) {
      calendarInfo = {
        backgroundColor: '#2a4fa7',
      };
    }

    label.style.setProperty(
        '--checkbox-' + calendarId,
        checkbox.checked ? calendarInfo.backgroundColor : '#fff'
    );
  }

  function update() {
    setDropdownTriggerText();
    displayRenderRange();
    reloadEvents();
  }

  function bindAppEvents() {
    dropdownTrigger.addEventListener('click', toggleDropdownState);

    prevButton.addEventListener('click', function () {
      window.cal.prev();
      update();
    });

    nextButton.addEventListener('click', function () {
      window.cal.next();
      update();
    });

    todayButton.addEventListener('click', function () {
      window.cal.today();
      update();
    });

    dropdownContent.addEventListener('click', function (e) {
      var targetViewName;

      if ('viewName' in e.target.dataset) {
        targetViewName = e.target.dataset.viewName;
        window.cal.changeView(targetViewName);
        checkboxCollapse.disabled = targetViewName === 'month';
        toggleDropdownState();
        update();
      }
    });

    checkboxCollapse.addEventListener('change', function (e) {
      if ('checked' in e.target) {
        window.cal.setOptions({
          week: {
            collapseDuplicateEvents: !!e.target.checked,
          },
          useDetailPopup: !e.target.checked,
        });
      }
    });

    sidebar.addEventListener('click', function (e) {
      if ('value' in e.target) {
        if (e.target.value === 'all') {
          if (appState.activeCalendarIds.length > 0) {
            window.cal.setCalendarVisibility(appState.activeCalendarIds, false);
            appState.activeCalendarIds = [];
            setAllCheckboxes(false);
          } else {
            appState.activeCalendarIds = MOCK_CALENDARS.map(function (calendar) {
              return calendar.id;
            });
            window.cal.setCalendarVisibility(appState.activeCalendarIds, true);
            setAllCheckboxes(true);
          }
        } else if (appState.activeCalendarIds.indexOf(e.target.value) > -1) {
          appState.activeCalendarIds.splice(appState.activeCalendarIds.indexOf(e.target.value), 1);
          window.cal.setCalendarVisibility(e.target.value, false);
          setCheckboxBackgroundColor(e.target);
        } else {
          appState.activeCalendarIds.push(e.target.value);
          window.cal.setCalendarVisibility(e.target.value, true);
          setCheckboxBackgroundColor(e.target);
        }
      }
    });
  }

  function bindInstanceEvents() {
    window.cal.on({
      clickMoreEventsBtn: function (btnInfo) {
        console.log('clickMoreEventsBtn', btnInfo);
      },
      clickEvent: function (eventInfo) {
        console.log('clickEvent', eventInfo);
      },
      clickDayName: function (dayNameInfo) {
        console.log('clickDayName', dayNameInfo);
      },
      selectDateTime: function (dateTimeInfo) {
        console.log('selectDateTime', dateTimeInfo);
      },
      
    ///  
beforeCreateEvent: function (event) {
      console.log('beforeCreateEvent', event);
    
      // Créer un nouvel événement avec des propriétés vérifiées
      var newEvent = {
        id: chance.guid(),
        calendarId: event.calendarId || '',
        title: event.title || '',
        category: event.isAllDay ? 'allday' : 'time',
        dueDateClass: '',
        start: event.start || new Date(),
        end: event.end || new Date(),
        isAllDay: event.isAllDay || false,
        location: event.location || '',
        raw: event.raw || {}, // Vérifiez si raw existe, sinon assigner un objet vide
        state: event.state || ''
      };
      window.cal.createEvents([event]);
      window.cal.clearGridSelections();
    
      // Call the save function here
      saveNewEvent(newEvent);
    },
      

beforeUpdateEvent: function (eventInfo) {
  var event = eventInfo.event;
  var changes = eventInfo.changes;

  // Créer un nouvel objet avec les modifications
  var updatedEvent = {
    id: event.id,
    calendarId: changes.calendarId || event.calendarId,
    title: changes.title || event.title,
    category: changes.isAllDay !== undefined ? (changes.isAllDay ? 'allday' : 'time') : event.category,
    dueDateClass: '',
    start: changes.start || event.start,
    end: changes.end || event.end,
    isAllDay: changes.isAllDay !== undefined ? changes.isAllDay : event.isAllDay,
    location: changes.location || event.location,
    raw: changes.raw || event.raw,
    state: changes.state || event.state
  };

  // Mettre à jour l'événement dans le calendrier
  window.cal.updateEvent(event.id, event.calendarId, changes);

  // Log the updated event
  saveUpdatedEvent(updatedEvent);
},

//       beforeDeleteEvent: function (eventInfo) {
//         console.log('beforeDeleteEvent', eventInfo);
// 
//         window.cal.deleteEvent(eventInfo.id, eventInfo.calendarId);
//       },

beforeDeleteEvent: function (eventInfo) {
  console.log('beforeDeleteEvent', eventInfo);

  // Récupérer les détails de l'événement à supprimer
  var event = {
    id: eventInfo.id,
    calendarId: eventInfo.calendarId,
    title: eventInfo.title,
    category: eventInfo.category,
    start: eventInfo.start,
    end: eventInfo.end,
    isAllDay: eventInfo.isAllDay,
    location: eventInfo.location,
    raw: eventInfo.raw,
    state: eventInfo.state
  };

  // Supprimer l'événement du calendrier
  window.cal.deleteEvent(eventInfo.id, eventInfo.calendarId);

  // Log the deleted event
  logDeletedEvent(event);
}
    });
  }
  
  function saveNewEvent(event) {
    alert('Saving new event:'+ event+event.title);

  }

  function saveUpdatedEvent(event) {
    console.log('Updated event:', event);

  }
  
  function logDeletedEvent(event) {
    console.log('Deleted event:', event);

  }

  function initCheckbox() {
    var checkboxes = $$('input[type="checkbox"]');

    checkboxes.forEach(function (checkbox) {
      setCheckboxBackgroundColor(checkbox);
    });
  }

  function getEventTemplate(event, isAllday) {
    var html = [];
    var start = moment(event.start.toDate().toUTCString());
    if (!isAllday) {
      html.push('<strong>' + start.format('HH:mm') + '</strong> ');
    }

    if (event.isPrivate) {
      html.push('<span class="calendar-font-icon ic-lock-b"></span>');
      html.push(' Private');
    } else {
      if (event.recurrenceRule) {
        html.push('<span class="calendar-font-icon ic-repeat-b"></span>');
      } else if (event.attendees.length > 0) {
        html.push('<span class="calendar-font-icon ic-user-b"></span>');
      } else if (event.location) {
        html.push('<span class="calendar-font-icon ic-location-b"></span>');
      }
      html.push(' ' + event.title);
    }

    return html.join('');
  }

  // Calendar instance with options
  // eslint-disable-next-line no-undef
  window.cal = new Calendar('#app', {
    calendars: MOCK_CALENDARS,
    useFormPopup: true,
    useDetailPopup: true,
    taskView: true, // Disable task view check also in 'week' below
    scheduleView: ['time'], // Disable milestone view and all day view
    week: {
      taskView: false, // Disable task view for weekly view,  check also above for global
      eventView: ['time'], // Disable all day view for weekly view
    },
    eventFilter: function (event) {
      var currentView = window.cal.getViewName();
      if (currentView === 'month') {
        return ['allday', 'time'].includes(event.category) && event.isVisible;
      }

      return event.isVisible;
    },
    template: {
      allday: function (event) {
        return getEventTemplate(event, true);
      },
      time: function (event) {
        return getEventTemplate(event, false);
      },
    },
  });

  // Init
  bindInstanceEvents();
  bindAppEvents();
  initCheckbox();
  update();
})(tui.Calendar);