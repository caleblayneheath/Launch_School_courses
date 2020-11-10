function myBind(func, context, ...partialArgs) {
  return function(...args) {
    return func.apply(context, args.concat(partialArgs));
  }
}

function add(...args) {
  return args.reduce((sum, elem) => sum += elem);
}

let add1and2 = myBind(add, null, 1, 2);
add1and2(3);

let obj = {
  foo: 'a',
  bar: 'b',
  baz() { return this.foo + this.bar },
}

var foo = 'c';
var bar = 'd';

let qux = myBind(obj.baz, obj);
qux();
