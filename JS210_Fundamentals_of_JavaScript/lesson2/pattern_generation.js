function generatePattern(nStars) {
  let lastRowString = '';
  for (let i = 1; i <= nStars; i += 1) {
    lastRowString += String(i);
  }

  let width = lastRowString.length;

  let line = '';
  for (let i = 1; i <= nStars; i += 1) {
    line += String(i);
    console.log(line + '*'.repeat(width - line.length));
  }
}

generatePattern(19);
