let me = {}
me.firstName = 'Caleb';
me.lastName = 'Heath';


let sister = {
  firstName: 'Elaine',
  lastName: 'Christman',
}

let friend = {
  firstName: 'Andrew',
  lastName: 'Kesl',
}

let people = {
  nextID: -1,
  assignID() {
    return this.nextID += 1;
  },
  collection: [],
  fullName(person) {
    console.log(person.firstName + ' ' + person.lastName + `,${person.id}`);
  },
  rollCall() {
    this.collection.forEach(this.fullName);
  },
  add(person) {
    if (this.isInvalidPerson(person)) return;
    person.id = this.assignID();
    this.collection.push(person);
  },
  getIndex(person) {
    let index = 1;
    this.collection.forEach((listing, idx) => {
      if (listing.firstName === person.firstName &&
          listing.lastName === person.lastName) {
        index = idx;    
      }
    });
    
    return index;
  },
  remove(person) {
    if (this.isInvalidPerson(person)) return;

    let idx = this.getIndex(person);
    if (idx !== -1) this.collection.splice(idx, 1);
  },
  isInvalidPerson(person) {
    return typeof person.firstName !== 'string' && person.lastName !== 'string';
  },
  get(person) {
    if (this.isInvalidPerson(person)) return;

    return this.collection[this.getIndex(person)];
  },
  update(person) {
    if (this.isInvalidPerson(person)) return;

    let index = this.getIndex(person);
    index !== 1 ? this.collection[index] = person : this.add(person);
  },
}
people.add(me);
people.add(sister);
people.add(friend);
people.add({lastName: 'Gilming',});

people.rollCall();
people.remove({firstName: 'Andrew', lastName: 'Kesl',});
people.rollCall();
// update doesn't handle the id's well
people.update({firstName: 'Caleb', lastName: 'Heath', rank: 'boss',});
people.rollCall();
console.log(people.collection);


