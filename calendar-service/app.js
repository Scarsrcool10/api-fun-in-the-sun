import express from "express";

const app = express();
const port = process.env.PORT || 8000;

function randomHour() {
  const hour =  Math.floor(Math.random() * 24) + 1;
  return hour;
}

function someDaysAgo(days) {
  const currentDate = new Date();
  currentDate.setDate(currentDate.getDate() - days);
  currentDate.setHours(randomHour());
  currentDate.setMinutes(0);
  return currentDate;
}

function someDaysBeyond(days) {
  const currentDate = new Date();
  currentDate.setDate(currentDate.getDate() + days);
  currentDate.setHours(randomHour());
  currentDate.setMinutes(0);
  return currentDate;
}

const events = [
      {
        id: 1,
        name: "Hangout",
        duration: 30,
        date: someDaysAgo(3).toLocaleString('en-US'),
        attendees: 2,
        timeZone: "America/New_York"
      },
      {
        id: 2,
        name: "Pre-Screen",
        duration: 60,
        date: someDaysAgo(5).toLocaleString('en-US'),
        attendees: 3,
        timeZone: "America/Chicago"
      },
      {
        id: 3,
        name: "Group Interview",
        duration: 120,
        date: someDaysAgo(4).toLocaleString('en-US'),
        attendees: 3,
        timeZone: "America/Denver"
      },
      {
        id: 4,
        name: "1on1",
        duration: 60,
        date: someDaysBeyond(4).toLocaleString('en-US'),
        attendees: 2,
        timeZone: "America/Los_Angeles"
      }
    ]

app.use(express.json());

function eventsRouteHandler(req, res) {
  let user_id = req.query.user_id
  if (!user_id) {
    res.send("User Does Not Exist", 404)
    return
  }

  res.json({
    events
  })
}

function filterEvents(events, startDate, endDate) {
  return events.filter(event => {
    const eventDate = new Date(event.date)
    const start = new Date(startDate);
    const end = new Date(endDate);
    return eventDate >= start && eventDate <= end
  });
}

function dateStringValidator(dateString) {
  const date = new Date(dateString);
  return !isNaN(date.getTime());
}

function eventsDateRangeHandler(req, res) {
  let startDate = req.query.start_date
  let endDate = req.query.end_date

  if (!startDate || !endDate) {
    res.send("Not a valid date range", 400)
    return
  }

  if (dateStringValidator(startDate) === false || dateStringValidator(endDate) === false) {
    res.send("One of the provide date parameters is invalid", 400)
    return
  }

  const filteredData = filterEvents(events, startDate, endDate);

  if (filteredData.length > 0) {
    res.json({
      events: filteredData
    });
  } else {
    res.json({
      "message": "No events found for the given date range"
    });
  }
}

app.get("/events", eventsRouteHandler);

app.get("/events_by_date_range", eventsDateRangeHandler);

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});
