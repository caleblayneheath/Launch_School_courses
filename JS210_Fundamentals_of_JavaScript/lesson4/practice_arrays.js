function lastInArray(array) {
  array[array.length - 1];
}

let rollCall = array => {
  for (let index = 0; index < array.length; index += 1) {
    console.log(array[index]);
  }
}

let reverseArray = array => {
  let tempArray = [];
  for (let index = array.length - 1; index >= 0; index -= 1) {
    tempArray.push(array[index]);
  }

  return tempArray;
}

let stringFromArray = arr => {
  let tempString = '';
  for (let index = 0; index < arr.length; index += 1) {
    tempString += String(arr[index]);
  }

  return tempString;
}

function push(arr, value) {
  arr[arr.length] = value;
  return arr.length;
}

let pop = arr => {
  if (arr.length === 0) return undefined;

  let lastElem = arr[arr.length - 1];
  arr.length -= 1;
  return lastElem;

}

let unshift = function(arr, value) {
  for (let index = arr.length; index > 0; index -= 1) {
    arr[index] = arr[index - 1];
  }

  arr[0] = value;
  return arr.length;
}

let shift = arr => {
  if (arr.length === 0) return undefined;

  let firstValue = arr[0];
  for (let index = 0; index < arr.length - 1; index += 1) {
    arr[index] = arr[index + 1];
  }

  arr.length -= 1;  
  return firstValue;
}

function indexOf(arr, value) {
  for (let index = 0; index < arr.length; index += 1) {
    if (arr[index] === value) return index;
  }

  return -1;
}

let lastIndexOf = function (arr, value) {
  for (let index = arr.length - 1; index >= 0; index -= 1) {
    if (arr[index] === value) return index;
  }

  return -1;

}

function slice(arr, start, end) {
  let result = [];
  for (let index = start; index < end; index += 1) {
    push(result, arr[index]);
  }

  return result;
}

let splice = (arr, start, countToRemove) => {
  let resultArr = [];
  for (let index = start; index < arr.length; index += 1) {
    if (index < (start + countToRemove)) {
      push(resultArr, arr[index]);
    }

    arr[index] = arr[index + countToRemove];
  }

  arr.length -= resultArr.length;
  return resultArr;
}

function concat(arr1, arr2) {
  function pushAll(targetArr, origArr) {
    for (let index = 0; index < origArr.length; index += 1) {
      push(targetArr, origArr[index]);
    }
  }

  let result = [];

  pushAll(result, arr1);
  pushAll(result, arr2);
  return result;
}

let join = (arr, separator = ',') => {
  let result = '';
  for (let index = 0; index < arr.length; index += 1) {
    result += String(arr[index]);
    if (index < arr.length - 1) result += separator;
  }

  return result;
}

function arraysEqual(arr1, arr2) {
  if (arr1.length !== arr2.length) return false;

  for (let index = 0; index < arr1.length; index += 1) {
    if (arr1[index] !== arr2[index]) return false;
  }

  return true;
}

function firstElementOf(arr) {
  return arr[0];
}

function lastElementOf(arr) {
  return arr[arr.length - 1];
}

function nthElementOf(arr, index) {
  return arr[index];
}

function firstNOf(arr, count) {
  return arr.slice(0, count);
}

function lastNOf(arr, count) {
  let index = arr.length - count;
  if (index < 0) index = 0;

  return arr.slice(index);
}

function endsOf(beginningArr, endingArr) {
  return [firstElementOf(beginningArr), lastElementOf(endingArr)];
}

function oddElementsOf(arr) {
  let result = [];
  for (let index = 1; index < arr.length; index += 2) {
    result.push(arr[index]);
  }

  return result;
}

function forwardsBackwards(arr) {
  return arr.concat(arr.slice().reverse());
}

function sortDescending(arr) {
  let copyArr = arr.slice();
  return copyArr.sort((a, b) => (b - a));
}

function matrixSums(arr) {
  let result = [];
  for (let index = 0; index < arr.length; index += 1) {
    result.push(arr[index].reduce((accum, elem) => (accum + elem), 0));
  }

  return result;
}

function uniqueElements(arr) {
  let result = [];
  for (let index = 0; index < arr.length; index += 1) {
    if (!result.includes(arr[index])) result.push(arr[index]);
  }

  return result;
}

function missing(arr) {
  let missing = [];
  let number = arr[0] + 1;
  while (number < arr[arr.length - 1]) {
    if (!arr.includes(number)) missing.push(number);
    number += 1;
  }

  return missing;
}

