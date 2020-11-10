// either bind context to func first

// function myFilter(array, func, context) {
//   const result = [];
//   func = func.bind(context);

//   array.forEach(value => {
//     if (func(value)) {
//       result.push(value);
//     }
//   });

//   return result;
// }

// or pass context every time func is invoked using call

function myFilter(array, func, context) {
  const result = [];

  array.forEach(value => {
    if (func.call(context, value)) {
      result.push(value);
    }
  });

  return result;
}


let filter = {
  allowedValues: [5, 6, 9],
};

myFilter([2, 1, 3, 4, 5, 6, 12], function(val) {
  return this.allowedValues.includes(val);
}, filter); // returns [5, 6]
