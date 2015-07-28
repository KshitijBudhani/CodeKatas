var Parser = require('./src/Parser');
var ObjectPrinter = require('./src/ObjectPrinter');

var stringToParse = "(id,created,employee(id,firstname,employeeType(id), lastname),location)";
var stringToParse2 = "(id,created,employee(id,firstname(mid),employeeType(id), lastname),location(lat,lon))";
var parser = new Parser();
var object1 = parser.parse(stringToParse);
var object2 = parser.parse(stringToParse2);

var printer = new ObjectPrinter();
var alphabeticalPrinter = new ObjectPrinter(ObjectPrinter.ALPHABETICAL_SORT);
console.log(printer.print(object1));
console.log("--------------\n");
console.log(printer.print(object2));
console.log("--------------\n");
console.log(alphabeticalPrinter.print(object1));
console.log("--------------\n");
console.log(alphabeticalPrinter.print(object2));
