function isPrime(number) {
  if ((number <= 1) || ((number > 2) && (number % 2 === 0))) {
    return false;
  } else if (number === 2) {
    return true;
  }

  for (let index = 3; index <= Math.sqrt(number); index+=2) {
    if (number % index === 0) return false;
  }

  return true;
}


let checkGoldbach = (expectedSum) => {
  if ((expectedSum < 4) || (expectedSum % 2 === 1)) {
    console.log('logs: null');
    return;
  }

  let lower = [];
  for (let i = 2; i <= expectedSum/2; i += 1) {
    if (isPrime(i)) lower.push(i);
  }
  let higher = [];
  for (let i = expectedSum - 1; i >= expectedSum/2; i -= 1) {
    if (isPrime(i)) higher.push(i);
  }

  let pairs;
  pairs = [];

  for (let i = 0; i < lower.length; i += 1) {
    for (let j = 0; j < higher.length; j += 1) {
      if ((lower[i] + higher[j]) === expectedSum) {
        pairs.push([lower[i], higher[j]]);
      }
    }
  }

  for (let index = 0; index < pairs.length; index += 1) {
    console.log(`logs: ${pairs[index][0]} ${pairs[index][1]}`)
  }
};

checkGoldbach(3);
checkGoldbach(4);
checkGoldbach(6);
checkGoldbach(12);
checkGoldbach(100);

