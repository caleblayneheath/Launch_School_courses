function toLowerCase(string) {
    const CONVERSION_OFFSET = 32;
    let resultString = '';

    for (let index = 0; index < string.length; index += 1) {
          let letterCode = string.charCodeAt(index); 
          
          if ((letterCode >= 65) && (letterCode <= 90)) {
                  letterCode += CONVERSION_OFFSET;
                }
          
          resultString += String.fromCharCode(letterCode);
        }

    return resultString
}

console.log(toLowerCase('ALPHABET'));    // "alphabet"
console.log(toLowerCase('123'));         // "123"
console.log(toLowerCase('abcDEF'));      // "abcdef"
