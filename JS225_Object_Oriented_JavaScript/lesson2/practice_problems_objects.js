let invoices = {
  unpaid: [],
  paid: [],
  add(name, amount) {
    this.unpaid.push({name, amount});
  },
  total(invoices) {
    return invoices.reduce(((total, invoice) => total += invoice.amount), 0);
  },
  totalDue() {
    return this.total(this.unpaid);
  },
  totalPaid() {
    return this.total(this.paid);
  },
  payInvoice(name) {
    let notPaid = [];
    this.unpaid.forEach(invoice => {
      name === invoice.name ? this.paid.push(invoice) : notPaid.push(invoice);
    });
    this.unpaid = notPaid;
  },
};

invoices.add('DND', 250);
invoices.add('MI', 187.50);
invoices.add('SD', 300);
invoices.payInvoice('DND');
invoices.payInvoice('SD');
console.log(invoices.totalPaid());
console.log(invoices.totalDue());

