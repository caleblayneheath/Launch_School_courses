function makeBank() {
  let accounts = [];
  let nextAccountNumber = 100;
  return {
    openAccount() {
      let newAccount = makeAccount(nextAccountNumber += 1);
      accounts.push(newAccount);
      return newAccount;
    },
    transfer(source, destination, amount) {
      return destination.deposit(source.withdraw(amount));
    },
  };
}

function makeAccount(number) {
  let balance = 0;
  let transactions = [];
  let logTransaction = (type, amount) => {
      transactions.push({type, amount});
  };

  return {
    number() {
      return number;
    },
    balance() {
      return balance; 
    },
    transactions() {
      return transactions
    },
    deposit(amount) {
      balance += amount;
      logTransaction('deposit', amount);
      return amount;
    },
    withdraw(amount) {
      if (balance < amount) {
        amount = balance;
      }
      balance -= amount;
      logTransaction('withdrawal', amount);
      return amount;    
    },
  };
}

let bank = makeBank();
let account = bank.openAccount();
account.balance();
// = 0
account.deposit(17);
// = 17
let secondAccount = bank.openAccount();
secondAccount.number();
// = 102
account.transactions();
// = [Object]
bank.accounts;
