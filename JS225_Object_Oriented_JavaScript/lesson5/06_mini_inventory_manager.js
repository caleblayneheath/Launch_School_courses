/*
item creator
  each required piece of info for an item corresponds to a property
  if any info is not valid, return object has a property notValid = true

item components
  should have nothing but mentioned properties and default Object
  make an item type?
  SKU
    unique identifier
    first 3 letters of item + first 2 letters of category
  item name
    minimum 5 nonspace characters
  category
    one word, minimum 5 chars
  quantity
    nonblank, assume valid numbers are provided

item manager methods
(these are class methods, not an instance)
  create
    creates new item (and returns it?), returns false if unsuccessful
  update(skuCode, object)
    updates info on an item, assume valid args
  delete(skuCode)\
    deletes item from list, assume valid args
  items
    returns all items
  inStock
    lists all items with quantity greater than 0
  itemsInCategory(category)
    list all items of a given category

reports manager
  init(itemManager)
    assign arg to items property
  items:
    item managers objects assigned through init
  createReporter(skuCode)
    returns object with method itemInfo and no other properties
      (updates via ItemManager should be dynamically visible)
      itemInfo
        logs to console all properties of the object as key:value pairs (one per liene)
  reportInStock
    logs to console item names of all items in stock as CSV


*/

let ItemCreator = (() => {
  function isValidItemName(name) {
    const regex = /\s/g;
    return name.replace(regex, '').length >= 5;
  }

  function isValidCategory(category) {
    const regex = /^\w{5,}$/;
    return regex.test(category);
  }

  function isValidQuantity(quantity) {
    return quantity !== undefined;
  }

  function createSKUcode(name, category) {
    const regex = /\s/g; 
    let nameLetters = name.replace(regex, '').substring(0, 3);
    let categoryLetters = category.substring(0, 2);
    let sku = (nameLetters + categoryLetters).toUpperCase()
    return sku;
  }

  return function(name, category, quantity) {
      if (isValidItemName(name) && 
          isValidCategory(category) && 
          isValidQuantity(quantity)) {
        this.skuCode = createSKUcode(name, category);
        this.itemName = name;
        this.category = category;
        this.quantity = quantity;
        return this;
      } else {
        return { notValid: true };
      }
  };
})();

class ItemManager {
  static items = [];

  static list() {
    return this.items;
  }

  static create(name, category, quantity) {
    let newItem = new ItemCreator(name, category, quantity);

    if (newItem['notValid']) {
      return false;
    } else {
      this.items.push(newItem);
      return newItem;
    }    
  }

  static update(skuCode, itemInfo) {
    let item = this.getItem(skuCode);

//     for (let prop in itemInfo) {
//       item[prop] = itemInfo[prop];
//     }

    Object.assign(item, itemInfo);
  }

  static delete(skuCode) {
    let deletedItem = this.getItem(skuCode);
    this.items = this.items.filter(item => item !== deletedItem);
  }

  static inStock() {
    return this.items.filter(({quantity}) => quantity > 0);
  }

  static itemsInCategory(itemCategory) {
    return this.items.filter(({category}) => category === itemCategory);
  }

  static getItem(sku) {
    return this.items.filter(({skuCode}) => sku === skuCode)[0];
  } 
}

class ReportManager {
  static items;

  static init(itemManager) {
    this.items = itemManager;
  }

  static createReporter(skuCode) {
    let item = this.items.getItem(skuCode);

    return {
      itemInfo() {
        for (let prop in item) {
          console.log(prop + ': ' + item[prop]);
        }
      }
    };
  }

  static reportInStock() {
    return this.items.inStock().map(({itemName}) => itemName).join(',');
  }
}

ItemManager.create('basket ball', 'sports', 0);           // valid item
ItemManager.create('asd', 'sports', 0);
ItemManager.create('soccer ball', 'sports', 5);           // valid item
ItemManager.create('football', 'sports');
ItemManager.create('football', 'sports', 3);              // valid item
ItemManager.create('kitchen pot', 'cooking items', 0);
ItemManager.create('kitchen pot', 'cooking', 3);          // valid item

ItemManager.items;       
// // returns list with the 4 valid items

ReportManager.init(ItemManager);
ReportManager.reportInStock();
// // logs soccer ball,football,kitchen pot

ItemManager.update('SOCSP', { quantity: 0 });
ItemManager.inStock();
// // returns list with the item objects for football and kitchen pot
ReportManager.reportInStock();
// // logs football,kitchen pot
ItemManager.itemsInCategory('sports');
// // returns list with the item objects for basket ball, soccer ball, and football
ItemManager.delete('SOCSP');
ItemManager.items;
// // returns list with the remaining 3 valid items (soccer ball is removed from the list)

let kitchenPotReporter = ReportManager.createReporter('KITCO');
kitchenPotReporter.itemInfo();
// // logs
// // skuCode: KITCO
// // itemName: kitchen pot
// // category: cooking
// // quantity: 3

ItemManager.update('KITCO', { quantity: 10 });
kitchenPotReporter.itemInfo();
// // logs
// // skuCode: KITCO
// // itemName: kitchen pot
// // category: cooking
// // quantity: 10
