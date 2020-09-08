function greetings(arr, obj) {
  let name = arr.join(' ');
  let message = `Hello ${name}! Nice to have a ${obj['title']} ${obj['occupation']} around.`
  console.log(message);
}

greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' });

