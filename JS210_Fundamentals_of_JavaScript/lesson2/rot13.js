function rot13(string) {
  // create empty result string
  // iterate through string
  // if char code corresponds to letter
  //   rotate letter 13 places (preserving case)
  //   append rotated letter to result string
  // else
  //   append letter to result string
  // return result string

  // rotating letters 13 places
  // store char's code
  // if char a-m (case insensitive)
  //   add 13 to original char code
  // else if char n - z
  //   subtract 13 from original char code
  // return letter corresponding to code

  function isLetter(char) {
    const regex = /[A-Za-z]/
    return regex.test(char);
  }

  function rotateChar(char) {
    const OFFSET = 13;
    let charCode = char.charCodeAt(0);

    const regex = /[a-m]/i;
    if (regex.test(char)) {
      charCode += OFFSET;
    } else {
      charCode -= OFFSET;
    }

    return String.fromCharCode(charCode);
  }

  let tempString = '';
  for (let index = 0; index < string.length; index += 1) {
    let char = string[index];

    if (isLetter(char)) {
      char = rotateChar(char);
    }

    tempString += char;
  }

  return tempString;
}

console.log(rot13('Teachers open the door, but you must enter by yourself.'));
console.log(rot13(rot13('Teachers open the door, but you must enter by yourself.')));

