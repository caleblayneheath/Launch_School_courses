"use strict";

document.addEventListener('DOMContentLoaded', () => {
  let textField = document.querySelector('.text-field');
  let content = document.querySelector('.content');
  let cursorInterval;

  textField.addEventListener('click', event => {
    event.stopPropagation();
    textField.classList.add('focused');
    
    cursorInterval = cursorInterval || setInterval(() => textField.classList.toggle('cursor'), 500);
  });

  document.addEventListener('click', event => {
    textField.classList.remove('focused');
    textField.classList.remove('cursor');
    clearInterval(cursorInterval);
    cursorInterval = null;
  });

  document.addEventListener('keydown', event => {
    if (textField.classList.contains('focused')) {
      let input = event.key;
      let text = content.textContent;

      if (input === 'Backspace') {
        text = text.slice(0, text.length - 1);
        content.textContent = text;
      } else if (input.length === 1) {
        content.textContent += input;
      }
    }
  });

});
