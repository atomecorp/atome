const atomeTime = {
    schedule: function (years, months, days, hours, minutes, seconds, atome, proc) {
        const now = new Date();
        const formatDate = new Date(years, months - 1, days, hours, minutes, seconds);
        const diffTime = Math.abs(formatDate - now);
        setTimeout(function () {
            atome.$schedule_callback(proc);
        }, diffTime);
    }
}