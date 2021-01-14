let Account = (function() {
  let accounts = {};

  function randomName() {
    const CHARS = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    
    let name = '';
    for (let i = 0; i < 16; i++) {
      name += CHARS[Math.floor(Math.random() * CHARS.length)];
    }
    return name;
  }

  function getAccountInfo(account) {
    return accounts[account.displayName];
  }

  function generateDisplayName() {
    let usedDisplayNames = Object.keys(accounts);

    let newDisplayName;
        
    do {
      newDisplayName = randomName();
    } while (usedDisplayNames.some(name => name === newDisplayName));
      
    return newDisplayName;
  }

  function isValidPassword(attempt, password) {
    return password === attempt;
  }

  return {
    init(email, password, firstName, lastName) {
      this.displayName = generateDisplayName();
      accounts[this.displayName] = {
        email,
        password,
        firstName,
        lastName
      };

      return this;
    },
    reanonymize(attempt) {
      let account = getAccountInfo(this);

      if (isValidPassword(attempt, account.password)) {
        let newDisplayName = generateDisplayName();     

        accounts[newDisplayName] = accounts[this.displayName];
        delete accounts[this.displayName];
        this.displayName = newDisplayName;

        return true;
      } else {
        return 'Invalid Password';
      }
    },
    resetPassword(oldPassword, newPassword) {
      let account = getAccountInfo(this);
      if (isValidPassword(oldPassword, account.password)) {
        account.password = newPassword;
        return true;
      } else {
        return 'Invalid Password';
      }
    },
    firstName(attempt) {
      let account = getAccountInfo(this);
      return (isValidPassword(attempt, account.password)) ? account.firstName : 'Invalid Password';
    },
    lastName(attempt) {
      let account = getAccountInfo(this);
      return (isValidPassword(attempt, account.password)) ? account.lastName : 'Invalid Password';
    },
    email(attempt) {
      let account = getAccountInfo(this);
      return (isValidPassword(attempt, account.password)) ? account.email : 'Invalid Password';
    },

  };
})();

let fooBar = Object.create(Account).init('foo@bar.com', '123456', 'foo', 'bar');
console.log(fooBar.firstName);                     // returns the firstName function
console.log(fooBar.email);                         // returns the email function
console.log(fooBar.firstName('123456'));           // logs 'foo'
console.log(fooBar.lastName('123456'));
console.log(fooBar.email('123456'));
console.log(fooBar.firstName('abc'));              // logs 'Invalid Password'
console.log(fooBar.displayName);                   // logs 16 character sequence
console.log(fooBar.resetPassword('123', 'abc'))    // logs 'Invalid Password';
console.log(fooBar.resetPassword('123456', 'abc')) // logs true
console.log(fooBar.firstName('abc'));

let displayName = fooBar.displayName;
fooBar.reanonymize('abc');                         // returns true
console.log(displayName === fooBar.displayName);   // logs false

let bazQux = Object.create(Account).init('baz@qux.com', '123456', 'baz', 'qux');
// console.log(bazQux.firstName('abc'));              // logs 'baz' but should log foo.
console.log(bazQux.firstName('123456'));              // logs 'baz' but should log foo.
// console.log(bazQux.lastName('123456'));              // logs 'baz' but should log foo.
// console.log(bazQux.email('123456'));                  // 'baz@qux.com' but should 'foo@bar.com'
// console.log(bazQux.displayName);
// console.log(bazQux.displayName);
// console.log(bazQux.reanonymize('abc'));
console.log(bazQux.reanonymize('123456'));
console.log(bazQux.displayName);


