function repeat(string, times) {
  if (times === 0) {
    return '';
  } else if (Number.isInteger(times) && (times > 0)) {
    let result = '';
    for (let index = 1; index <= times; index += 1) {
      result += string;
    }
    return result;
  }
}

console.log(repeat('abc', 1));       // "abc"
console.log(repeat('abc', 2));       // "abcabc"
console.log(repeat('abc', -1));      // undefined
console.log(repeat('abc', 0));       // ""
console.log(repeat('abc', 'a'));     // undefined
console.log(repeat('abc', false));   // undefined
console.log(repeat('abc', null));    // undefined
console.log(repeat('abc', '  '));    // undefined
console.log(repeat('abc', Infinity));    // undefined
console.log(repeat('abc', NaN));    // undefined
