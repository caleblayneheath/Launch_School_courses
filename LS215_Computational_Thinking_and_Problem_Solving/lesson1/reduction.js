function myReduce(array, func, initial) {
  if (initial === undefined) {
    initial = array[0];
    array = array.slice(1);
  }

  let accumulator = initial;
  array.forEach((element) => {
    accumulator = func(accumulator, element)
  });

  return accumulator;
}

let smallest = (result, value) => (result <= value ? result : value);
let sum = (result, value) => result + value;

console.log(myReduce([5, 12, 15, 1, 6], smallest));           // 1
console.log(myReduce([5, 12, 15, 1, 6], sum, 10));            // 49

function longestWord(words) {
  return words.reduce(longest);
}

function longest(result, currentWord) {
  return currentWord.length >= result.length ? currentWord : result;
}

console.log(longestWord(['abc', 'launch', 'targets', '']));      // "targets"