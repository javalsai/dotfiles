.pragma library

function isEmpty(object) {
  if (object === null || object === undefined)
    return true;

  for (let _ in object) {
    return false;
  }

  return true;
}


function lowerColorOpac(color) {
  return Qt.rgba(color.r, color.g, color.b, 0.4);
}

function formatDuration(rawSeconds) {
  let time = Math.round(rawSeconds);
  let seconds = time % 60;
  let minutes = Math.floor(time / 60);

  return `${minutes}:${seconds.toString().padStart(2, '0')}`;
}

function grabFromSet(rawPercentage, set) {
  let percentage = Math.min(rawPercentage, 1);
  let index = Math.max(0, Math.ceil(percentage * set.length) - 1);

  return set[index];
}

function ordinal(n) {
  if (n % 100 >= 11 && n % 100 <= 13)
    return n + "th";

  switch (n % 10) {
    case 1:
      return n + "st";
    case 2:
      return n + "nd";
    case 3:
      return n + "rd";
    default:
      return n + "th";
  }
}

// Euclidean mod
function mod(n, m) {
  return ((n % m) + m) % m;
}
