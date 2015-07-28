var Parser = require('./Parser');
var expect = require('chai').expect;
var _ = require('lodash');

var BeforeEachContext = function(callback) {
  this.callback = callback;
  this.context = null;

  var that = this;
  return function() {
    if (that.context != this.currentTest.ctx) {
      that.context = this.currentTest.ctx;

      that.callback();
    }
  };
};

describe('Parser', function() {
  describe('Given a parser', function() {
    var parser;

    beforeEach(new BeforeEachContext(function() {
      parser = new Parser();
    }));

    describe('when it parses the string "(id,created,employee(id,firstname,employeeType(id), lastname),location)"', function() {
      var object;

      beforeEach(new BeforeEachContext(function() {
        object = parser.parse("(id,created,employee(id,firstname,employeeType(id), lastname),location)");
      }));

      it("then it should have the correct output", function() {
        expect(_.isEqual(object, {
          id: null,
          created: null,
          employee: {
            id: null,
            firstname: null,
            employeeType: {
              id: null
            },
            lastname: null },
          location: null
        })).to.be.true;
      });
    });
  });
});
