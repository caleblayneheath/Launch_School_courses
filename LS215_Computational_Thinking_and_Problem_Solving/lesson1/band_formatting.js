let bands = [
  { name: 'sunset rubdown', country: 'UK', active: false },
  { name: 'women', country: 'Germany', active: false },
  { name: 'a silver mt. zion', country: 'Spain', active: true },
];

function processBands(data) {
  // map each band object
    // return new band object with transformed properties
    // each country must be Canada
    // each name must be capitalized
    // each name must have all dots removed.
  function capitalize(string) {
    let words = string.split(' ');
    return words.map(word => word[0].toUpperCase() + word.slice(1)).join(' ');
  }

  function noDots(string) {
    //return string.split('').filter(char => char !== '.').join('');
    return string.replace(/\./g, '');
  }

  return data.map( band => {
    return {
      name: noDots(capitalize(band.name)), 
      country: 'Canada', 
      active: band.active,
    }
  });
}

console.log(processBands(bands));
console.log(bands);
console.log()
// should return:
// [
//   { name: 'Sunset Rubdown', country: 'Canada', active: false },
//   { name: 'Women', country: 'Canada', active: false },
//   { name: 'A Silver Mt Zion', country: 'Canada', active: true },
// ]