let calendar;

document.addEventListener('DOMContentLoaded', function() {
    // Initialisation du calendrier
    calendar = new tui.Calendar('#view', {
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

    // Ajouter un événement de démonstration
    calendar.createEvents([
        {
            id: '1',
            calendarId: '1',
            title: 'Événement example',
            category: 'time',
            dueDateClass: '',
            start: '2023-08-20T10:30:00+00:00',
            end: '2023-08-20T12:30:00+00:00',
        },
    ]);
});

function changeCalendarView(view) {
    const validViews = ['day', 'week', 'month'];
    if (!validViews.includes(view)) {
        console.error(`Vue non valide: ${view}. Les vues valides sont: ${validViews.join(', ')}`);
        return;
    }

    calendar.changeView(view);
}
setTimeout(function() {
    changeCalendarView('day');
}, 3000);
