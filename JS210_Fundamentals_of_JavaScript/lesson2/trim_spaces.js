function trim(string) {
  let firstIndex = 0;
  let secondIndex = string.length - 1;

  for (let index = 0; index < string.length; index += 1) {
    if (string[index] !== ' ') {
      firstIndex = index;
      break;
    }
  }

  for (let index = string.length - 1; index >= 0; index -= 1) {
    if (string[index] !== ' ') {
      secondIndex = index;
      break;
    }
  }

  let trimmedString = '';
  for (let index = firstIndex; index <= secondIndex; index += 1) {
    trimmedString += string[index];
  }

  return trimmedString;
}

console.log(trim('a')); // 'a'
console.log(trim('  c '));  // "c"
console.log(trim('  abc  '));  // "abc"
console.log(trim('abc   '));   // "abc"
console.log(trim(' ab c'));    // "ab c"
console.log(trim(' a b  c'));  // "a b  c"
console.log(trim('      '));   // ""
console.log(trim(''));         // ""

// declare firstIndex = 0
// // declare secondIndex = stringlength - 1
// // iterate through string
// // if string[firstIndex] !== ' '
// //    set firstIndex = index
// //    break
// // iterate backwards through string
// // if string[secondIndex] !== ' '
// //  set secondIndex = index
// // use indexes to create result trim string
