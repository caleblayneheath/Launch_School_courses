function anagram(word, list) {
  function sortLetters (word) {
    return word.split('').sort().join('');
  }

  function areAnagrams(word1, word2) {
    return sortLetters(word1) === sortLetters(word2);
  }

  return list.filter(element => areAnagrams(element, word));
}

console.log(anagram('listen', ['enlists', 'google', 'inlets', 'banana']));  // [ "inlets" ]
console.log(anagram('listen', ['enlist', 'google', 'inlets', 'banana']));   // [ "enlist", "inlets" ]