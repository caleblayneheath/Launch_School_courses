'use strict';

let positiveRegex = /\bfortunes?\b|\bdream(s|t|ed)?\b|love(s|d)?\b|respect(s|ed)?\b|\bpatien(ce|t)?\b|\bdevout(ly)?\b|\bnobler?\b|\bresolut(e|ion)?\b/gi;
let negativeRegex = /\bdie(s|d)?\b|\bheartached?\b|death|despise(s|d)?\b|\bscorn(s|ed)?\b|\bweary\b|\btroubles?\b|\boppress(es|ed|or('s)?)?\b/gi;

function sentiment(text) {
  let words = text.toLowerCase().match(/[a-z']+/g);
  let positiveWordsUsed = words.filter(word => positiveRegex.test(word));
  let negativeWordsUsed = words.filter(word => negativeRegex.test(word));

// official solution
//   let positives = text.match(positiveRegex).map(toLowerCaseWord);
//   let negatives = text.match(negativeRegex).map(toLowerCaseWord);

  console.log(`There are ${positiveWordsUsed.length} positive words in the text.`);
  console.log(`Positive sentiments: ${positiveWordsUsed.join(', ')}`);
  console.log('')
  console.log(`There are ${negativeWordsUsed.length} negative words in the text.`);
  console.log(`Negative sentiments: ${negativeWordsUsed.join(', ')}`);

  let rating;
  if (positiveWordsUsed.length > negativeWordsUsed.length) {
    rating = 'Positive'
  } else if (negativeWordsUsed.length > positiveWordsUsed.length) {
    rating = 'Negative'
  } else {
    rating = 'Neutral';
  }

  console.log('');
  console.log(`The sentiment of the text is ${rating}.`);
}

sentiment(textExcerpt);

// console output

// There are 9 positive type words in the text.
// Positive sentiments: nobler, fortune, devoutly, dream, dreams, respect, love, patient, resolution

// There are 10 negative type words in the text.
// Negative sentiments: troubles, die, heartache, die, death, scorns, oppressor's, despised, weary, death

// The sentiment of the text is Negative.
