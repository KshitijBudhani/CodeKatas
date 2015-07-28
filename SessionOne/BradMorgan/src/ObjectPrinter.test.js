var ObjectPrinter = require('./ObjectPrinter');
var expect = require('chai').expect;

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

describe('ObjectPrinter', function() {
  describe('Given a object', function() {
    var object;

    beforeEach(new BeforeEachContext(function() {
      object = {
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
      };
    }));

    describe("and a object printer with no sort function", function() {
      var objectPrinter;

      beforeEach(new BeforeEachContext(function() {
        objectPrinter = new ObjectPrinter();
      }));

      describe('when it prints the object', function() {
        var printedOutput;

        beforeEach(new BeforeEachContext(function() {
          printedOutput = objectPrinter.print(object);
        }));

        it("then it should have the correct output", function() {
          expect(printedOutput).to.equal(
            'id\n' +
            'created\n' +
            'employee\n' +
            '- id\n' +
            '- firstname\n' +
            '- employeeType\n' +
            '-- id\n' +
            '- lastname\n' +
            'location\n'
          )
        });
      });
    });

    describe("and a object printer with a alphabetical sort function", function() {
      var objectPrinter;

      beforeEach(new BeforeEachContext(function() {
        objectPrinter = new ObjectPrinter(ObjectPrinter.ALPHABETICAL_SORT);
      }));

      describe('when it prints the object', function() {
        var printedOutput;

        beforeEach(new BeforeEachContext(function() {
          printedOutput = objectPrinter.print(object);
        }));

        it("then it should have the correct output", function() {
          expect(printedOutput).to.equal(
            'created\n' +
            'employee\n' +
            '- employeeType\n' +
            '-- id\n' +
            '- firstname\n' +
            '- id\n' +
            '- lastname\n' +
            'id\n' +
            'location\n'
          )
        });
      });
    });
  });
});
