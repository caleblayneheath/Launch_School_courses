// problem 1

let shape = {
  getType() {
    return this.type;
  },
};

function Triangle(a, b, c) {
  this.a = a;
  this.b = b;
  this.c = c;
  this.type = 'triangle';
}

Triangle.prototype = shape;
Triangle.prototype.constructor = Triangle;
Triangle.prototype.getPerimeter = function() {
  return this.a + this.b + this.c;
};

let t = new Triangle(3, 4, 5);
t.constructor;                 // Triangle(a, b, c)
shape.isPrototypeOf(t);        // true
t.getPerimeter();              // 12
t.getType();                   // "triangle"

// problem 2

function User(first, last) {
//   if (this === globalThis || this === undefined) {
  if (!(this instanceof User)) {
    return new User(first, last);
  }
   
  this.name = first + ' ' + last;
}

let name = 'Jane Doe';
let user1 = new User('John', 'Doe');
let user2 = User('John', 'Doe');

console.log(name);         // => Jane Doe
console.log(user1.name);   // => John Doe
console.log(user2.name);   // => John Doe

// problem 3

function createObject(obj) {
// ineffecient solution
//   return Object.setPrototypeOf({}, obj);

  function F() {};
  F.prototype = obj;
  return new F();
}

let foo = {
  a: 1
};

let bar = createObject(foo);
foo.isPrototypeOf(bar);         // true

// problem 4

let foo = {
  a: 1,
};

Object.prototype.begetObject = function() {
  function F() {};
  F.prototype = this;
  return new F();
};

let bar = foo.begetObject();
foo.isPrototypeOf(bar);         // true

// problem 5

function neww(constructor, args) {
  // create new object
  // set prototype for new object to constructor's prototype
  // set execution context for function to be new object
  // invoke constructor function
  // return new object

  let newObj = Object.create(constructor.prototype);
//   constructor.apply(newObj, args);
//   return newObj;

// some constructors might supply the object itself
// (such as 'scope-safe constructors'), so see if
// the constructor explicitly returns an object or if
// it just modifies the object
  let result = constructor.apply(newObj, args);
  return typeof result === 'object' ? result : newObj;
}

function Person(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
}

Person.prototype.greeting = function() {
  console.log('Hello, ' + this.firstName + ' ' + this.lastName);
};

let john = neww(Person, ['John', 'Doe']);
john.greeting();          // => Hello, John Doe
john.constructor;         // Person(firstName, lastName) {...}


