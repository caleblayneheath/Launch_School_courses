// Object.prototype.ancestors = function() {
//   let result = [];
//   let self = this;
//   let ancestor;

//   while (true) {
//     ancestor = Object.getPrototypeOf(self);
//     if (ancestor === null) {
//       return result;
//     }
    
//     result.push(ancestor);
//     self = ancestor;
//   }
// };

Object.prototype.ancestors = function ancestors() {
  const ancestor = Object.getPrototypeOf(this);

  if (Object.prototype.hasOwnProperty.call(ancestor, 'name')) {
    return [ancestor.name].concat(ancestor.ancestors());
  }

  return ['Object.prototype'];
};

// name property added to make objects easier to identify
let foo = {name: 'foo'};
let bar = Object.create(foo);
bar.name = 'bar';
let baz = Object.create(bar);
baz.name = 'baz';
let qux = Object.create(baz);
qux.name = 'qux';

qux.ancestors();  // returns ['baz', 'bar', 'foo', 'Object.prototype']
baz.ancestors();  // returns ['bar', 'foo', 'Object.prototype']
bar.ancestors();  // returns ['foo', 'Object.prototype']
foo.ancestors();  // returns ['Object.prototype']
