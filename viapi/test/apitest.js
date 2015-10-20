var expect = require('chai').expect;
var Vi = require('../src/api.js');

describe('Vi API', function() {
  describe(' - basics - ', function(){
    it('should exist', function() {
      return expect(Vi).to.be.ok;
    });
    it('should be an object', function() {
      return expect(Vi).to.be.a('object');
    });
    it('should have an App constructor', function(){
      return expect(Vi.App).to.be.a('function');
    });
  });

  describe(' - instantiation -', function(){
    it('should allow new app creation with class', function(){
      var myApp = new Vi.App({});

      return expect(myApp).to.be.a('object');
    });
    it('should have a title', function(){
      var myApp = new Vi.App({
        title: 'My app'
      });

      return expect(myApp.title).to.equal('My app');
    });
    it('should have a commands object', function(){
      var myApp = new Vi.App({
        commands: {}
      });

      return expect(myApp.commands).to.be.a('object');
    });
    it('should have assigned command functions', function(){
      var myApp = new Vi.App({
        commands: {
          "run my app": function(err){
            /* Running App */
          }
        }
      });

      return expect(myApp.commands['run my app']).to.be.a('function');
    });
  });
});

describe('Helper Functions', function(){
  describe(' - attemptCommand - ', function(){
    var commands = {
      'hi': function(err) {
        return 'hi';
      },
      'hello $1': function(err, arg){
        return 'hello ' + arg;
      },
      'how is the $1 in $2': function(err, thing, place){
        return "The " + thing + " in " + place + " is great!";
      }
    };
    it('should return false if command not found', function(){
      return expect(Vi.helpers.attemptCommand('bye', commands)).to.equal(false);
    });
    it('should return value and invoke function if the command is found', function(){
      return expect(Vi.helpers.attemptCommand('hi', commands)).to.equal('hi');
    });
    it('should return correct value with argument', function(){
      return expect(Vi.helpers.attemptCommand('hello john', commands)).to.equal('hello john');
    });
    it('should return correct value with arguments', function(){
      return expect(Vi.helpers.attemptCommand('how is the weather in san francisco', commands)).to.equal('The weather in san francisco is great!');
    });
  });

  describe(' - inputToArgumentsArray - ', function(){
    var input = 'hey there john how are you doing in sf';
    var command = 'hey there $1 how are you doing in $2';
    it('should get an array of the final arguments', function(){
      var args = Vi.helpers.inputToArgumentsArray(command, input);
      expect(args).to.be.a('array');
      expect(args[0]).to.equal('john');
      expect(args[1]).to.equal('sf');
      return;
    });
  });
});
