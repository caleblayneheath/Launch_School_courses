function multiply() {
  let rlSync = require('readline-sync');
  let number1 = rlSync.question('Enter the first number: ');
  let number2 = rlSync.question('Enter the second number: ');

  console.log(number1 + ' * ' + number2 + ' = ' + (number1 * number2));
}

multiply();
