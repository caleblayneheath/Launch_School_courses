function repeatedCharacters(string) {
  let count = {};
  string = string.toLowerCase();
  for (let index = 0; index < string.length; index += 1) {
    let char = string[index];
    if (char in count) {
      count[char] += 1;
    } else {
      count[char] = 1;
    }
  }

  for (let char in count) {
    if (count[char] === 1) delete count[char];
  }

  return count;
}

console.log(repeatedCharacters('Programming'));    // { r: 2, g: 2, m: 2 }
console.log(repeatedCharacters('Combination'));    // { o: 2, i: 2, n: 2 }
console.log(repeatedCharacters('Pet'));            // {}
console.log(repeatedCharacters('Paper'));          // { p: 2 }
console.log(repeatedCharacters('Baseless'));       // { s: 3, e: 2 }
