// my solution after looking at LS solution
// let Account = (() => {
//   let userEmail;
//   let userPassword;
//   let userFirstName;
//   let userLastName;

//   function isValidPassword(entry) {
//     return userPassword === entry;
//   }

//   function anonymize() {
//     const CHARS = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890';
//     let result = '';

//     for (let n = 1; n <= 16; n += 1) {
//       let index = Math.floor(Math.random() * CHARS.length);
//       result += CHARS[index];
//     }

//     return result;
//   }

//   return {
//     init(email, password, firstName, lastName) {
//       userEmail = email;
//       userPassword = password;
//       userFirstName = firstName;
//       userLastName = lastName;
    
//       this.displayName = anonymize();
//       return this;  
//     },

//     reanonymize(passwordAttempt) {
//       if (isValidPassword(passwordAttempt)) {
//         this.displayName = anonymize();
//         return true;
//       } else {
//         return 'Invalid Password';
//       }
//     },

//     resetPassword(passwordAttempt, newPassword) {
//       if (isValidPassword(passwordAttempt)) {
//         userPassword = newPassword;
//         return true;
//       } else {
//         return 'Invalid Password';
//       }
//     },

//     firstName(passwordAttempt) {
//       return isValidPassword(passwordAttempt) ? userFirstName : 'Invalid Password';
//     },

//     lastName(passwordAttempt) {
//       return isValidPassword(passwordAttempt) ? userLastName : 'Invalid Password';
//     },

//     email(passwordAttempt) {
//       return isValidPassword(passwordAttempt) ? userEmail : 'Invalid Password';
//     },
//   };
// })();

//version without IIFE from user submitted, using the passed in parameters
// also does further exploration of siloing data, but seems inefficient,
// basically an object factory but does maintain type
//
let Account = {
  init(email, password, firstName, lastName) {
    function isValidPassword(entry) {
      return password === entry;
    }

    function anonymize() {
      const CHARS = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890';
      let result = '';

      for (let n = 1; n <= 16; n += 1) {
        let index = Math.floor(Math.random() * CHARS.length);
        result += CHARS[index];
      }

      return result;
    }

    this.displayName = anonymize();

    this.reanonymize = function(passwordAttempt) {
      if (isValidPassword(passwordAttempt)) {
        this.displayName = anonymize();
        return true;
      } else {
        return 'Invalid Password';
      }
    };

    this.resetPassword = function(passwordAttempt, newPassword) {
      if (isValidPassword(passwordAttempt)) {
        password = newPassword;
        return true;
      } else {
        return 'Invalid Password';
      }
    };

    this.firstName = function(passwordAttempt) {
      return isValidPassword(passwordAttempt) ? firstName : 'Invalid Password';
    };

    this.lastName = function(passwordAttempt) {
      return isValidPassword(passwordAttempt) ? lastName : 'Invalid Password';
    };

    this.email = function(passwordAttempt) {
      return isValidPassword(passwordAttempt) ? email : 'Invalid Password';
    };

    return this;
  },
};

let fooBar = Object.create(Account).init('foo@bar.com', '123456', 'foo', 'bar');
console.log(fooBar.firstName);                     // returns the firstName function
console.log(fooBar.email);                         // returns the email function
console.log(fooBar.firstName('123456'));           // logs 'foo'
console.log(fooBar.firstName('abc'));              // logs 'Invalid Password'
console.log(fooBar.displayName);                   // logs 16 character sequence
console.log(fooBar.resetPassword('123', 'abc'))    // logs 'Invalid Password';
console.log(fooBar.resetPassword('123456', 'abc')) // logs true

let displayName = fooBar.displayName;
fooBar.reanonymize('abc');                         // returns true
console.log(displayName === fooBar.displayName);   // logs false

let quxBaz = Object.create(Account).init('qux@baz.com', '789', 'qux', 'baz');
console.log(quxBaz.firstName('789'));
console.log(fooBar.firstName('abc'));              
