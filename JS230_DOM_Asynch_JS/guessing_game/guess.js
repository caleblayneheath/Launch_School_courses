document.addEventListener('DOMContentLoaded', () => {
  const [FIRST, LAST] = [1, 100];
  const GUESS_MESSAGE = 'Guess a number between ' + FIRST + ' and ' + LAST;

  let generateRandomNumber = (first, last) => {
    return Math.floor(Math.random() * (1 + last - first)) + first;
  }

  let disableSubmit = () => {
    submit.disabled = true;
    submit.style.boxShadow = 'none';
    submit.style.background = 'linear-gradient(to bottom, #c76379 0%, #7a3a47 100%)';
  };

  let enableSubmit = () => {
    submit.disabled = false;
    submit.style.boxShadow = '0 0 1px 1px #780e24';
    submit.style.background = 'linear-gradient(to bottom, #CC183E 0%, #780E24 100%)';

  };

  let checkGuess = guess => {
    if (guess > answer) {
      return guess + ' is too high!';
    } else if (guess < answer) {
      return guess + ' is too low!';
    } else if (guess === answer) {
      disableSubmit();
      return guess + " is right! Took you " + guesses + ' guesses.';
    } else {
      return 'Not a number.'
    }
  };

  let newGame = () => {
    answer = generateRandomNumber(FIRST, LAST);
    guesses = 0;
    message = GUESS_MESSAGE;
    status.textContent = message;
    input.value = '';
    enableSubmit();
  };

  let message;
  let answer;
  let guesses;

  let status = document.querySelector('p');
  let form = document.querySelector('form');
  let input = document.getElementById('guess');
  let submit = document.querySelector('fieldset').lastElementChild;
  let link = document.querySelector('a');

  form.addEventListener('submit', event => {
    event.preventDefault();
    let guess = parseInt(input.value, 10);
    guesses += 1;
    message = checkGuess(guess);
    status.textContent = message;
    input.value = '';
  });

  link.addEventListener('click', event => {
    event.preventDefault();
    newGame();
  });

  newGame();
});
