// problem 2

let RECTANGLE = {
  area() {
    return this.width * this.height;
  },
  perimeter() {
    return 2 * (this.width + this.height);
  },
};

function Rectangle(width, height) {
  this.width = width;
  this.height = height;
  this.area = RECTANGLE.area.call(this);
  this.perimeter = RECTANGLE.perimeter.call(this);
}

let rect1 = new Rectangle(2, 3);
// return Rectangle object, 2, 3, NaN, NaN
console.log(rect1.area);
console.log(rect1.perimeter);


// problem 3

function Circle(radius) {
  this.radius = radius;  
}

Circle.prototype.area = function() {
  return Math.PI * (this.radius ** 2);
};

let a = new Circle(3);
let b = new Circle(4);

console.log(a.area().toFixed(2)); // => 28.27
console.log(b.area().toFixed(2)); // => 50.27


// problem 6

let ninjaA;
let ninjaB;
function Ninja() {
  this.swung = false;
}

ninjaA = new Ninja();
ninjaB = new Ninja();

Ninja.prototype.swing = function() {
  this.swung = true;
  return this;
}

// Add a swing method to the Ninja prototype which
// returns the calling object and modifies swung

console.log(ninjaA.swing().swung);      // must log true
console.log(ninjaB.swing().swung);      // must log true

// problem 7


let ninjaA = (function() {
  function Ninja(){};
  return new Ninja();
})();

let ninjaB = new ninjaA.constructor;

console.log(ninjaB.constructor === ninjaA.constructor);    // should log true
