function calculateAreas(array) {
  return array.map(rectangle => rectangle[0] * rectangle[1]);
}

function totalArea(array) {
  let areas = calculateAreas(array);
  return areas.reduce((sum, area) => sum += area);
}

function totalSquareArea(array) {
  let squares = array.filter(rectangle => rectangle[0] === rectangle[1]);
  return totalArea(squares);
}

let rectangles = [[3, 4], [6, 6], [1, 8], [9, 9], [2, 2]];

console.log(totalArea(rectangles));    // 141
console.log(totalSquareArea(rectangles)); // 121