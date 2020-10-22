function makeCountry(name, continent, visited = false) {
  return {
    name,
    continent,
    visited,
    getDescription() {
      let str = `${this.name} is located in ${this.continent}. `;
      let name = this.name.replace(/^The/, 'the');
      if (this.visited) {
        str += `I have visited ${name}.`;
      } else {
        str += `I haven't visited ${name}.`;
      }
      return str;
    },
    visitCountry() {
      this.visited = true;
    },
  }
}

let chile = makeCountry('The Republic of Chile', 'South America');
let canada = makeCountry('Canada', 'North America');
let southAfrica = makeCountry('The Republic of South Africa', 'Africa');

chile.getDescription();       // "The Republic of Chile is located in South America."
canada.getDescription();      // "Canada is located in North America."
southAfrica.getDescription(); // "The Republic of South Africa is located in Africa."
southAfrica.visitCountry();
southAfrica.visited;
southAfrica.getDescription(); // "The Republic of South Africa is located in Africa."
