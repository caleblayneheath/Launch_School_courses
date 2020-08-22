function evenOrOdd(number) {
  let result = ((number % 2) === 0) ? 'even' : 'odd';
  if (!Number.isInteger(number)) result = 'Error';
  console.log(result);  
}

function upcase10(string) {
  if string.length > 10 {
    return string.toUpperCase;
    else {
      return string;
    }
  }
}

function numberRange(value) {
  if (value < 0) {
    console.log(`${value} is less than 0.`);
  } else if ((value >= 0) && (value <= 50)) {
    console.log(`${value} is between 0 and 50`);
  } else if ((value >= 51) && (value <= 100)) {
    console.log(`${value} is between 51 and 100`);
  } else {
    console.log(`${value} is greater than 100`);
  }
}

