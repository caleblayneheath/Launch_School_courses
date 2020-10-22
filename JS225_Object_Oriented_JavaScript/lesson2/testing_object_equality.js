function objectsEqual(obj1, obj2) {
/*
assuming all values are primitives
get all keys of obj1
get all keys of obj2
make sure all keys of obj1 exist in obj2
make sure all keys of obj2 exist in obj1
if either of the above are false
  return false
now that all keys are valid
for each keys
  if obj1[key] !== obj2[key]
    return false
return true
 */
  let obj1keys = Object.keys(obj1).sort();
  let obj2keys = Object.keys(obj2).sort();
  
  if (obj1keys.toString() !== obj2keys.toString()) return false;

  for (let i = 0; i < obj1keys.length; i += 1) {
    let key = obj1keys[i];
    if (obj1[key] !== obj2[key]) return false;
  }

  return true;
}

console.log(objectsEqual({a: 'foo'}, {a: 'foo'}));                      // true
console.log(objectsEqual({a: 'foo'}, {a: 'bar'}));                      // false
console.log(objectsEqual({a: 'foo', b: 'bar'}, {a: 'foo'}));            // false
console.log(objectsEqual({}, {}));                                      // true
console.log(objectsEqual({a: 'foo', b: undefined}, {a: 'foo', c: 1}));  // false
