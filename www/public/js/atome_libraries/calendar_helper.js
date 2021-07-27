class CalendarHelper {
    constructor(id, params) {
        // alert ("the params is: "+params);
        var COMMON_CUSTOM_THEME = {
            'common.border': '3px solid #ffbb3b',
            'common.backgroundColor': '#ffbb3b0f',
            'common.holiday.color': '#f54f3d',
            'common.saturday.color': '#3162ea',
            'common.dayname.color': '#333'
        };

        var cal2, resizeThrottled;
        var useCreationPopup = true;
        var useDetailPopup = true;
        var datePicker, selectedCalendar;

        var cal = new tui.Calendar('#'+id, {
            defaultView: 'month',
            // defaultView: 'week',
            taskView: true,    // Can be also ['milestone', 'task']
            scheduleView: true,  // Can be also ['allday', 'time']
            theme: COMMON_CUSTOM_THEME, // set theme
            month: {
                daynames: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
                startDayOfWeek: 0,
                // narrowWeekend: true
            },
            week: {
                daynames: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
                startDayOfWeek: 0,
                // narrowWeekend: true
            }
        });
        cal.on({
            'clickMore': function (e) {
                console.log('clickMore', e);
            },
            'clickSchedule': function (e) {
                console.log('clickSchedule', e);
            },
            'clickDayname': function (date) {
                console.log('clickDayname', date);
            },
            'beforeCreateSchedule': function (e) {
                console.log('beforeCreateSchedule', e);
                cal.changeView('week', true);

                // saveNewSchedule(e);
            },
            'beforeUpdateSchedule': function (e) {
                var schedule = e.schedule;
                var changes = e.changes;

                console.log('beforeUpdateSchedule', e);

                if (changes && !changes.isAllDay && schedule.category === 'allday') {
                    changes.category = 'time';
                }

                cal.updateSchedule(schedule.id, schedule.calendarId, changes);
                refreshScheduleVisibility();
            },
            'beforeDeleteSchedule': function (e) {
                console.log('beforeDeleteSchedule', e);
                cal.deleteSchedule(e.schedule.id, e.schedule.calendarId);
            },
            'afterRenderSchedule': function (e) {
                var schedule = e.schedule;
                // var element = cal.getElement(schedule.id, schedule.calendarId);
                // console.log('afterRenderSchedule', element);
            },
            'clickTimezonesCollapseBtn': function (timezonesCollapsed) {
                console.log('timezonesCollapsed', timezonesCollapsed);

                if (timezonesCollapsed) {
                    cal.setTheme({
                        'week.daygridLeft.width': '77px',
                        'week.timegridLeft.width': '77px'
                    });
                } else {
                    cal.setTheme({
                        'week.daygridLeft.width': '60px',
                        'week.timegridLeft.width': '60px'
                    });
                }
                return true;
            }
        });
    }


}
