function objectHasProperty(obj, str) {
  return Object.keys(obj).includes(str);
}

let pets = {
  cat: 'Simon',
  dog: 'Dwarf',
  mice: null,
};

console.log(objectHasProperty(pets, 'dog'));       // true
console.log(objectHasProperty(pets, 'lizard'));    // false
console.log(objectHasProperty(pets, 'mice'));      // true

function incrementProperty(obj, str) {
  let keys = Object.keys(obj);
  keys.includes(str) ? obj[str] += 1 : obj[str] = 1;
  return obj[str];
}

let wins = {
  steve: 3,
  susie: 4,
};

console.log(incrementProperty(wins, 'susie'));   // 5
console.log(wins);                               // { steve: 3, susie: 5 }
console.log(incrementProperty(wins, 'lucy'));    // 1
console.log(wins);                               // { steve: 3, susie: 5, lucy: 1 }

function copyProperties(masterObj, targetObj) {
  let count = 0;
  for (let property in masterObj) {
    targetObj[property] = masterObj[property];
    count += 1;
  }

  return count;
}

let hal = {
  model: 9000,
  enabled: true,
};

let sal = {};
console.log(copyProperties(hal, sal));  // 2
console.log(sal);                       // { model: 9000, enabled: true }
