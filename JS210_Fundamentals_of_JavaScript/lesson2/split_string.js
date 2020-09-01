function splitString(string, delimiter) {
    if (delimiter === undefined) {
          console.log('ERROR: No delimiter');
          return;
        }

    let subString = '';
    for (let index = 0; index < string.length; index += 1) {
          if (string[index] === delimiter) {
                  console.log(subString);
                  subString = '';
                } else if (delimiter === '') {
                        console.log(string[index]);
                      } else {
                              subString += string[index];
                            }
        }

    if (subString) console.log(subString);
}

splitString('abc,123,hello world', ',');
// logs:
// // abc
// // 123
// // hello world
//

splitString('hello');
// // logs:
// // ERROR: No delimiter
//

splitString('hello', '');
// // logs:
// // h
// // e
// // l
// // l
// // o
//

splitString('hello', ';');
// // logs:
// // hello
//
// splitString(';hello;', ';');
// // logs:
// //  (this is a blank line)
// // hello
//
//   //let results = [];
//   //   if (delimiter === '') {
//   //     for (let index = 0; index < string.length; index += 1) {
//   //       results.push(string[index]);
//   //     }
//   //   } else {
//   //     let subString = '';
//   //     for (let index = 0; index < string.length; index += 1) {
//   //       if (string[index] !== delimiter) {
//   //         subString += string[index];
//   //       } else {
//   //         results.push(subString);
//   //         subString = '';
//   //       }
//   //     }
//   //     if (subString) results.push(subString);
//   //   }
//
//   //   console.log('logs:')
//   //   for (let index = 0; index < results.length; index += 1) {
//   //     console.log(results[index]);
//   //   }
