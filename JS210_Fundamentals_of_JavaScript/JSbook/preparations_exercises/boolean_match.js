function has_a_or_e(string) {
  let results = string.match(/[ae]/g);
  if (results) {
    console.log(`We have a match! ${results}`);
  } else {
    console.log('No match here.');
  }
}

has_a_or_e("basketball"); // We have a match! a,e,a
has_a_or_e("football");   // We have a match! a
has_a_or_e("hockey");     // We have a match! e
has_a_or_e("golf");       // No match here.
