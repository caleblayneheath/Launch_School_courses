function indexOf(firstString, secondString) {
  let secondIndex = 0;
  let resultIndex = -1;
  let tempString = '';

  for (let firstIndex = 0; firstIndex < firstString.length; firstIndex += 1) {
    if (firstString[firstIndex] === secondString[secondIndex]) {
      if (resultIndex === -1) resultIndex = firstIndex;

      tempString += firstString[firstIndex];

      if (tempString === secondString) return resultIndex;

      secondIndex += 1;

    } else {
      resultIndex = -1;
      secondIndex = 0;
      tempString = '';
    }
  }

  return -1;
}

function lastIndexOf(firstString, secondString) {
  let reverseFirstString = reverseString(firstString);
  let reverseSecondString = reverseString(secondString);
  let result = indexOf(reverseFirstString, reverseSecondString);

  return result === -1 ? result : (firstString.length - result - secondString.length);
}

function reverseString(string) {
  let result = '';
  for (let index = string.length - 1; index >= 0; index -= 1) {
    result += string[index];
  }

  return result;
}

console.log(indexOf('Some strings', 's'));                      // 5
console.log(indexOf('Blue Whale', 'Whale'));                    // 5
console.log(indexOf('Blue Whale', 'Blute'));                    // -1
console.log(indexOf('Blue Whale', 'leB'));                      // -1
console.log(indexOf('Blue Whale, Killer Whale', 'all'));    // -1

console.log(lastIndexOf('Some strings', 's'));                  // 11
console.log(lastIndexOf('Blue Whale, Killer Whale', 'Whale'));  // 19
console.log(lastIndexOf('Blue Whale, Killer Whale', 'all'));    // -1
console.log(lastIndexOf('Blue Whale, Killer Whale', 'Blue'));  // 0
console.log(lastIndexOf('Blue Whale, Killer Whale', 'al'));  // 21


