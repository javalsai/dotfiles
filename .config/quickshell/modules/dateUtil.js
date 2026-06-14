.pragma library

// Copies date with day precision
function copyDateDay(date) {
  return new Date(date.getFullYear(), date.getMonth(), date.getDate())
}

// Copies date with month precision
function copyDateMonth(date) {
  return new Date(date.getFullYear(), date.getMonth())
}

function addYears(date, nYears) {
  return new Date(date.getFullYear() + nYears, date.getMonth(), date.getDate());
}

function addMonths(date, nMonths) {
  return new Date(date.getFullYear(), date.getMonth() + nMonths, date.getDate());
}

function addDays(date, nDays) {
  return new Date(date.getFullYear(), date.getMonth(), date.getDate() + nDays);
}

function sameDay(a, b) {
  return a.getDate() == b.getDate() && a.getMonth() == b.getMonth() && a.getYear() == b.getYear();
}
