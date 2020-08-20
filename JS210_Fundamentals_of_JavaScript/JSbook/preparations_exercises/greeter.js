let rlSync = require('readline-sync');

function getName () {
  let firstName = rlSync.question("What's your first name?\n");
  let secondName = rlSync.question("What's your second name?\n");

  return `Hello, ${firstName + ' ' + secondName}!`
}

console.log(getName());
