function Parser() {

}

function ParserIterator(stringToParse) {
  this.stringToParse = stringToParse;
  this.currentKey = "";
  this.objectStack = [];
  this.lastObject = null;
}

ParserIterator.prototype.parse = function() {
  for (var i = 0, iMax = this.stringToParse.length; i < iMax; i++){
    this.parseChar(this.stringToParse.charAt(i));
  }
  return this.lastObject;
};

ParserIterator.prototype.peek = function() {
  return this.objectStack[this.objectStack.length - 1];
};

ParserIterator.prototype.clearCurrentKey = function() {
  this.currentKey = "";
};

ParserIterator.prototype.addKey = function() {
  if (this.currentKey.length > 0) {
    this.peek()[this.currentKey] = null;
  }
  this.clearCurrentKey();
};

ParserIterator.prototype.addObject = function() {
  var newObject = {};
  if (this.objectStack.length > 0 && this.currentKey.length > 0) {
    this.peek()[this.currentKey] = newObject;
  }
  this.objectStack.push(newObject);
  this.clearCurrentKey();
};

ParserIterator.prototype.closeObject = function() {
  this.addKey(this.currentKey);
  this.lastObject = this.objectStack.pop();
  this.clearCurrentKey();
};

var FUNCTIONS_BY_CHAR = {};
FUNCTIONS_BY_CHAR[','] = ParserIterator.prototype.addKey;
FUNCTIONS_BY_CHAR['('] = ParserIterator.prototype.addObject;
FUNCTIONS_BY_CHAR[')'] = ParserIterator.prototype.closeObject;

ParserIterator.prototype.parseChar = function(char) {
  var charFunction = FUNCTIONS_BY_CHAR[char];
  if (charFunction) {
    charFunction.call(this);
  } else if (" " !== char) {
    this.currentKey += char;
  }
};

Parser.prototype.parse = function(stringToParse) {
  var parserIterator = new ParserIterator(stringToParse);
  return parserIterator.parse();
};

module.exports = Parser;
