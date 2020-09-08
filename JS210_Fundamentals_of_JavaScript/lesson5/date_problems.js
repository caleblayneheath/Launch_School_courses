function dateSuffix(date) {
  date = date.getDate();
  let suffix;
  if ((date >= 11) && (date <= 13)) {
    suffix = 'th';
  } else if (date % 10 === 1) {
    suffix = 'st';
  } else if (date % 10 === 2) {
    suffix = 'nd';
  } else if (date % 10 === 3) {
    suffix = 'rd';
  } else {
    suffix = 'th';
  }

  return String(date) + suffix;
}

function formattedMonth(date) {
  let months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return months[date.getMonth()];
}

function formattedDay(date) {
  let daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  return daysOfWeek[date.getDay()];
}

function formattedDate(date) {
  let day = formattedDay(date);
  let month = formattedMonth(date);

  return `${day}, ${month} the ${dateSuffix(date)}`
}

function formatTime(date) {
  function formatHourMinute(number) {
    let str = String(number);
    if (str.length === 1) str = '0' + str;
    return str;
  }

  let hour = formatHourMinute(date.getHours());
  let minute = formatHourMinute(date.getMinutes());
  return `${hour}:${minute}`;
}

let today = new Date();
console.log(today);
console.log(`Today's day is ${formattedDate(today)}.`);

console.log(today.getFullYear());
console.log(today.getYear());

console.log(today.getTime());

let tomorrow = new Date(today.getTime());
tomorrow.setDate(today.getDate() + 1);
console.log(tomorrow);

let nextWeek = new Date(today.getTime());
console.log(today.toDateString() === nextWeek.toDateString());

nextWeek.setDate(today.getDate() + 7);
console.log(today.toDateString() === nextWeek.toDateString());

console.log(formatTime(new Date(2013, 2, 1, 1, 10)));

