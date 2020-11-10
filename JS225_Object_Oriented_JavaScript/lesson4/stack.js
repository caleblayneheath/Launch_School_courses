function newStack() {
  const stack = [];

  return {
    push(value) {
      stack.push(value);
    },
    pop() {
      return stack.pop();
    },
    printStack() {
      stack.forEach(elem => console.log(elem));
    },
  };
}

let foo = newStack();
foo.push(3);
foo.push(4);
foo.printStack();
foo.pop();
foo.printStack();
