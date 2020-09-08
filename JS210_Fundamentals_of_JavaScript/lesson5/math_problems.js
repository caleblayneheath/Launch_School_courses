function radiansToDegrees(rad) {
  return rad * 180 / Math.PI;
}

let number = -180;
console.log(Math.abs(number));

console.log(Math.sqrt(16777216));

console.log(Math.pow(16, 6));

function randBetween(min, max) {
  if (min === max) {
    return min;
  } else if (min > max) {
    [min, max] = [max, min];
  }

  return Math.floor(Math.random() * (max - min + 1) + min);
}

console.log(randBetween(33,3));
