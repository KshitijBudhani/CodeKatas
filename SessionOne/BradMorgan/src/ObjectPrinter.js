function ObjectPrinter(keySortFunction) {
  this.keySortFunction = keySortFunction;
}

ObjectPrinter.ALPHABETICAL_SORT = function(a, b) {
  return a.localeCompare(b);
};

ObjectPrinter.prototype.print = function(object) {
  return this._print(object, 0);
};

ObjectPrinter.prototype._print = function(object, depth) {
  var key;
  var keys = this._getSortedKeys(object);
  var output = "";
  var depthString = this._getDepthString(depth);
  for (var i = 0, iMax = keys.length; i < iMax; i++) {
    key = keys[i];
    if (depth > 0) {
      output += depthString + " ";
    }
    output += key + "\n";
    if (null != object[key]) {
      output += this._print(object[key], depth + 1);
    }
  }
  return output;
};

ObjectPrinter.prototype._getSortedKeys = function(object) {
  var keys = Object.keys(object);
  if (this.keySortFunction) {
    keys.sort(this.keySortFunction);
  }
  return keys;
};

ObjectPrinter.prototype._getDepthString = function(depth) {
  var depthString = "";
  for (var i = 0; i < depth; i++) {
    depthString += "-";
  }
  return depthString;
};

module.exports = ObjectPrinter;
