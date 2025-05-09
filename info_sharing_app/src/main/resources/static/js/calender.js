document.addEventListener("DOMContentLoaded", function () {
    initCalendar(events);
});

function initCalendar(events) {
    const calendarElement = document.getElementById("calendar");
    const currentDate = new Date();
    const currentYear = currentDate.getFullYear();
    const currentMonth = currentDate.getMonth();

    renderCalendar(calendarElement, currentYear, currentMonth, events);

    // ナビゲーションボタンの設定
    const prevButton = document.createElement("button");
    const nextButton = document.createElement("button");
    prevButton.textContent = "前月";
    nextButton.textContent = "次月";

    prevButton.onclick = () => {
        const newDate = new Date(currentYear, currentMonth - 1);
        renderCalendar(calendarElement, newDate.getFullYear(), newDate.getMonth(), events);
    };

    nextButton.onclick = () => {
        const newDate = new Date(currentYear, currentMonth + 1);
        renderCalendar(calendarElement, newDate.getFullYear(), newDate.getMonth(), events);
    };

    calendarElement.appendChild(prevButton);
    calendarElement.appendChild(nextButton);
}

function renderCalendar(container, year, month, events) {
    container.innerHTML = ""; // カレンダーエリアをクリア

    const header = document.createElement("div");
    header.className = "calendar-header";
    header.textContent = `${year}年 ${month + 1}月`;
    container.appendChild(header);

    const daysOfWeek = ["日", "月", "火", "水", "木", "金", "土"];
    const weekRow = document.createElement("div");
    weekRow.className = "calendar-week-row";
    daysOfWeek.forEach((day) => {
        const dayElement = document.createElement("div");
        dayElement.className = "calendar-day-header";
        dayElement.textContent = day;
        weekRow.appendChild(dayElement);
    });
    container.appendChild(weekRow);

    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const startDay = firstDay.getDay();
    const totalDays = lastDay.getDate();

    const calendarGrid = document.createElement("div");
    calendarGrid.className = "calendar-grid";

    for (let i = 0; i < startDay; i++) {
        const blankDay = document.createElement("div");
        blankDay.className = "calendar-day blank";
        calendarGrid.appendChild(blankDay);
    }

    for (let date = 1; date <= totalDays; date++) {
        const dayElement = document.createElement("div");
        dayElement.className = "calendar-day";
        dayElement.textContent = date;

        const eventDate = `${year}-${String(month + 1).padStart(2, "0")}-${String(date).padStart(2, "0")}`;
        const eventList = events.filter((event) => event.date === eventDate);

        if (eventList.length > 0) {
            dayElement.classList.add("has-event");

            const eventDetails = document.createElement("div");
            eventDetails.className = "event-details";
            eventList.forEach((event) => {
                const eventItem = document.createElement("div");
                eventItem.textContent = event.title;
                eventItem.className = "event-item";
                eventItem.onclick = () => alert(`イベント: ${event.title}\n詳細: ${event.detail}`);
                eventDetails.appendChild(eventItem);
            });
            dayElement.appendChild(eventDetails);
        }

        calendarGrid.appendChild(dayElement);
    }

    container.appendChild(calendarGrid);
}
