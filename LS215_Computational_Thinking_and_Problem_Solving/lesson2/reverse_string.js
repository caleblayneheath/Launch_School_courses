function reverse(string) {
//   let result = '';

//   for (let index = string.length - 1; index >= 0; index -= 1) {
//     result += string[index];
//   }

//   return result;

  return string.split('').reverse().join('');
}

console.log(reverse('hello'));                  // returns "olleh"
console.log(reverse('The quick brown fox'));    // returns "xof nworb kciuq ehT"
