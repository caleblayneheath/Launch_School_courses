function fibonacci(number) {
  if (number < 2) return number;
  return fibonacci(number - 1) + fibonacci(number - 2);
}

for (let count = 0; count < 8; count += 1) {
  console.log(fibonacci(count));
}
