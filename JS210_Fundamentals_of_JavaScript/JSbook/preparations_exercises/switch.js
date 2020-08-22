let a = 8;

switch (a) {
  case 5:
    console.log('a is 5');
    break;
  case 6:
    console.log('a is 6');
    break;
  case 7:
  case 8:
    console.log('a is 7 or 8');
    break;
  default:
    console.log('a is neither 5, nor 6');
    break;
}
