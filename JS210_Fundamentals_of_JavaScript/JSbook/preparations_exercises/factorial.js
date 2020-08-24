function factorial(number) {
  /*let accum = 1;
  for (let count = number; count > 0; count -= 1) {
    accum *= count;
  }
  return accum
  */

 return (number <= 1) ? 1 : number * factorial(number - 1);
}

console.log(factorial(0));     // => 1
console.log(factorial(1));     // => 1
console.log(factorial(2));     // => 2
console.log(factorial(3));     // => 6
console.log(factorial(4));     // => 24
console.log(factorial(5));     // => 120
console.log(factorial(6));     // => 720
console.log(factorial(7));     // => 5040
console.log(factorial(8));     // => 40320
