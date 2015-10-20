var Vi = function(){
  Vi = {};
  /*----------  Appliction  ----------*/

  Vi.App = function(init){
    var app = {};

    app.title = init.title;
    app.commands = init.commands;

    app.run = function(phrase, voiceCB){
      console.log('Attempting to run command using phrase: ' + phrase);
      Vi.helpers.attemptCommand(phrase, app.commands, voiceCB);
    };

    app.speak = function(phrase){
      Vi.helpers.speak(phrase);
    };

    return app;
  };


  /*----------  Helpers  ----------*/
  /* Refactor these all out to closure scope, only on helpers for testing */

  Vi.helpers = {};

  Vi.helpers.speak = function(phrase){
    console.log(phrase);
  };

  Vi.helpers.attemptCommand = function(phrase, commands, voiceCB){
    /* iterate throught commands, see if there is a valid match */
    for (var key in commands){
      /* If key no arguments */
      if (!key.match(/\$/g)) {
        if (key === phrase) {
          return commands[key]('error', voiceCB);          
        }
      } else {
        /* If can gather arguments i.e. valid match */
        var args = Vi.helpers.inputToArgumentsArray(key, phrase);
        if(args){
          /* Add error as first argument always */
          args.unshift(voiceCB);
          args.unshift('error');
          return commands[key].apply(null, args);
        }
      }
    }

    return false;    
  };

  
  Vi.helpers.inputToArgumentsArray = function(command, input){

    /* Replaces $[0-9] spots with (.*) to be used as wildcards when string is converted to RegExp */
    var reg = new RegExp(command.replace(/\$[0-9]/g, "(.*)"));

    /* Gets arguments using that regex */
    var matches = input.match(reg);

    if (!matches) {
      return null;
    }

    /* Takes out full match at index 0  */
    var args = matches.slice(1, matches.length);
    
    return args;

  }; 

  return Vi;

}();

module.exports = Vi;