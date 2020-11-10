// Question 1

function getDefiningObject(object, propKey) {
  while (object && !object.hasOwnProperty(propKey)) {
      object = Object.getPrototypeOf(object)  ;
  }

  return object
}

let foo = {
  a: 1,
  b: 2,
};

let bar = Object.create(foo);
let baz = Object.create(bar);
let qux = Object.create(baz);

bar.c = 3;

console.log(getDefiningObject(foo, 'a') === foo); // true
console.log(getDefiningObject(qux, 'c') === bar);     // => true
console.log(getDefiningObject(qux, 'e'));             // => null

// Question 2

function shallowCopy(object) {
  let copy = Object.create(Object.getPrototypeOf(object));

  Object.getOwnPropertyNames(object).forEach(prop => {
    copy[prop] = object[prop];
  });

  return copy;
}

let foo = {
  a: 1,
  b: 2,
};

let bar = Object.create(foo);
bar.c = 3;
bar.say = function() {
  console.log('c is ' + this.c);
};

let baz = shallowCopy(bar);
console.log(baz.a);       // => 1
baz.say();                // => c is 3
baz.hasOwnProperty('a');  // false
baz.hasOwnProperty('b');  // false

// Question 3

function extend(destination, ...sources) {
  sources.forEach(obj => {
    Object.getOwnPropertyNames(obj).forEach(prop => {
      destination[prop] = obj[prop];
    });
  });

  return destination;
}

let foo = {
  a: 0,
  b: {
    x: 1,
    y: 2,
  },
};

let joe = {
  name: 'Joe'
};

let funcs = {
  sayHello() {
    console.log('Hello, ' + this.name);
  },

  sayGoodBye() {
    console.log('Goodbye, ' + this.name);
  },
};

let object = extend({}, foo, joe, funcs);

console.log(object.b.x);          // => 1
object.sayHello();                // => Hello, Joe
